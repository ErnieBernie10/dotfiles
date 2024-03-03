# my_custom_theme.zsh

# Check if the DISTROBOX environment variable is set
if [[ -n CONTAINER_ID ]]; then
    CONTAINER_ICON="%{$fg[green]%}■%{$reset_color%} "  # Docker container icon
else
    CONTAINER_ICON=""
fi

PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )$CONTAINER_ICON%{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Optionally, you can customize the CONTAINER_ICON based on your preference.
# For example, use a different icon for podman containers or customize the colors.
