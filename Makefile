_:
	@echo "Makefile"

clean-all-cache: clean-conda-cache clean-go-cache clean-homebrew-cache clean-npm-cache clean-pip-cache clean-xray-cache
clean-conda-cache:
	@rm -rf conda/cache/*
clean-go-cache:
	@rm -rf go/cache/*
clean-homebrew-cache:
	@rm -rf homebrew/cache/*
clean-npm-cache:
	@rm -rf npm/cache/*
clean-pip-cache:
	@rm -rf pip/cache/*
clean-xray-cache:
	@rm -rf xray/cache/*
