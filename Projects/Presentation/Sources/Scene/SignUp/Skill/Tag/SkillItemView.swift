import UIKit
import SnapKit
import Then

class SkillItemView: UIView {
    private let containerView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray5.cgColor
    }

    private let skillLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 14)
    }

    private let deleteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .systemGray
    }
    var onDelete: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAction()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(skillLabel)
        containerView.addSubview(deleteButton)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(45)
        }

        skillLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(deleteButton.snp.leading).offset(-8)
        }

        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }
    }

    private func setupAction() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    @objc private func deleteButtonTapped() {
        onDelete?()
    }

    func configure(with text: String) {
        skillLabel.text = text
    }
}
