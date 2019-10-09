DOTFILES := $(wildcard .*)
EXCLUDE = . .. .git .gitignore Makefile
DOTFILES := $(filter-out $(EXCLUDE), $(DOTFILES))

install: link plug-install

uninstall: plug-uninstall unlink

link:
	$(foreach DOTFILE, $(DOTFILES), ln -s dotfiles/$(DOTFILE) ~/$(DOTFILE);)

unlink:
	$(foreach DOTFILE, $(DOTFILES), rm -f ~/$(DOTFILE);)

plug-install:
	vim +PlugInstall
	nvim +PlugInstall

plug-uninstall:
	rm -rf ~/.vim
