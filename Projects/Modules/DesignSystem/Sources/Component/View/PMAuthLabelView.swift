import UIKit
import SnapKit
import Then
import Core

public final class PMAuthLabelView: BaseView {
    private let pmanchuLabel = PMLabel(
        text: "프만추",
        textColor: .main4,
        font: .pmFont(.bold, size: 36)
    )
    private let signupLabel = PMLabel(
        text: "회원가입",
        textColor: .system3,
        font: .pmFont(.bold, size: 36)
    )
    private let explainLabel = PMLabel(
        textColor: .system3,
        font: .pmFont(.regular, size: 20)
    )

    public init(explainText: String? = nil) {
        super.init(frame: .zero)
        self.explainLabel.text = explainText
    }
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layout() {
        [
            pmanchuLabel,
            signupLabel,
            explainLabel
        ].forEach { self.addSubview($0) }

        self.snp.makeConstraints {
            $0.height.equalTo(73)
        }

        pmanchuLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        signupLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        explainLabel.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
        }
    }
}
