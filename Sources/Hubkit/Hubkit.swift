import Vapor
import Foundation
import HubkitModel

// MARK: - Service
public protocol HubkitProvider {
    func account() throws -> EventLoopFuture<HubkitModel.Account>
    func device(id: UUID) throws -> EventLoopFuture<HubkitModel.Device>
    func activate(id: UUID) throws -> EventLoopFuture<HubkitModel.Device>
    func session(id: UUID) throws -> EventLoopFuture<HubkitModel.Session>
    
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
    public func account() throws -> EventLoopFuture<HubkitModel.Account> {
        getRequest(endpoint: "me").flatMapThrowing { try $0.content.decode(HubkitModel.Account.self) }
    }

    /// Get `Device` for given UUID
    ///
    /// - Parameters:
    ///   - id: UUID
    ///
    /// - Returns: Future<Device>
    public func device(id: UUID) throws -> EventLoopFuture<HubkitModel.Device> {
        getRequest(endpoint: "devices/\(id.uuidString)").flatMapThrowing { try $0.content.decode(HubkitModel.Device.self) }
    }

    /// Activate `Device` for given UUID
    ///
    /// - Parameters:
    ///   - id: UUID
    ///
    /// - Returns: Future<Device>
    public func activate(id: UUID) throws -> EventLoopFuture<HubkitModel.Device> {
        patchRequest(endpoint: "devices/\(id.uuidString)/activate").flatMapThrowing { try $0.content.decode(HubkitModel.Device.self) }
    }

    /// Get `Session` for given UUID
    ///
    /// - Parameters:
    ///   - id: UUID
    ///
    /// - Returns: Future<Session>
    public func session(id: UUID) throws -> EventLoopFuture<HubkitModel.Session> {
        getRequest(endpoint: "sessions/\(id.uuidString)").flatMapThrowing { try $0.content.decode(HubkitModel.Session.self) }
    }
}
