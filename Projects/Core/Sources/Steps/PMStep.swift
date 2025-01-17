import RxFlow

public enum PMStep: Step {
    case start
    case loginIsRequired
    case nameIsRequired
    case rankIsRequired
    case toRankIsRequired
    case emailIsRequired
    case selfIsRequired
    case skillIsRequired
    case majorIsRequired
    case homeIsReRequired
    
    case onboardingIsRequired
    // MARK: Tab
    case tabIsRequired
    case appIsRequired
    case popIsRequired
    
    // Home
    case homeIsRequired
    
    // User
    case userIsRequired
    
    // Heart
    case heartIsRequired
    
    // Profile
    case profileIsRequired
}
