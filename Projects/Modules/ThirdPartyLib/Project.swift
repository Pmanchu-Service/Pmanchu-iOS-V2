import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "ThirdPartyLib",
    platform: .iOS,
    product: .staticFramework,
    packages: [],
    dependencies: [
        .SPM.KeychainSwift,
        .SPM.Moya,
        .SPM.RxCocoa,
        .SPM.RxFlow,
        .SPM.RxMoya,
        .SPM.RxSwift,
        .SPM.Swinject,
        .SPM.Then,
        .SPM.SnapKit
    ]
)
