# SGInternetConnectionAlert
A warning that shows an alert automatically with animation when no internet connection also hide automatically when the internet comes back.

SGInternetConnectionAlert.shared.enable = true
        
//IF YOU NEED EXTRA CONFIGURATION
var config = SGInternetConnectionAlert.Configuration()
config.kBG_COLOR = UIColor.blue
SGInternetConnectionAlert.shared.config = config
