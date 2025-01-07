import ProjectDescription

public extension ProjectDescription.Path {
    static func relativeToXCConfig() -> Self {
        return .relativeToRoot("XCConfig/Pmanchu_iOS_V2/Pmanchu.xcconfig")
    }

    static var shared: Self {
        return .relativeToRoot("XCConfig/Shared.xcconfig")
    }
}
