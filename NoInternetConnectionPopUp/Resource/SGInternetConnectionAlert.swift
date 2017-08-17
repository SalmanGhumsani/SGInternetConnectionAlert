//
//  SGInternetConnectionAlert.swift
//  NoInternetConnectionPopUp
//
//  Created by Salman Ghumsani  on 16/08/17.
//  Copyright © 2017 Salman Ghumsani . All rights reserved.
//

import UIKit

public class SGInternetConnectionAlert: NSObject {
    
    //Configuration
    public struct Configuration {
        var kALERT_TEXT             =   "NO INTERNET CONNECTION"
        var kBG_COLOR:UIColor       =   UIColor.red
        var kFONT:UIFont            =   UIFont.boldSystemFont(ofSize: 12)
        var kALERT_HEIGHT           =   15
        var kTEXT_COLOR             =   UIColor.white
        var kANIMATION_DURATION     =   0.5
        var kYPOSITION              =   64
        public init() {}
        
    }
    
    public var config:Configuration = Configuration(){
        didSet {
            lblAlert.text = config.kALERT_TEXT
            lblAlert.backgroundColor = config.kBG_COLOR
            lblAlert.font = config.kFONT
            lblAlert.textColor = config.kTEXT_COLOR
            setupAlert()
        }
    }
    
    static let shared = SGInternetConnectionAlert()
    var enableDebugging = true
    let reachability = Reachability()!
    let lblAlert = UILabel()
    
    override init() {
        super.init()
    }
    
    open var enable = false {
        didSet {
            if enable == true {
                setupInternetReachability()
                setupAlert()
                showLog("enable")
            }else {
                showLog("Disable")
            }
        }
    }
    
    private func stopRechability() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
    
    private func setupInternetReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            showLog("Unable to start notifier")
        }
    }
    
    func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                self.hideAlert()
                showLog("Reachable via WiFi")
            } else {
                self.hideAlert()
                showLog("Reachable via Cellular")
            }
        } else {
            self.showAlert()
            showLog("Network not reachable")
        }
    }
    
    
    
    private func showAlert() {
        let destinatioRect = CGRect(x: 0, y: 64, width: Int(UIScreen.main.bounds.width), height: config.kALERT_HEIGHT)
        UIView.animate(withDuration: config.kANIMATION_DURATION, animations: {
            self.lblAlert.frame = destinatioRect
        }) { (success) in
            if success {
            
            }
        }
    }

    private func hideAlert() {
        let destinatioRect = CGRect(x: 0, y: config.kYPOSITION, width: Int(UIScreen.main.bounds.width), height: 0)
        UIView.animate(withDuration: config.kANIMATION_DURATION) {
            self.lblAlert.frame = destinatioRect
        }
    }
    
    private func setupAlert() {
        lblAlert.frame = CGRect(x: 0, y: config.kYPOSITION, width: Int(UIScreen.main.bounds.width), height: 0)
        lblAlert.text = config.kALERT_TEXT
        lblAlert.backgroundColor = config.kBG_COLOR
        lblAlert.textColor = config.kTEXT_COLOR
        lblAlert.font = config.kFONT
        lblAlert.textAlignment = .center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let currentWindow = UIApplication.shared.keyWindow {
                self.lblAlert.removeFromSuperview()
                currentWindow.addSubview(self.lblAlert)
            }
        }
    }
    
    private func showLog(_ logString:String) {
        if enableDebugging {
            print("SGInternetConnectionAlert: ",logString)
        }
    }
}
