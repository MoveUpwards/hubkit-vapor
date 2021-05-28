import Foundation
import Vapor

public struct HubkitConfiguration {
    /// API key
    public let apiKey: String

    /// Initializer
    ///
    /// - Parameters:
    ///   - apiKey: API key
    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    /// It will try to initialize configuration with environment variables:
    /// - HUBKIT_API_KEY
    public static var environment: HubkitConfiguration {
        guard let apiKey = Environment.get("HUBKIT_API_KEY") else {
            fatalError("Hubkit environmant variables not set")
        }
        return .init(apiKey: apiKey)
    }
}
