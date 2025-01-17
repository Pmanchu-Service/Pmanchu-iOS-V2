import UIKit

public struct TabItemInfo {
    let title: String
    let image: UIImage
    let tag: Int
}

public enum PMTabBarType: Int {
    case home, userSearch, heart, profile
    
    func tabItemTuple() -> TabItemInfo {
        switch self {
        case .home:
            return .init(
                title: "홈",
                image: .home,
                tag: 0
            )
        case .userSearch:
            return .init(
                title: "유저검색",
                image: .userSearch,
                tag: 1
            )
        case .heart:
            return .init(
                title: "찜",
                image: .heartOutline,
                tag: 2
            )
        case .profile:
            return .init(
                title: "프로필",
                image: .user,
                tag: 3
            )
            
        }
    }
}
