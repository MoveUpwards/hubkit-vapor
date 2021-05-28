import Vapor
import Foundation
import HubkitModel

// MARK: - Service
public protocol HubkitProvider {
    func account() throws -> EventLoopFuture<Account>
    func device(id: UUID) throws -> EventLoopFuture<Device>
    func activate(id: UUID) throws -> EventLoopFuture<Device>
    
    func delegating(to eventLoop: EventLoop) -> HubkitProvider
}

public struct HubkitClient: HubkitProvider {
    let eventLoop: EventLoop
    let config: HubkitConfiguration
    let client: Client
    
    // MARK: Initialization
    public init(
        config: HubkitConfiguration,
        eventLoop: EventLoop,
        client: Client
    ) {
        self.config = config
        self.eventLoop = eventLoop
        self.client = client
    }
    
    public func delegating(to eventLoop: EventLoop) -> HubkitProvider {
        HubkitClient(config: config, eventLoop: eventLoop, client: client.delegating(to: eventLoop))
      }
}

// MARK: - Send message

extension HubkitClient {
    /// Base API URL
    var baseApiUrl: String {
        "https://app.hubkit.cloud/api/v1"
    }

    /// Get `Account` linked to api key
    ///
    /// - Returns: Future<Account>
    public func account() throws -> EventLoopFuture<Account> {
        getRequest(endpoint: "me").flatMapThrowing {
            try $0.content.decode(Account.self)
        }
    }

    /// Get `Device` for given UUID
    ///
    /// - Parameters:
    ///   - id: UUID
    ///
    /// - Returns: Future<Device>
    public func device(id: UUID) throws -> EventLoopFuture<Device> {
        getRequest(endpoint: "devices/\(id.uuidString)").flatMapThrowing { try $0.content.decode(Device.self) }
    }

    /// Activate `Device` for given UUID
    ///
    /// - Parameters:
    ///   - id: UUID
    ///
    /// - Returns: Future<Device>
    public func activate(id: UUID) throws -> EventLoopFuture<Device> {
        patchRequest(endpoint: "devices/\(id.uuidString)/activate").flatMapThrowing { try $0.content.decode(Device.self) }
    }
}
