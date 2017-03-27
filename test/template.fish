test "$BASENAME should display unmodified template"
  (template "some string") = "some string"
end

test "$BASENAME should replace a simple variable"
  (set -lx foo bar; template "this is {{foo}}") = 'this is bar'
end

test "$BASENAME should replace a variable with spaces"
  (set -lx foo bar; template "this is {{ foo }}") = 'this is bar'
end

test "$BASENAME should replace many variables"
  (
    set -lx foo bar;
    set -lx bar foo;
    template "this is {{ foo }} and this {{bar}}") = 'this is bar and this foo'
end

test "$BASENAME should deactivate templating"
  (
    set -lx renders "templates"
    template "this {{renders}}{@escape} this {{not}}{@/escape}"
  ) = "this templates this {{not}}"
end
