//
//  ContentView.swift
//  Turducken
//
//  Created by Érik Escobedo on 14/05/21.
//

import SwiftUI

struct MeetingView: View {
    @State private var showingAlert = false

    var body: some View {
        VStack {
            ProgressView(value: 5.0, total: 15.0)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.bottomhalf.fill")
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.tophalf.fill")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Text("Time remaining"))
            .accessibilityLabel(Text("10 minutes"))

            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
                .padding()
            
            HStack {
                Text("Speaker 1 of 3")
                
                Spacer()
                
                Button(action: { showingAlert = true}) {
                    Image(systemName: "forward.fill")
                }
                .alert(isPresented: $showingAlert, content: {
                    Alert(
                        title: Text("Hola mundo"),
                        message: Text("Entonces le dije... mira hijo de tu puta madre"),
                        primaryButton: .cancel(Text("Uno"), action: {}),
                        secondaryButton: .destructive(Text("Dow"), action: {})
                    )
                })
                .accessibilityLabel(Text("Next Speaker"))
            }
        }
        .padding()
    }
}

struct MettingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
