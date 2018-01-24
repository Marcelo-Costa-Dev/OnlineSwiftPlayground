// swift-tools-version:4.0
import PackageDescription

let dependencies:[Package.Dependency] = [
    .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.1.0"),
    .package(url: "https://github.com/IBM-Swift/Kitura-WebSocket.git", from: "1.0.0"),
    .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
    .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", from: "6.0.0"),
    .package(url: "https://github.com/IBM-Swift/Configuration.git", from: "3.0.0"),
    .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0"),
    .package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", from: "1.8.4"),
    .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "0.8.0"),
    .package(url: "https://github.com/krzyzanowskim/Kitura-CredentialsGitHub.git", .branch("master")) // Fix dependency chain
]

var targets:[Target] = [
    .target(name: "PlaygroundServer", dependencies: [ .target(name: "Application"), .target(name: "OnlinePlayground"), "Kitura" , "HeliumLogger"]),
    .target(name: "Application", dependencies: [ "Kitura", "Kitura-WebSocket", "Configuration", "CloudEnvironment", "Utility", "CredentialsGitHub", "KituraStencil"], exclude: ["DerivedData","static","node_modules"]),
    .target(name: "OnlinePlayground", dependencies: ["CryptoSwift"]), // Link custom modules here
    .testTarget(name: "ApplicationTests" , dependencies: [.target(name: "Application"), "Kitura","HeliumLogger" ])
]

var products: [Product] = [
    .executable(name: "PlaygroundServer", targets: ["PlaygroundServer"]),
    .library(name: "OnlinePlayground", type: .static, targets: ["OnlinePlayground"])
]

let package = Package(
    name: "PlaygroundServer",
    products: products,
    dependencies: dependencies,
    targets: targets
)
