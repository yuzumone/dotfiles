ARG           :=
TOP_DIR       := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
PACKAGES      := $(TOP_DIR)/packages
DOTFILES      := $(TOP_DIR)/dotfiles
SRC_DIR       := $(TOP_DIR)/src
HOMEBREW_FILE := $(TOP_DIR)/Brewfile
.DEFAULT_GOAL := help

yay: ## Install yay.
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay && makepkg -si

brew: ## Install Homebrew.
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle -f $(HOMEBREW_FILE)

clean: ## Remove all symlink.
	@for f in $(shell cat $(DOTFILES) | xargs); do \
		dst=$$(echo "$$f" | cut -d ',' -f 2); \
		rm -vrf $(HOME)/"$$dst"; \
	done

install: ## Install package.
	$(call __require_ARG)
	$(call __exist_ARG)
	yay -S $(ARG)
	echo $(ARG) >> $(PACKAGES) && sort -o $(PACKAGES) $(PACKAGES)

sync: ## Sync package.
	yay -S --needed $(shell cat $(PACKAGES) | xargs)

add: ## Add dot file.
	$(call __require_ARG)
	$(eval TARGET := $(shell echo $(HOME)/.$(ARG)))
	$(eval TMP := $(shell echo $(ARG) | rev | cut -d '/' -f 1 | rev))
	$(eval DST := $(shell echo $(SRC_DIR)/$(TMP)))
	echo $(TMP),.$(ARG) >> $(DOTFILES) && sort -o $(DOTFILES) $(DOTFILES)
	mv $(TARGET) $(DST)
	ln -sfnv $(DST) $(TARGET)

link: ## Link all symlink.
	@for f in $(shell cat $(DOTFILES) | xargs); do \
		file=$$(echo "$$f" | cut -d ',' -f 1); \
		dst=$$(echo "$$f" | cut -d ',' -f 2); \
		ln -sfnv $(SRC_DIR)/"$$file" $(HOME)/"$$dst"; \
	done

help: ## Show this messages.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

define __require_ARG
	@bash -c "if [ '${ARG}' = '' ]; then echo 'ARG is not defined; you must specify ARG like $$ make ARG=xxx task'; exit 1; fi"
endef

define __exist_ARG
	@bash -c 'if grep -E "^$(ARG)$$" $(PACKAGES)>/dev/null; then echo "Already install: ${ARG}"; exit 1; fi'
endef
