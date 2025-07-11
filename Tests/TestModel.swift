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

@testable import Foil
import Foundation

struct TestModel: Hashable {
    @FoilDefaultStorage(key: "model_flag", userDefaults: TestSettings.store)
    var flag = true

    @FoilDefaultStorage(key: "model_count", userDefaults: TestSettings.store)
    var count = 42

    @FoilDefaultStorageOptional(key: "model_text", userDefaults: TestSettings.store)
    var text: String?
}
