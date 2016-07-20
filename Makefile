# Configurations
.SUFFIXES:
.DELETE_ON_ERROR:
.SECONDARY:
.ONESHELL:
export SHELL := /bin/bash
export SHELLOPTS := pipefail:errexit:nounset:noclobber


JULIA := julia


# Tasks
.PHONY: all
.DEFAULT_GOAL := all
all:

.PHONY: check
check: test/runtests.jl.done


test/runtests.jl.done: test/runtests.jl src/PyProj.jl
	JULIA_LOAD_PATH="$(CURDIR)/src:$${JULIA_LOAD_PATH:-}" "$(JULIA)" $<
	touch $@
