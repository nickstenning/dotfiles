del_stopped () {
  local name=$1
  local state=$(docker inspect --format "{{.State.Running}}" "$name" 2>/dev/null)
  if [ "$state" = "false" ]; then
    docker rm "$name"
  fi
}

chrome () {
  del_stopped chrome

  docker run -d \
    --net host \
    --security-opt seccomp=unconfined \
    --cpuset-cpus 0 \
    --memory 512mb \
    -v /var/run/dbus:/var/run/dbus \
    -v /etc/machine-id:/etc/machine-id:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/hosts:/etc/hosts:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v $HOME/Downloads:/home/nick/Downloads \
    -v $HOME/.config:/home/nick/.config \
    -v /dev/shm:/dev/shm \
    --device /dev/snd \
    --device /dev/dri \
    --device /dev/video0 \
    --group-add audio \
    --group-add video \
    --name chrome \
    nickstenning/chrome
}

cloud-station-drive () {
  del_stopped cloud-station-drive

  docker run -d \
    -v /var/run/dbus:/var/run/dbus \
    -v /etc/machine-id:/etc/machine-id:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=unix${DISPLAY}" \
    -v "${HOME}/.config/CloudStation:/home/nick/.CloudStation" \
    -v "${HOME}/Dropbox:/home/nick/Dropbox" \
    --name cloud-station-drive \
    nickstenning/cloud-station-drive
}

slack () {
  del_stopped slack

  docker run -d \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=unix${DISPLAY}" \
    --device /dev/snd \
    --device /dev/dri \
    --device /dev/video0 \
    --group-add audio \
    --group-add video \
    -v "${HOME}/.config/Slack:/home/nick/.config/Slack" \
    --ipc="host" \
    --name slack \
    nickstenning/slack "$@"
}
