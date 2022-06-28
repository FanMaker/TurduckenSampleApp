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
        FanMakerSDK.initialize(apiKey: "4f2850e4b6fd2f4b4030b3d545e4dd7052e2ee366f9d09d9b061932023f31011")
        
        return true
    }
}
