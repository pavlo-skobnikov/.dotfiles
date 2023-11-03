#!/usr/bin/env bash

# Get a list of tmux sessions and extract their names
session_list=$(tmux list-sessions | cut -f 1 -d ":" | fzf)

# Check if a session is selected
if [ -n "$session_list" ]; then
  # Switch to the selected session
  tmux switch-client -t "$session_list"
fi
