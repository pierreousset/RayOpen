// swift-tools-version: 6.0
import PackageDescription
let package = Package(name: "RayOpen", platforms: [.macOS(.v14)], products: [.executable(name: "RayOpen", targets: ["RayOpen"])], targets: [.executableTarget(name: "RayOpen")], swiftLanguageModes: [.v5])
