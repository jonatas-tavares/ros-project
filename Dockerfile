FROM jontavpess/ros-project-image-base

RUN apt -y install git-all gedit

ENV DISPLAY=host.docker.internal:0.0

COPY ./bootstrap.sh /

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "export SVGA_VGPU10=0" >> ~/.bashrc

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

CMD /bin/bash -c "/bootstrap.sh"