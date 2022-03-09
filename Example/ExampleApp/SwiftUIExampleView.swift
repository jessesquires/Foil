//
//  Created by Jesse Squires
//  https://www.jessesquires.com
//
//  Documentation
//  https://jessesquires.github.io/Foil
//
//  GitHub
//  https://github.com/jessesquires/Foil
//
//  Copyright © 2021-present Jesse Squires
//

import SwiftUI

struct SwiftUIExampleView: View {
    @State private var flagEnabled = false

    var body: some View {
        VStack {
            Toggle(isOn: $flagEnabled) {
                Text(flagEnabled.description)
            }
            GroupBox {
                Button("Simulate outside trigger") {
                    AppSettings.shared.flagEnabled.toggle()
                }
            }
        }
        .padding()
        .navigationTitle("SwiftUI Example")
        .onChange(of: flagEnabled) {
            // User interaction stores into settings
            AppSettings.shared.flagEnabled = $0
        }
        .onReceive(AppSettings.shared.$flagEnabled) {
            // Listen to settings change
            flagEnabled = $0
        }
    }
}

final class SwiftUIExampleHostViewController: UIHostingController<SwiftUIExampleView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SwiftUIExampleView())
    }
}
