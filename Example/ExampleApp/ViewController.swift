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

import Foil
import UIKit

final class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.cellId)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "User Defaults keys and values"
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Tap to set random value, swipe to remove (or reset to default)."
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppSettingsKey.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.cellId, for: indexPath)

        let key = AppSettingsKey.allCases[indexPath.row]
        cell.textLabel?.text = key.rawValue

        switch key {
        case .flagEnabled:
            cell.detailTextLabel?.text = "\(AppSettings.shared.flagEnabled)"

        case .totalCount:
            cell.detailTextLabel?.text = "\(AppSettings.shared.totalCount)"

        case .timestamp:
            if let date = AppSettings.shared.timestamp {
                cell.detailTextLabel?.text = dateFormatter.string(from: date)
            } else {
                cell.detailTextLabel?.text = "nil"
            }

        case .option:
            if let option = AppSettings.shared.option {
                cell.detailTextLabel?.text = option
            } else {
                cell.detailTextLabel?.text = "nil"
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = AppSettingsKey.allCases[indexPath.row]
        switch key {
        case .flagEnabled:
            AppSettings.shared.flagEnabled.toggle()

        case .totalCount:
            AppSettings.shared.totalCount = Int.random(in: 0...1_000)

        case .timestamp:
            AppSettings.shared.timestamp = Date() + TimeInterval.random(in: 0...(60 * 60 * 24 * 30))

        case .option:
            AppSettings.shared.option = [nil, "\(UUID().uuidString.dropLast(32))"].randomElement()!
        }

        UserDefaults.standard.synchronize()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let key = AppSettingsKey.allCases[indexPath.row]
        AppSettings.shared.reset(for: key)

        tableView.reloadData()
    }
}

final class TableCell: UITableViewCell {
    static let cellId = "cellId"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

let dateFormatter: DateFormatter = {
    let dfr = DateFormatter()
    dfr.dateStyle = .short
    dfr.timeStyle = .short
    return dfr
}()
