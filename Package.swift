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
            targets: ["dummy"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "dummy",
            url: "https://github.com/wtao-nexus5/swift-package/releases/download/1.0/dummy.xcframework.zip",
            checksum: "9212aa14e56477ff43cf3218332dd3b4846beff2e767bca403920c8a7ffbcedb"),
        .testTarget(
            name: "dummyTests",
            dependencies: ["dummy"]),
    ]
)
