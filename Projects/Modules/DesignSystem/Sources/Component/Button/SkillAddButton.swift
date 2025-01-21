import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core

public class SkillAddButton: BaseButton {
    public var buttonTap: ControlEvent<Void> {
        return self.rx.tap
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        attribute()
    }
    public override func attribute() {
        self.backgroundColor = .main4
        self.layer.cornerRadius = 6
        self.setImage(.plus, for: .normal)
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        self.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        self.tintColor = .system2
    }
}
