#alias:new server python3 -m http.server 80
fn server [@_args]{ python3 -m http.server 80 $@_args }
