//
//  BeaconActions.swift
//  Turducken
//
//  Created by Érik Escobedo on 20/06/22.
//

import SwiftUI

struct BeaconActions: View {
    var actions : [BeaconAction]
    
    var body: some View {
        List(actions.reversed()) { action in
            VStack {
                HStack {
                    Text("Major: \(action.major)")
                    Text("Minor: \(action.minor)")
                }
                HStack {
                    Text("Seen: \(Int(Date().timeIntervalSince(action.seenAt))) seconds ago")
                
                    let status = action.posted ? "Posted" : "Pending"
                    let color : Color = action.posted ? .green : .red
                    Text("Status: ") + Text(status).foregroundColor(color).bold()
                }
            }
        }.navigationTitle("Baecon Actions")
    }
}

struct BeaconActions_Previews: PreviewProvider {
    static var previews: some View {
        BeaconActions(actions: [
            BeaconAction(id: 1, major: 1, minor: 1, seenAt: Date(timeIntervalSinceNow: -15), posted: false)
        ])
    }
}
