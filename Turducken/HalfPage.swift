//
//  HalfPage.swift
//  Turducken
//
//  Created by Érik Escobedo on 20/06/22.
//

import SwiftUI
import CoreLocation
import FanMaker
import WebKit

struct HalfPage : View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple]
    @State private var showSheet: Bool = true
    let height: CGFloat = UIScreen.main.bounds.height * 0.85
    
    var body: some View {
        ScrollView {
            HStack {
                ForEach(colors, id: \.self) { color in
                    Rectangle()
                        .fill(color)
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                }
            }.frame(height: 500)
            FanMakerSDKWebViewControllerRepresentable(sdk: AppDelegate.fanmakerSDK2)
              .frame(maxWidth: .infinity, minHeight: height)
        }
    }
}
