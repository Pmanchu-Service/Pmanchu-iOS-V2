import UIKit

import SnapKit
import Then

import RxSwift
import RxCocoa

import Core
import DesignSystem

public class NameViewController: BaseViewController<NameViewModel> {
    private let idTextField = PMTextField()

    public override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBackground
    }
    public override func addView() {
        view.addSubview(idTextField)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        addView()
        setLayout()
    }

    public override func setLayout() {
        idTextField.snp.makeConstraints {
            $0.top.equalTo(373)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(345)
            $0.height.equalTo(40)
        }
    }
}
