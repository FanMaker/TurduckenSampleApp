//
//  RegionList.swift
//  Turducken
//
//  Created by Érik Escobedo on 20/06/22.
//

import SwiftUI
import CoreLocation
import FanMaker

struct RegionList : View {
    @StateObject var fanmaker = FanMakerViewModel()
    @State var showFanMakerUI = false
    @State var showFanMakerUI2 = false

    var body: some View {
        NavigationView {
            VStack {
                if fanmaker.beaconRegions1.isEmpty && fanmaker.beaconRegions2.isEmpty {
                    Text("No regions are being monitored")
                    Button("Fetch Regions", action: { fanmaker.updateRegions() })
                } else {
                    List(fanmaker.beaconRegions1) { region in
                        NavigationLink<RegionRow, BeaconList> {
                            BeaconList(beacons: region.beacons(), region: region)
                        } label: {
                            RegionRow(data: region)
                        }
                    }
                    .navigationTitle("Monitored Regions 1")

                    List(fanmaker.beaconRegions2) { region in
                        NavigationLink<RegionRow, BeaconList> {
                            BeaconList(beacons: region.beacons(), region: region)
                        } label: {
                            RegionRow(data: region)
                        }
                    }
                    .navigationTitle("Monitored Regions 2")
                }

                Button(action: {
                    // ------------------------------------------------------------------------------------------ >>>
                    // Set Custom FanMaker Identifiers
                    // ------------------------------------------------------------------------------------------
                    // let fanmakerIdentifiers: [String: Any] = [
                    //     "nfl_oidc": "1234-nfo-oidc",
                    //     "stephen_test": "123-is-a-test"
                    // ]
                    // let fanmakerIdentifiers: [String: Any] = [
                    //     "airship_channel_id": "7870978-airship-a0af9d780a9s7f07f"
                    // ]
                    // AppDelegate.fanmakerSDK1.setFanMakerIdentifiers(dictionary: fanmakerIdentifiers)
                    // ------------------------------------------------------------------------------------------ <<<

                    // ------------------------------------------------------------------------------------------ >>>
                    // Custom Loading Animation
                    // ------------------------------------------------------------------------------------------
                    // var images: [UIImage] = []

                    // // Start your sequence at 0 and end with the number of images you have
                    // for index in 0...89 {
                    //     // We expect the images to be in the Assets.xcassets catelog
                    //     if let image = UIImage(named: "loilty-loading00\(index)") {
                    //         images.append(image)
                    //     }
                    // }

                    // // Use `compactMap` to filter out any nil values from the array
                    // let nonNilImages = images.compactMap { $0 }

                    // // Check if there are any images before creating the animated image
                    // if !nonNilImages.isEmpty {
                    //     let gifImage = UIImage.animatedImage(with: nonNilImages, duration: 1.0)

                    //     // Unwrap the optional before passing it to FanMakerSDK
                    //     if let unwrappedGifImage = gifImage {
                    //         // If all has gone well, we can now pass the animated image to FanMakerSDK
                    //         AppDelegate.fanmakerSDK1.setLoadingForegroundImage(unwrappedGifImage)
                    //     }
                    // }
                    // ------------------------------------------------------------------------------------------ <<<

                    // ------------------------------------------------------------------------------------------ >>>
                    // Set Custom FanMaker Member ID
                    // ------------------------------------------------------------------------------------------
                    AppDelegate.fanmakerSDK1.setMemberID("Custom MemberID")
                    // ------------------------------------------------------------------------------------------ <<<

                    self.showFanMakerUI.toggle()
                }) {
                    Text("Show FanMaker UI")
                }

                Button(action: {
                    AppDelegate.fanmakerSDK2.setMemberID("Custom MemberID 2")
                    // ------------------------------------------------------------------------------------------ <<<

                    self.showFanMakerUI2.toggle()
                }) {
                    Text("Show FanMaker UI2")
                }.sheet(isPresented: $showFanMakerUI2) {
                    FanMakerSDKWebViewControllerRepresentable(sdk: AppDelegate.fanmakerSDK2)
                }
            }.onOpenURL { url in
                if AppDelegate.fanmakerSDK1.canHandleUrl(url) {
                    if AppDelegate.fanmakerSDK1.handleUrl(url) {
                        print("FanMaker handled the URL, opening the FanMaker UI")
                        self.isShowingFanMakerUI = true
                    } else {
                        print("FanMaker failed to handle the URL")
                    }

                } else {
                    print("FanMaker cannot handle the URL")
                }
            }.sheet(isPresented: $showFanMakerUI) {
                FanMakerSDKWebViewControllerRepresentable(sdk: AppDelegate.fanmakerSDK1)
            }
        }
    }
}

struct RegionList_Previews : PreviewProvider {
    static var previews: some View {
        RegionList().previewDevice(PreviewDevice(rawValue: "iPhone Xʀ"))
    }
}

