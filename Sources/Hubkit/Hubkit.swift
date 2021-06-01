import Vapor
import Foundation
import HubkitModel

// MARK: - Service
public protocol HubkitProvider {
    func account(_ endpoint: Endpoint.Account) throws -> EventLoopFuture<ResponseEncodable>
    func device(_ endpoint: Endpoint.Device) throws -> EventLoopFuture<ResponseEncodable>
    func session(_ endpoint: Endpoint.Session) throws -> EventLoopFuture<ResponseEncodable>
    func rawData(_ endpoint: Endpoint.RawData) throws -> EventLoopFuture<ResponseEncodable>
    
    func delegating(to eventLoop: EventLoop) -> HubkitProvider
}

public struct HubkitClient: HubkitProvider {
    let eventLoop: EventLoop
    let config: HubkitConfiguration
    let client: Client
    let decoder: ContentDecoder
    
    // MARK: Initialization
    public init(
        config: HubkitConfiguration,
        eventLoop: EventLoop,
        client: Client
    ) {
        self.config = config
        self.eventLoop = eventLoop
        self.client = client

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        self.decoder = decoder
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
    public func account(_ endpoint: Endpoint.Account) throws -> EventLoopFuture<ResponseEncodable> {
        send(endpoint.method, to: endpoint.uri)
            .flatMapThrowing { try $0.content.decode(HubkitModel.Account.self, using: decoder) }
    }

    /// `Device`available endpoints
    ///
    /// - Parameters:
    ///   - endpoint: `Endpoint.Device`
    ///
    /// - Returns: Future<Device>
    public func device(_ endpoint: Endpoint.Device) throws -> EventLoopFuture<ResponseEncodable> {
        send(endpoint.method, to: endpoint.uri)
            .flatMapThrowing { try $0.content.decode(HubkitModel.Device.self, using: decoder) }
    }

    /// `Session` available endpoints
    ///
    /// - Parameters:
    ///   - endpoint: `Endpoint.Session`
    ///
    /// - Returns: Future<Session>
    public func session(_ endpoint: Endpoint.Session) throws -> EventLoopFuture<ResponseEncodable> {
        send(endpoint.method, to: endpoint.uri)
            .flatMapThrowing { try $0.content.decode(HubkitModel.Session.self, using: decoder) }
    }

    /// `RawData` available endpoints
    ///
    /// - Parameters:
    ///   - endpoint: `Endpoint.RawData`
    ///
    /// - Returns: Future<RawData>
    public func rawData(_ endpoint: Endpoint.RawData) throws -> EventLoopFuture<ResponseEncodable> {
        send(endpoint.method, to: endpoint.uri)
            .flatMapThrowing { try $0.content.decode(HubkitModel.RawData.self, using: decoder) }
    }
}
