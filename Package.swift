// swift-tools-version:5.3
// The swift-tools-version declares the minimum version
// of Swift required to build this package.
// ----------------------------------------------------
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

import PackageDescription

let package = Package(
    name: "Foil",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Foil",
            targets: ["Foil"])
    ],
    targets: [
        .target(
            name: "Foil",
            path: "Sources",
            exclude: ["Info.plist"]),
        .testTarget(name: "FoilTests",
                    dependencies: ["Foil"],
                    path: "Tests",
                    exclude: ["Info.plist"])
    ],
    swiftLanguageVersions: [.v5]
)
