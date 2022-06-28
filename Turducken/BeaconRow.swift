//
//  BeaconRow.swift
//  Turducken
//
//  Created by Érik Escobedo on 20/06/22.
//

import SwiftUI

struct BeaconRow : View {
    var beacon: Beacon
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(beacon.region.uuid).bold().lineLimit(1).minimumScaleFactor(0.5)
            HStack {
                Text("Major: \(beacon.region.major)")
                Text("Minor: \(beacon.id)")
            }
        }
    }
}

struct BeaconRow_Previews: PreviewProvider {
    static var previews: some View {
        BeaconRow(beacon: Beacon(id: 1, region: Region(id: 1, uuid: "4F67E3A8-EB0E-4428-9331-D2C39CB54699", major: 12345)))
    }
}
