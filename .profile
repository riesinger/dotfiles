#!/bin/sh
# NOTE: Only the configuration applying to BOTH, zsh and bash should go here.

# Locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="${GOPATH}/bin"

export PATH="${XDG_DATA_HOME}/bin:${GOBIN}:${XDG_DATA_HOME}/cargo/bin:/usr/local/sbin:/usr/local/bin:${PATH}:${HOME}/.local/bin"

# General
export LC_ALL=en_US.UTF-8
export LC_TYPE=UTF-8

# Programs
export EDITOR='nvim'
export VISUAL="$EDITOR"

# Cleanup the home directory a bit
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export LESSHISTFILE=-
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export FASD_DATA="$XDG_CACHE_HOME/fasd"
