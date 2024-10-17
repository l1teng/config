_:
	@echo "Makefile"

clean-home-dotfile:
	@rm -rf $(HOME)/.zsh_history
	@rm -rf $(HOME)/.python_history
	@rm -rf $(HOME)/.lesshst
undo-symlink-cfg:
	@rm -rf $(HOME)/.zshenv
	@rm -rf $(HOME)/.vim
symlink-cfg: clean-home-dotfile undo-symlink-cfg
	@ln -sf $(HOME)/.config/zsh/zshenv $(HOME)/.zshenv
	@ln -sf $(HOME)/.config/vim $(HOME)/.vim

clean-all-cache: clean-conda-cache clean-go-cache clean-homebrew-cache clean-npm-cache clean-pip-cache clean-xray-cache
clean-conda-cache:
	@rm -rf ~/.config/conda/cache/*
clean-go-cache:
	@rm -rf ~/.config/go/cache/*
clean-homebrew-cache:
	@rm -rf ~/.config/homebrew/cache/*
clean-npm-cache:
	@rm -rf ~/.config/npm/cache/*
clean-pip-cache:
	@rm -rf ~/.config/pip/cache/*
clean-tor-cache:
	@echo "" > ~/.config/tor/cache/acc
	@echo "" > ~/.config/tor/cache/err
clean-xray-cache:
	@echo "" > ~/.config/xray/cache/acc
	@echo "" > ~/.config/xray/cache/err
