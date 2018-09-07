#alias:new flushdns sudo killall -HUP mDNSResponder
fn flushdns [@_args]{ sudo killall -HUP mDNSResponder $@_args }
