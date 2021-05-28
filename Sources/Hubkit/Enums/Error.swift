import Vapor

public enum HubkitError: Error {
    /// Encoding problem
    case encodingProblem
    
    /// Failed authentication
    case authenticationFailed

    /// Generic error
    case unknownError(ClientResponse)
    
    /// Identifier
    public var identifier: String {
        switch self {
        case .encodingProblem: return "hubkit.encoding_error"
        case .authenticationFailed: return "hubkit.auth_failed"
        case .unknownError: return "hubkit.unknown_error"
        }
    }
    
    /// Reason
    public var reason: String {
        switch self {
        case .encodingProblem: return "Encoding problem"
        case .authenticationFailed: return "Failed authentication"
        case .unknownError: return "Generic error"
        }
    }
}
