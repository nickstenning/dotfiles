if [ "$(uname)" = "Darwin" ]; then
  cc -framework Foundation -framework AppKit -o "$3" ../src/app.m
fi
