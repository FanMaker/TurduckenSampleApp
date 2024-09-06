//
//  TurduckenApp.swift
//  Turducken
//
//  Created by Érik Escobedo on 14/05/21.
//

import SwiftUI

@main
struct TurduckenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RegionList()
            //UiExamples()
        }
    }
}
