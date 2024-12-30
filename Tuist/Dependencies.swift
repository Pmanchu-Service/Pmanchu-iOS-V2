import ProjectDescription
//import ConfigurationPlugin

let dependencies = Dependencies.init(
    swiftPackageManager: SwiftPackageManagerDependencies(
        [],
        baseSettings: .settings()
    ),
    platforms: [.iOS]
)
