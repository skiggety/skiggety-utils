export PATH="$ZEROTHLIFE_DIR/bin:$ZEROTHLIFE_CODE_DIR/bin:$PATH"

alias pause_windy_terminals="if zl-shellask wanna groom windows before pause; then zl-groom-terminal-window-locations --multiple 6;fi;zl-manually-reposition-windows"
alias zl-pause="zl-manually-reposition-windows"

alias cdzl="cd $ZEROTHLIFE_DIR"
alias cdzlc="cd $ZEROTHLIFE_CODE_DIR"

alias devall='zl-popup-all-code-dev'
alias dev_all='zl-popup-all-code-dev'

alias zf='zl-fork'
alias zlf='zl-fork'

alias zfp='zl-fork zl-pause'
alias zap='zl-fork zl-pause'

alias zfd='zl-fork-delegate'
alias zlfd='zl-fork-delegate'

alias zr='zl-brush-fully;zl-procrastinate 1'
alias zlr='zl-brush-fully;zl-procrastinate 1'
alias zl-remind-me-later='zl-brush-fully;zl-procrastinate 1'

alias metapuff='vw zl-puff;puff'
alias metapuffy='vw zl-puff;puffy'

alias thin-the-herd='zl-kill --quartermate --force zl-stress-test-screen-occupier'
alias small_nudge='NUDGE=1 zl-groom-terminal-window-locations --multiple 1'
alias reverse_nudge='NUDGE="-12" zl-groom-terminal-window-locations --multiple 1'
alias nudge='NUDGE=12 zl-groom-terminal-window-locations --multiple 1'
alias big_nudge='NUDGE=20 zl-groom-terminal-window-locations --multiple 15'
alias wipe='thin-the-herd;small_nudge'

alias brush='zl-groom-terminal-window-locations'
alias brushy='zl-fork "zl-size-terminal -n 8;sleep-verbose --vv 5;zl-groom-terminal-window-locations --multiple 10";exit 0'
alias brushalot='zl-fork "zl-size-terminal -n 8;zl-groom-terminal-window-locations --multiple 100"'
alias brush_fully='zl-brush-fully'
alias zfbf='zl-fork zl-brush-fully'

alias zl-ballast-windows='for num in 1 2 3;do zl-fork in_five_minutes ;done'

alias splash='zl-fork zl-groom-terminal-window-locations --multiple 1'
alias splashy='zl-fork zl-groom-terminal-window-locations --multiple 1;exit 0'

alias amoment="sleep-verbose 20"
alias a_moment="sleep-verbose 20"
alias inamoment="sleep-verbose 20 && exit 0"
alias in_a_moment="sleep-verbose 20 && exit 0"
alias inaminute="sleep-verbose 60 && echo y && exit 0"
alias in_a_minute="sleep-verbose 60 && echo y && exit 0"
alias in_five_minutes="sleep-verbose 300 && echo y && exit 0"

alias forkit="zl-fork-delegate && echo y && exit 0"
alias effit="zl-fork-delegate && echo y && exit 0"

alias zgy="zl-gamify && echo y && exit 0"
alias ziggy="zl-gamify && echo y && exit 0"

alias fzgy="zl-fork-gamify && echo y && exit 0"
alias effin-ziggy="zl-fork-gamify && echo y && exit 0"

alias zippy="zl-gamify --semi-urgent && echo y && exit 0"
alias effin-zippy="zl-fork-gamify --semi-urgent && echo y && exit 0"

alias zaggy="zl-gamify --urgent && echo y && exit 0"
alias omg-ziggy="zl-gamify --urgent && echo y && exit 0"
alias zuggy="zl-gamify --urgent && echo y && exit 0"

alias effin-zaggy="zl-fork-gamify --urgent && echo y && exit 0"
alias omg-effin-ziggy="zl-fork-gamify --urgent && echo y && exit 0"
alias effin-zuggy="zl-fork-gamify --urgent && echo y && exit 0"
