//
//  BeaconList.swift
//  Turducken
//
//  Created by Érik Escobedo on 20/06/22.
//

import SwiftUI

struct Beacon : Identifiable {
    var id : Int
    var region : Region
}

struct BeaconList: View {
    var beacons : [Beacon]
    var region : Region
    
    var body: some View {
        NavigationView {
            List(beacons) { beacon in
                NavigationLink {
                    BeaconActions(actions: region.actions.filter({ action in
                        action.minor == beacon.id
                    }))
                } label: {
                    BeaconRow(beacon: beacon)
                }
            }
            .navigationTitle("Beacons found")
        }
    }
}

struct BeaconList_Previews: PreviewProvider {
    static var previews: some View {
        BeaconList(beacons: [], region: Region(id: 1, uuid: "Ejemplo", major: 1))
    }
}
