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

import Combine
import Foundation
import UIKit

final class CombineExampleViewController: UIViewController {

    @IBOutlet private weak var exampleLabel: UILabel!
    @IBOutlet private weak var exampleSwitch: UISwitch!

    private var bag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        AppSettings.shared.$flagEnabled
            .sink { newValue in
                self.exampleSwitch.isOn = newValue
                self.updateLabel(with: newValue)
            }
            .store(in: &self.bag)
    }

    @IBAction func valueChanged(_ sender: UISwitch) {
        AppSettings.shared.flagEnabled = sender.isOn
    }

    private func updateLabel(with newValue: Bool) {
        self.exampleLabel.text = "\(newValue)"
    }
}
