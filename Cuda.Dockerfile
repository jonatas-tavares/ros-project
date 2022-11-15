FROM nvidia/cudagl:11.4.2-devel-ubuntu18.04

ENV DISTRO_CODENAME bionic

RUN apt-get update
RUN apt update
RUN apt -y install curl gnupg2
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu ${DISTRO_CODENAME} main" > /etc/apt/sources.list.d/ros-melodic.list'

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update 

RUN DEBIAN_FRONTEND=noninteractive TZ=America/Sao_Paulo apt-get -y install ros-melodic-desktop-full 
RUN DEBIAN_FRONTEND=noninteractive TZ=America/Sao_Paulo apt-get -y upgrade 

RUN apt-get -y install ros-melodic-depthimage-to-laserscan 
RUN apt-get -y install ros-melodic-slam-gmapping 
RUN apt-get -y install ros-melodic-rtabmap-ros 
RUN apt-get -y install ros-melodic-navigation 
RUN apt-get -y install ros-melodic-explore-lite 

RUN apt -y install git-all gedit

ENV DISPLAY=host.docker.internal:0.0

COPY ./bootstrap.sh /

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc
# RUN echo "export SVGA_VGPU10=0" >> ~/.bashrc

#########################################################################

# nvidia-docker hooks
# LABEL com.nvidia.volumes.needed="nvidia_driver"
# ENV PATH /usr/local/nvidia/bin:${PATH}
# ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ENV QT_X11_NO_MITSHM=1

##############################################################################

CMD /bin/bash -c "/bootstrap.sh"