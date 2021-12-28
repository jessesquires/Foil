//
//  Created by Jonas Reichert on 25.12.21.
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
            .store(in: &bag)
    }

    @IBAction func valueChanged(_ sender: UISwitch) {
        AppSettings.shared.flagEnabled = sender.isOn
    }

    private func updateLabel(with newValue: Bool) {
        exampleLabel.text = "\(newValue)"
    }
}
