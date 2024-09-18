# Allow X server to be accessed from the local machine
xhost +local:

# Container name
CONTAINER_NAME="lio_sam"

# Run the Docker container
docker run --privileged -itd \
        --gpus all \
        -e NVIDIA_DRIVER_CAPABILITIES=all \
        -e NVIDIA_VISIBLE_DEVICES=all \
        --volume=/home/ys/Downloads/bag_data:/root/data \
        --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume=/etc/localtime:/etc/localtime:ro \
        --volume=/dev:/dev \
        --device=/dev/dri \
        --net=ros-network \
        --ipc=host \
        --name="$CONTAINER_NAME" \
        --env="DISPLAY=$DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        -v $(realpath .):/root/catkin_ws/src/LIO-SAM \
        -w /root/catkin_ws/ \
        lio-sam-noetic