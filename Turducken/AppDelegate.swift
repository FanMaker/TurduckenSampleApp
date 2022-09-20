//
//  AppDelegate.swift
//  Turducken
//
//  Created by Érik Escobedo on 19/05/21.
//

import SwiftUI
import FanMaker
import CoreLocation

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FanMakerSDK.initialize(apiKey: "bb460452f81404b2cdf8d5691714115bb1b25905d337cc4ea50c89f327d7209d")
        
        return true
    }
}
