# SGInternetConnectionAlert.swift



A warning that shows as an alert automatically with animation when no internet connection. 

Also, hide automatically when the internet comes back.

```
SGInternetConnectionAlert.shared.enable = true  

//IF YOU NEED EXTRA CONFIGURATION
var config = SGInternetConnectionAlert.Configuration()
config.kBG_COLOR = UIColor.blue
SGInternetConnectionAlert.shared.config = config
```

## Also, Thanks to Reachability.swift

### Under MIT License
