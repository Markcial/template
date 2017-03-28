function template -S -d "Templating on your terminal"
  set -lx buffer
  getopts $argv | while read -l key value
    switch $key
      case _
        set buffer $value
      case f file
        # check for file
        set buffer (cat $value)
      case h help
        echo usage
        return
    end
  end

  begin
    set -l template $buffer
    set -l MATCH_EXPRESSION "{[{@=]/?[^}]+}?}"
    set -l ESCAPE_START_BLOCK "@\s*escape\s*"
    set -l ESCAPE_END_BLOCK "@/\s*escape\s*"
    set -l EXECUTION_BLOCK "=[^}]+"
    set -l ECHO_BLOCK "{\s*[\w\d-_]+\s*}"

    set -l ESCAPE_ENABLED 0

    set matches (string match -r -a $MATCH_EXPRESSION $template)
    for match in $matches
      if string match -r -q $ESCAPE_START_BLOCK $match
        set ESCAPE_ENABLED 1
        set template (string replace $match '' $template)
      end

      if string match -r -q $ESCAPE_END_BLOCK $match
        set ESCAPE_ENABLED 0
        set template (string replace $match '' $template)
      end

      if string match -r -q $EXECUTION_BLOCK $match
        set -l cmd (string trim -c "{}=" $match)
        begin
          fish -c $cmd
        end | read -z result
        set template (string replace $match $result $template)
      end

      if test $ESCAPE_ENABLED -eq 1
        continue
      end

      if string match -r -q $ECHO_BLOCK $match
        set -l variable (string trim -c "{} " $match)
        if not set -q $variable
          echo Missing variable $variable
          return 1
        end

        set template (string replace $match $$variable $template)
      end
    end
    printf "%s\n" $template
  end
end
