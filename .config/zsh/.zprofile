#!/bin/sh

# Locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="${GOPATH}/bin"

export PATH="${XDG_DATA_HOME}/bin:${GOBIN}:${XDG_DATA_HOME}/cargo/bin:${HOME}/.local/bin:${PATH}"

# Programs
export EDITOR='nvim'
export VISUAL="$EDITOR"
export LESS=-R

# ~/ Cleanup
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export LESSHISTFILE=-
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export FASD_DATA="$XDG_CACHE_HOME/fasd"