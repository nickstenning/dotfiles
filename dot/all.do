redo-ifchange ../util.sh tolink

. ../util.sh

while read filename; do
  SRC="$(pwd)/${filename}"
  DST="${HOME}/.${filename#_}"
  echo "linking $SRC to $DST" >&2
  careful_link "$SRC" "$DST"
done <tolink
