.PHONY: build

ARCH := $(shell uname -m)
PLATFORM :=

ifeq ($(ARCH),arm64)
PLATFORM := --platform=linux/arm64
endif

build:
	docker build . $(PLATFORM) -t puppeteer:22.0.0