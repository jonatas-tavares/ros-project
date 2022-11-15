#!/bin/bash

echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

source ~/.bashrc

mkdir -p ~/catkin_ws/src

cd ~/catkin_ws/src

catkin_init_workspace

cd ~/catkin_ws

catkin_make

echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

source ~/.bashrc

cd ~/catkin_ws/src

git clone https://github.com/DaniFavoreto/IC-Faperj.git p3dxbot

cd ~/catkin_ws/

catkin_make

cd ~/catkin_ws/src/p3dxbot/src/scripts/
chmod +x gen_map_csv.py 
chmod +x gen_odom_csv.py 
chmod +x p3dxbot_goal.py 
chmod +x p3dx_teleop_key.py
cd ~

exec "$@"

#while :; do sleep 2073600; done

# echo source /opt/ros/melodic/setup.bash \
# && source /root/.bashrc \
# && mkdir -p /root/catkin_ws/src \
#  cd /root/catkin_ws/src \
# catkin_init_workspace \
#  cd /root/catkin_ws \
# catkin_make'