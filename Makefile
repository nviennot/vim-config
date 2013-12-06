DOTFILES = $(HOME)/.vimrc $(HOME)/.gvimrc
MINEFILES = vimrc.mine gvimrc.mine
ME ?= example
TARGETS = $(DOTFILES) $(MINEFILES)
SHELL = /bin/bash
CWD = $(shell pwd)

define check_file
	@if [[ -e $1 && "$(OVERWRITE)" != "1" ]]; then \
		echo "make install won't overwrite $1"; \
		echo "1) remove it yourself or 2) use 'make install OVERWRITE=1'"; \
		false \
	else true; \
	fi
endef

all:
	@echo type make install.

clearfiles =
ifeq ($(OVERWRITE),1)
  clearfiles += clean_mine
endif

clean_mine:
	rm -f $(MINEFILES)

%.mine: %.mine.$(ME)
	$(call check_file,$@)
	@echo Using $(ME) $* file
	@cp $< $@

$(HOME)/.%: %
	$(call check_file,$@)
	ln -fs $(PWD)/$< $@

install: $(clearfiles) $(TARGETS)
	git submodule update --init

update:
	git pull
	git submodule sync
	git submodule update --init

.PHONY: install update clean_mine
