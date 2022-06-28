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
    
    var body: some View {
        NavigationView {
            VStack {
                if fanmaker.beaconRegions.isEmpty {
                    Text("No regions are being monitored")
                    Button("Fetch Regions", action: { fanmaker.updateRegions() })
                } else {
                    List(fanmaker.beaconRegions) { region in
                        NavigationLink<RegionRow, BeaconList> {
                            BeaconList(beacons: region.beacons(), region: region)
                        } label: {
                            RegionRow(data: region)
                        }
                    }
                    .navigationTitle("Monitored Regions")
                }
                
                Button(action: {
                    self.showFanMakerUI.toggle()
                }) {
                    Text("Show FanMaker UI")
                }.sheet(isPresented: $showFanMakerUI) {
                    FanMakerSDKWebViewControllerRepresentable()
                }
            }
        }
        
    }
}

struct RegionList_Previews : PreviewProvider {
    static var previews: some View {
        RegionList().previewDevice(PreviewDevice(rawValue: "iPhone Xʀ"))
    }
}
