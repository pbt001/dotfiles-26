#alias:new ip dig +short myip.opendns.com @resolver1.opendns.com
fn ip [@_args]{ dig +short myip.opendns.com @resolver1.opendns.com $@_args }
