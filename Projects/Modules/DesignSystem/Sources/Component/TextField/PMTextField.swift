import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Core

public final class PMTextField: BaseTextField {
    private let padding = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)

    public convenience init(
        placeholder: String,
        fontSize: CGFloat = 14
    ) {
        self.init(frame: .zero)
        self.setupTextField(placeholder: placeholder, fontSize: fontSize)
    }

    private func setupTextField(placeholder: String, fontSize: CGFloat) {
        self.attribute()
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.gray5,
                .font: UIFont.systemFont(ofSize: fontSize)
            ]
        )
    }

    public override func attribute() {
        super.attribute()
        self.do {
            $0.backgroundColor = .gray1
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.gray2.cgColor
            $0.layer.borderWidth = 1.0
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = .black
            $0.textAlignment = .left
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
