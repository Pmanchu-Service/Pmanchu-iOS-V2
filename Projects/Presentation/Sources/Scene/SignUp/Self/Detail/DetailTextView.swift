import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Core
import DesignSystem

public final class DetailTextView: UITextView {
    private let placeholderLabel = UILabel().then {
        $0.textColor = .gray5
        $0.font = .systemFont(ofSize: 14)
    }

    private let padding = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)

    public var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    public convenience init(placeholder: String) {
        self.init(frame: .zero, textContainer: nil)
        self.placeholder = placeholder
        placeholderLabel.text = placeholder
    }

    private func setupView() {
        attribute()
        layout()
        textObserver()
    }

    private func attribute() {
        backgroundColor = .gray1
        layer.cornerRadius = 8
        layer.borderColor = UIColor.gray2.cgColor
        layer.borderWidth = 1.0
        textColor = .black
        font = .systemFont(ofSize: 14)
        textContainerInset = padding
        textContainer.lineFragmentPadding = 0
    }

    private func layout() {
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(padding.top)
            $0.leading.equalToSuperview().offset(padding.left)
            $0.trailing.equalToSuperview().offset(-padding.right)
        }
    }

    private func textObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }

    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
