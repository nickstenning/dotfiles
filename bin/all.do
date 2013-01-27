redo-ifchange ../util.sh
redo-ifchange app

. ../util.sh
mkdir -p ~/local
careful_link "$(pwd)" ~/local/bin
