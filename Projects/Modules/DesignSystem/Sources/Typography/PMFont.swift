import UIKit

public extension UIFont {
    static func pmFont(_ font: PMFontStyle, size: CGFloat) -> UIFont {
        font.uiFont(size: size)
    }
}

extension PMFontStyle {

    func uiFont(size: CGFloat) -> UIFont {
        let pretendard = DesignSystemFontFamily.Pretendard.self

        switch self {
        case .regular:
            return pretendard.regular.font(size: size)
        case .semiBold:
            return pretendard.semiBold.font(size: size)
        case .bold:
            return pretendard.bold.font(size: size)
        }
    }
}
