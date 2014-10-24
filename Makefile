UNAME := $(shell uname)
TARGETS := dotfiles

ifeq ($(UNAME),Darwin)
	TARGETS += bin/app
endif

all: $(TARGETS)

dotfiles:
	dot/install

bin/app: src/app.m
	$(CC) -framework Foundation -framework AppKit -o $@ $^

clean:
	rm -f $(TARGETS)

.PHONY: all clean dotfiles
