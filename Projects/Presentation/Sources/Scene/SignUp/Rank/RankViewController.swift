import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import DesignSystem

public class RankViewController: BaseViewController<RankViewModel> {
    private let label = PMAuthLabelView(
        explainText: "기수를 입력하세요"
    )
    private let rankTextField = PMTextField()
    public override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBackground
    }
    public override func bind() {
        
    }
    public override func addView() {
        [
            label,
            rankTextField
        ].forEach { view.addSubview($0) }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        addView()
        setLayout()
    }

    public override func setLayout() {
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(224)
            $0.height.equalTo(73)
        }
        rankTextField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(40)
        }
    }
}
