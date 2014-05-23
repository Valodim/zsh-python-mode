# these four lines are all you need for a basic setup
fpath+=( ${0:h:A} )
autoload -U zpy-enable
zle -N zpy-enable
bindkey '^P' zpy-enable

# simple use of hooks to replace the prompt while in zpy mode
+zpy-enter () {
    (( _ZPY_ON )) || return
    typeset -gH _ZPY_OLDPROMPT=$PROMPT
    PROMPT="%F{green}py> %f"
}
+zpy-leave () {
    # only if zpy context is enabled (just making sure)
    (( _ZPY_ON )) && return
    [[ -n $_ZPY_OLDPROMPT ]] || return
    PROMPT=$_ZPY_OLDPROMPT
    _ZPY_OLDPROMPT=
    return 0
}
# set up hooks for the functions above
zstyle ':zpy:hooks:enter' hooks enter
zstyle ':zpy:hooks:leave' hooks leave
autoload -U add-zsh-hook && add-zsh-hook precmd +zpy-leave


# alternative hook, works with my powerline prompt
# +prompt-zpy () {
#     (( _ZPY_ON )) && prompt_bits+=( "%K{10}$sep1%F{10}" )
#     return 0
# }
# +zpy-powerline-reset () {
#     prompt_powerline_precmd
#     PROMPT="%F{green}py >%f"
# }
# zstyle ':zpy:hooks:enter' hooks powerline-reset
# zstyle ':zpy:hooks:leave' hooks powerline-reset
# # don't override other styles with our own - add it to the list!
# () {
#     local hooks
#     zstyle -a ':prompt:*:ps1' precmd-hooks hooks
#     zstyle ':prompt:*:ps1' precmd-hooks $hooks +prompt-zpy
# }
