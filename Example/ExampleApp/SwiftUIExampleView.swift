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

    @ObservedObject private var settings: AppSettings = .shared

    var body: some View {
        VStack {
            Toggle(isOn: $settings.flagEnabled) {
                Text(settings.flagEnabled.description)
            }
        }
        .padding()
        .navigationTitle("SwiftUI Example")
    }
}

final class SwiftUIExampleHostViewController: UIHostingController<SwiftUIExampleView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SwiftUIExampleView())
    }
}
