import UIKit
import Then

public class GitHubLoginButton: UIButton {
    public init() {
        super.init(frame: .zero)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        var config = UIButton.Configuration.filled()

        config.baseBackgroundColor = .system3
        config.cornerStyle = .medium

        config.title = "github로 로그인하기"
        config.baseForegroundColor = .system2
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .pmFont(.semiBold, size: 20)
            return outgoing
        }

        config.image = .github
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        config.imagePadding = 12
        configuration = config
    }
}
