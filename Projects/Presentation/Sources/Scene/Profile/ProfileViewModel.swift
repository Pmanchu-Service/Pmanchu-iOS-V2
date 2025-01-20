import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core
import Domain
import DesignSystem
import RxFlow

public class ProfileViewModel: BaseViewModel, Stepper {
    private let disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()
    public init() {}
    public struct Input {}
    public struct Output {}
    public func transform(input: Input) -> Output {
        return Output()
    }
}
