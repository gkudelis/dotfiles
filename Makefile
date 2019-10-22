DOTFILES := $(wildcard *)
EXCLUDE = Makefile
DOTFILES := $(filter-out $(EXCLUDE), $(DOTFILES))

install: link plug-install

uninstall: plug-uninstall unlink

link:
	$(foreach DOTFILE, $(DOTFILES), stow --no-folding $(DOTFILE);)

unlink:
	$(foreach DOTFILE, $(DOTFILES), stow --delete --no-folding $(DOTFILE);)

plug-install:
	nvim +PlugInstall +UpdateRemotePlugins +qa

plug-uninstall:
	rm -rf ~/.config/nvim/plugged
