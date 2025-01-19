import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class SkillAddButton: BaseButton {
    public var buttonTap: ControlEvent<Void> {
        return self.rx.tap
    }
    public override var isEnabled: Bool {
        didSet {
            self.attribute()
        }
    }
    private var bgColor: UIColor {
        isEnabled ? .main4 : .gray3
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience public init(
        type: UIButton.ButtonType? = .system,
        buttonText: String? = String(),
        isEnabled: Bool? = true,
        isHidden: Bool? = false,
        height: CGFloat? = 40
    ) {
        self.init(type: .system)
        self.setTitle(buttonText, for: .normal)
        self.isEnabled = isEnabled ?? true
        self.isHidden = isHidden ?? false
        attribute()

        self.snp.remakeConstraints {
            $0.height.equalTo(height ?? 0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func layoutSubviews() {
        super.layoutSubviews()

        attribute()
    }

    public override func attribute() {
        self.backgroundColor = bgColor
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 21)
        self.layer.cornerRadius = 6
    }
}
