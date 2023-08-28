function alert
  if command -v notify-send > /dev/null
    # Credits to: https://gist.github.com/Feniksovich
    # Add an "alert" alias for long running commands.  Use like so:
    #   sleep 10; alert
    notify-send --urgency=low -i \
      (if test $status = 0; echo terminal; else; echo error; end) \
      (history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//') \
      ;
  end
end
