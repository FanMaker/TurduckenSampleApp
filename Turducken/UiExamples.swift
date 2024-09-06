//
//  UiExamples.swift
//  Turducken
//
//  Created by Érik Escobedo on 20/06/22.
//

import SwiftUI
import CoreLocation
import FanMaker
import SlidingTabView

struct UiExamples : View {
    @State private var tabIndex = 0

    var body: some View {
        SlidingTabView(selection: $tabIndex,
                       tabs: ["Standard", "SDK 1", "SDK 2"],
                       animation: .easeInOut,
                       activeAccentColor: .blue,
                       selectionBarColor: .blue)
        Spacer()

        switch tabIndex {
        case 1:
            FanMakerSDKWebViewControllerRepresentable(sdk: AppDelegate.fanmakerSDK1)
        case 2:
            HalfPage()
        default:
            RegionList()
        }

        Spacer()
    }
}
