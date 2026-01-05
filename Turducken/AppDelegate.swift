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
    static var fanmakerSDK1: FanMakerSDK!
    static var fanmakerSDK2: FanMakerSDK!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let fanmakerSDK1 = FanMakerSDK()
        fanmakerSDK1.initialize(apiKey: "<API_KEY_1>")

        AppDelegate.fanmakerSDK1 = fanmakerSDK1
        AppDelegate.fanmakerSDK1.enableLocationTracking()

        let fanmakerSDK2 = FanMakerSDK()
        fanmakerSDK1.initialize(apiKey: "<API_KEY_2>")

        AppDelegate.fanmakerSDK2 = fanmakerSDK2
        AppDelegate.fanmakerSDK2.disableLocationTracking()

        return true
    }
}
