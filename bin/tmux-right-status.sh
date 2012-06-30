#!/usr/bin/env bash

battery=`~/dotfiles/tmux/segments/battery_mac.sh`
weather=`~/dotfiles/tmux/segments/weather.sh`


echo -n "#[fg=colour137]⮂#[fg=colour127,bg=colour137,nobold] $battery #[fg=colour37]⮂#[fg=colour255,bg=colour37,nobold] $weather ⮂#[fg=colour16,bg=colour254,bold] #h "
