FROM osrf/ros:noetic-desktop-full

# path of LIO-SAM folder
ENV LIO_SAM_PATH=/home/ys/Downloads/slam/LIO-SAM

RUN apt-get update \
    && apt-get install -y curl \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && apt-get update \
    && apt-get install -y ros-noetic-navigation \
    && apt-get install -y ros-noetic-robot-localization \
    && apt-get install -y ros-noetic-robot-state-publisher \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:borglab/gtsam-release-4.0 \
    && apt-get update \
    && apt install -y libgtsam-dev libgtsam-unstable-dev \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN mkdir -p ~/catkin_ws/src \
COPY $LIO_SAM_PATH ~/catkin_ws/src 
RUN cd ~/catkin_ws \
    && source /opt/ros/noetic/setup.bash \
    && catkin_make

RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc \
    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

WORKDIR /root/catkin_ws
