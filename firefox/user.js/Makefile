_: update_config_macos

PROFILE_DIR ?= $(HOME)/Archives/AppData/Firefox/default-profile

kill_macos:
	@pkill firefox

update_userjs_macos:
	./updater.sh -se

clean_prefjs_macos: kill_macos
	cd $(PROFILE_DIR) && ./prefsCleaner.sh -s

update_config_macos: update_userjs_macos clean_prefjs_macos
