// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "dummy",
    platforms: [
        .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "dummy",
            targets: ["dummy", "dummyDist"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "dummy",
            dependencies: []),
        .binaryTarget(
            name: "dummyDist",
            url: "https://github.com/redfast/redfast-sdk/releases/download/1.0.11/dummy.xcframework.zip",
            checksum: "16c27e88858d10b7a50d29a2cf9011296ef0c4e312adc2aeab5dc489faf8db31"),
        .testTarget(
            name: "dummyTests",
            dependencies: ["dummy"]),
    ]
)
