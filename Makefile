UNAME := $(shell uname)

BINS_SRC := $(wildcard bin/*)
BINS_DST := $(addprefix $(HOME)/,$(BINS_SRC))

DOT_SRC := $(wildcard dot/*)
DOT_DST := $(addprefix $(HOME)/.,$(notdir $(DOT_SRC)))

.PHONY: bins
bins: $(BINS_DST)
$(HOME)/bin/%: bin/%
	@ln -sn $(abspath $<) $@ 2>/dev/null || echo 'skipping $(<F), destination exists'

# On Mac, compile and install bin/app.
ifeq ($(UNAME),Darwin)
bins: $(HOME)/bin/app
bin/app: src/app.m
	$(CC) -framework Foundation -framework AppKit -o $@ $^
endif

.PHONY: dotfiles
dotfiles: $(DOT_DST)
$(HOME)/.%: dot/%
	@ln -sn $(abspath $<) $@ 2>/dev/null || echo 'skipping $(<F), destination exists'

.PHONY: clean
clean:
	rm bin/app
