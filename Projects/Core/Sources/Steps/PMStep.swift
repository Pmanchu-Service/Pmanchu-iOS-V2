import RxFlow

public enum PMStep: Step {
    case start
    case loginIsRequired
    case nameIsRequired
    case rankIsRequired
    case toRankIsRequired
    case emailIsRequired
}
