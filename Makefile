_:
	@echo "Makefile"

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
