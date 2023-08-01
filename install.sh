#!/bin/bash

# Install sexy-bash-prompt
(cd /tmp && ([[ -d sexy-bash-prompt ]] || git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt) && cd sexy-bash-prompt && make install) && source ~/.bashrc

stow astronvim
stow wezterm
stow bash
