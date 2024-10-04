// swift-tools-version:6.0
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
        .tvOS(.v13),
        .watchOS(.v6),
        .macOS(.v11),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "Foil",
            targets: ["Foil"])
    ],
    targets: [
        .target(
            name: "Foil",
            path: "Sources"),
        .testTarget(name: "FoilTests",
                    dependencies: ["Foil"],
                    path: "Tests")
    ],
    swiftLanguageModes: [.v6]
)
