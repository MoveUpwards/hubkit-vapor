import Foundation
import Vapor

public struct HubkitConfiguration {
    /// API key
    public let apiKey: String

    /// Environment
    public let baseUrl: String

    /// Initializer
    ///
    /// - Parameters:
    ///   - apiKey: API key
    public init(apiKey: String, baseUrl: String) {
        self.apiKey = apiKey
        self.baseUrl = baseUrl
    }

    /// It will try to initialize configuration with environment variables:
    /// - HUBKIT_API_KEY
    public static var environment: HubkitConfiguration {
        guard let apiKey = Environment.get("HUBKIT_API_KEY"), let baseUrl = Environment.get("HUBKIT_BASE_URL") else {
            fatalError("Hubkit environmant variables not set")
        }
        return .init(apiKey: apiKey, baseUrl: baseUrl)
    }
}
