DOTFILES := $(wildcard .*)
EXCLUDE = . .. .git .gitignore Makefile
DOTFILES := $(filter-out $(EXCLUDE), $(DOTFILES))

install: link vundle-install

uninstall: vundle-uninstall unlink

link:
	$(foreach DOTFILE, $(DOTFILES), ln -s dotfiles/$(DOTFILE) ~/$(DOTFILE);)

unlink:
	$(foreach DOTFILE, $(DOTFILES), rm -f ~/$(DOTFILE);)

vundle-install:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

vundle-uninstall:
	rm -rf ~/.vim
