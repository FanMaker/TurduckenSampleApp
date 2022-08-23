//
//  RegionRow.swift
//  Turducken
//
//  Created by Érik Escobedo on 23/08/22.
//

import SwiftUI
import CoreLocation
import FanMaker

struct RegionRow : View {
    var data: Region
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(data.uuid).bold().lineLimit(1).minimumScaleFactor(0.5)
            HStack {
                Text("Major: \(data.major)")
                Text("Minor: \(data.id)")
            }
        }
    }
}
