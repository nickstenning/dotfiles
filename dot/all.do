HERE=$(pwd)

find . -maxdepth 1 -name '_*' | while read filename; do
  SRC="${HERE}/${filename##./}"
  DEST="${HOME}/.${filename##./_}"
  if [ -r "${DEST}" ] && [ ! -h "${DEST}" ]; then
    echo "${DEST} exists and not a symlink, skipping..." >&2
  else
    ln -snf ${SRC} ${DEST}
  fi
done