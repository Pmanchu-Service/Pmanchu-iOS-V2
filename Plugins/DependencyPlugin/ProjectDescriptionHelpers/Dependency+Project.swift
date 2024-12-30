import ProjectDescription

public extension TargetDependency {
    struct Projects {}
    struct Module {}
}

public extension TargetDependency.Projects {
    static func project(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Projects/\(name)")
        )
    }
}

public extension TargetDependency.Module {

    static func module(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Projects/Modules/\(name)")
        )
    }
}
