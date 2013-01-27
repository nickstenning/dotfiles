careful_link () {
  local SRC=$1
  local DST=$2
  if [ -e "$DST" ] && [ ! -h "$DST" ]; then
    echo "${DST} exists and not a symlink, skipping..." >&2
  else
    ln -snf "$SRC" "$DST"
  fi
}
