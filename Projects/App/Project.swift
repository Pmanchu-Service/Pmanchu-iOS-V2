import Foundation
import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin
import DependencyPlugin
//import ConfigurationPlugin

let isCI: Bool = (ProcessInfo.processInfo.environment["TUIST_CI"] ?? "0") == "1"

let settings: Settings = .settings(
    base: env.baseSetting,
    defaultSettings: .recommended
)

let scripts: [TargetScript] = isCI ? [] : [.swiftLint]

let targets: [Target] = [
    .init(
        name: env.targetName,
        platform: env.platform,
        product: .app,
        bundleId: "\(env.organizationName)",
        deploymentTarget: env.deploymentTarget,
        infoPlist: .file(path: "Support/Info.plist"),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        scripts: scripts,
        dependencies: []
    )
]

let project = Project(
    name: env.targetName,
    organizationName: env.organizationName,
    packages: [],
    settings: settings,
    targets: targets
)
