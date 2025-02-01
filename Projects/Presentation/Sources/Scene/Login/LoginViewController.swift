import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class LoginViewController: BaseViewController<LoginViewModel> {
    private let logo = UIImageView(image: UIImage.logo)
    private let loginLabel = PMLabel(
        text: "로그인",
        textColor: .system3,
        font: .pmFont(.semiBold, size: 25)
    )
    private let explainLabel = PMLabel(
        text: "깃허브로 프만추에 로그인 하세요",
        textColor: .system3,
        font: .pmFont(.regular, size: 20)
    )
    private let githubButton = GitHubLoginButton()

    public override func attribute() {
        super.attribute()
        self.highlightText()
    }

    public override func bind() {
        let input = LoginViewModel.Input(
            clickGitHubButton: githubButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
    }

    public override func addView() {
        [
            logo,
            loginLabel,
            explainLabel,
            githubButton
        ].forEach { view.addSubview($0) }
    }

    public override func setLayout() {
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(119)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(61)
            $0.width.equalTo(155)
        }
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(33)
        }
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(33)
        }
        githubButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(60)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(65)
        }
    }
}

extension LoginViewController {
    private func highlightText() {
        guard let text = self.explainLabel.text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.pmFont(.bold, size: 20)
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "프만추"))
        attributeString.addAttribute(.foregroundColor, value: UIColor.main4, range: (text as NSString).range(of: "프만추"))

        self.explainLabel.attributedText = attributeString
    }
}
