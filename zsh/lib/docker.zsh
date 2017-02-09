del_stopped () {
  local name=$1
  local state=$(docker inspect --format "{{.State.Running}}" "$name" 2>/dev/null)
  if [ "$state" = "false" ]; then
    docker rm "$name"
  fi
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
