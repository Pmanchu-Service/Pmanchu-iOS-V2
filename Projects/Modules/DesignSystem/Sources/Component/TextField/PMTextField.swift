import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Core

public final class PMTextField: BaseTextField {
    private let padding = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)

    public override func attribute() {
        super.attribute()
        self.do {
            $0.backgroundColor = .gray1
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.gray2.cgColor
            $0.layer.borderWidth = 1.0
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.textColor = .gray5
//            $0.textAlignment = .left
            $0.attributedPlaceholder = NSAttributedString(
                string: "이름(본명)을 입력하세요",
                attributes: [
                    .foregroundColor: UIColor.lightGray,
                    .font: UIFont.systemFont(ofSize: 16)
                ]
            )
        }
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
