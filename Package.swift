// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hubkit",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Hubkit",
            targets: ["Hubkit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/MoveUpwards/hubkit-model-swift.git", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Hubkit",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "HubkitModel", package: "hubkit-model-swift")
            ]),
        .testTarget(
            name: "HubkitTests",
            dependencies: [
                .target(name: "Hubkit"),
        ]),
    ]
)
