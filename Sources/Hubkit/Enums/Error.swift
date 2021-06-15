import Vapor

public enum HubkitError: Error {
    /// Missing project identifier
    case missingProjectId

    /// Missing session capture date
    case missingCaptureDate

    /// Missing session file
    case missingSessionFile

    /// Encoding problem
    case encodingProblem
    
    /// Failed authentication
    case authenticationFailed

    /// Generic error
    case unknownError(ClientResponse)
    
    /// Identifier
    public var identifier: String {
        switch self {
        case .missingProjectId: return "hubkit.missing_project_id"
        case .missingCaptureDate: return "hubkit.missing_captured_at"
        case .missingSessionFile: return "hubkit.missing_session_file"
        case .encodingProblem: return "hubkit.encoding_error"
        case .authenticationFailed: return "hubkit.auth_failed"
        case .unknownError: return "hubkit.unknown_error"
        }
    }
    
    /// Reason
    public var reason: String {
        switch self {
        case .missingProjectId: return "Missing project identifier"
        case .missingCaptureDate: return "Missing capture date"
        case .missingSessionFile: return "Missing session file"
        case .encodingProblem: return "Encoding problem"
        case .authenticationFailed: return "Failed authentication"
        case .unknownError: return "Generic error"
        }
    }
}
