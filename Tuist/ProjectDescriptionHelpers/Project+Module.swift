import Foundation

import ProjectDescription
import DependencyPlugin
import EnvironmentPlugin
import ConfigurationPlugin

let isCI = (ProcessInfo.processInfo.environment["TUIST_CI"] ?? "0") == "1" ? true : false

extension Project {
    public static func makeModule(
        name: String,
        organizationName: String = env.organizationName,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        resourceSynthesizers: [ResourceSynthesizer] = .default + [],
        platform: Platform = env.platform,
        product: Product,
        packages: [Package] = [],
        dependencies: [TargetDependency],
        settings: SettingsDictionary = [:],
        configurations: [Configuration] = [],
        additionalPlistRows: [String: ProjectDescription.InfoPlist.Value] = [:]
    ) -> Project {
        
        
        var configurations = configurations
                if configurations.isEmpty {
                    configurations = [
                        .debug(name: .debug, xcconfig: .relativeToXCConfig()),
                        .release(name: .release, xcconfig: .relativeToXCConfig())
                      ]
                }

        let scripts: [TargetScript] = isCI ? [] : [.swiftLint]

        let ldFlagsSettings: SettingsDictionary = product == .framework ?
        ["OTHER_LDFLAGS": .string("$(inherited) -all_load")] :
        ["OTHER_LDFLAGS": .string("$(inherited)")]

        let settings: Settings = .settings(
            base: env.baseSetting
                .merging(.codeSign)
                .merging(settings)
                .merging(ldFlagsSettings),
            configurations: configurations,
            defaultSettings: .recommended
        )

        var allTargets: [Target] = [
            Target(
                name: name,
                platform: platform,
                product: product,
                bundleId: "\(env.organizationName).\(name)",
                deploymentTarget: env.deploymentTarget,
                infoPlist: .extendingDefault(with: additionalPlistRows),
                sources: sources,
                resources: resources,
                scripts: scripts,
                dependencies: dependencies
            )
        ]

        return Project(
            name: name,
            organizationName: env.organizationName,
            packages: packages,
            settings: settings,
            targets: allTargets,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}
