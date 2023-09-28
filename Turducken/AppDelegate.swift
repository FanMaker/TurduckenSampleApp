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
        FanMakerSDK.initialize(apiKey: "")
        
        return true
    }
}
