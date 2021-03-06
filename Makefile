.PHONY: build test run clean stop check-style run-unit emojis help

BUILD_SERVER_DIR = ../mattermost-server
EMOJI_TOOLS_DIR = ./build/emoji

check-style: node_modules ## Checks JS file for ESLint confirmity
	@echo Checking for style guide compliance

	npm run check

test: node_modules ## Runs tests
	@echo Running jest unit/component testing

	npm run test

node_modules: package.json package-lock.json
	@echo Getting dependencies using npm

	npm install

package: build ## Packages app
	@echo Packaging webapp

	mkdir tmp
	mv dist tmp/client
	tar -C tmp -czf mattermost-webapp.tar.gz client
	mv tmp/client dist
	rmdir tmp

build: node_modules ## Builds the app
	@echo Building mattermost Webapp

	rm -rf dist

	npm run build

run: node_modules ## Runs app
	@echo Running mattermost Webapp for development

	npm run run &

run-fullmap: node_modules ## Runs the app with the JS mapped to source (good for debugger)
	@echo FULL SOURCE MAP Running mattermost Webapp for development FULL SOURCE MAP

	npm run run-fullmap &

stop: ## Stops webpack
	@echo Stopping changes watching

ifeq ($(OS),Windows_NT)
	wmic process where "Caption='node.exe' and CommandLine like '%webpack%'" call terminate
else
	@for PROCID in $$(ps -ef | grep "[n]ode.*[w]ebpack" | awk '{ print $$2 }'); do \
		echo stopping webpack watch $$PROCID; \
		kill $$PROCID; \
	done
endif

restart: | stop run ## Restarts the app

clean: ## Clears cached; deletes node_modules and dist directories
	@echo Cleaning Webapp

	rm -rf dist
	rm -rf node_modules
	rm -rf .volumes

emojis: ## Creates emoji JSX file and extracts emoji images from the system font
	gem install bundler
	bundle install --gemfile=$(EMOJI_TOOLS_DIR)/Gemfile
	BUNDLE_GEMFILE=$(EMOJI_TOOLS_DIR)/Gemfile bundle exec $(EMOJI_TOOLS_DIR)/make-emojis

## Help documentatin à la https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.volumes:
	mkdir -p .volumes/app/mattermost/config
	mkdir -p .volumes/app/mattermost/data
	mkdir -p .volumes/app/mattermost/logs
	mkdir -p .volumes/app/mattermost/plugins
	mkdir -p .volumes/db/var/lib/postgresql/data

.PHONY: start-stack stop-stack scaffold reset

start-stack: .volumes
	docker-compose up

stop-stack:
	docker-compose down

APP_CONTAINER_NAME:=mattermost-webapp_app_1
VM_CMD:=docker exec -it $(APP_CONTAINER_NAME) mattermost
TEAM:=theteam
PASSWORD:=password

scaffold:
	$(VM_CMD) user create --email admin@example.com --system_admin --username admin --password $(PASSWORD)
	$(VM_CMD) user create --email one@example.com --username one --password $(PASSWORD)
	$(VM_CMD) user create --email two@example.com --username two --password $(PASSWORD)
	$(VM_CMD) team create --name $(TEAM) --display_name "The Team"
	$(VM_CMD) team add $(TEAM) admin one two
	$(VM_CMD) channel create --team $(TEAM) --name channelone --display_name "Channel One" --private
	$(VM_CMD) channel add $(TEAM):channelone one two
	@echo
	@echo "Login with users 'one', 'two', or 'admin'. Password is '$(PASSWORD)' for all of them"
	@echo "A channel with ID 'channelone' is created and users 'one' and 'two' are added to it."

reset:
	$(VM_CMD) reset
