import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core

public final class AppStepper: Stepper {
    public let steps = PublishRelay<Step>()
    public init() {}

    public var initialStep: Step {
        return PMStep.rankIsRequired
    }
}
