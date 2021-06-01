import Vapor
import Foundation
import HubkitModel

// MARK: - Service
public protocol HubkitProvider {
    func account(_ endpoint: Endpoint.Account) throws -> EventLoopFuture<ResponseEncodable>
    
    func device<C: Content>(_ endpoint: Endpoint.Device, body: C?) throws -> EventLoopFuture<ResponseEncodable>
    func session<C: Content>(_ endpoint: Endpoint.Session, body: C?) throws -> EventLoopFuture<ResponseEncodable>
    func rawData<C: Content>(_ endpoint: Endpoint.RawData, body: C?) throws -> EventLoopFuture<ResponseEncodable>
    
    func delegating(to eventLoop: EventLoop) -> HubkitProvider
}

public struct HubkitClient: HubkitProvider {
    let eventLoop: EventLoop
    let config: HubkitConfiguration
    let client: Client
    let decoder: ContentDecoder
    let encoder: ContentEncoder
    
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

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        self.encoder = encoder
    }
    
    public func delegating(to eventLoop: EventLoop) -> HubkitProvider {
        HubkitClient(config: config, eventLoop: eventLoop, client: client.delegating(to: eventLoop))
    }
}

// MARK: - Send message

extension HubkitClient {
    /// Get `Account` linked to api key
    ///
    /// - Parameters:
    ///   - body: `Content`
    ///
    /// - Returns: Future<ResponseEncodable>
    public func account(_ endpoint: Endpoint.Account) throws -> EventLoopFuture<ResponseEncodable> {
        send(endpoint.method, to: endpoint.uri)
            .flatMapThrowing { try $0.content.decode(HubkitModel.Account.self, using: decoder) }
    }

    /// `Device`available endpoints
    ///
    /// - Parameters:
    ///   - endpoint: `Endpoint.Device`
    ///   - body: `Content`
    ///
    /// - Returns: Future<ResponseEncodable>
    public func device<C: Content>(_ endpoint: Endpoint.Device, body: C? = nil) throws -> EventLoopFuture<ResponseEncodable> {
        send(endpoint.method, to: endpoint.uri, beforeSend: { req in
            if let content = body { try req.content.encode(content) }
        }).flatMapThrowing { try $0.content.decode(HubkitModel.Device.self, using: decoder) }
    }

    /// `Session` available endpoints
    ///
    /// - Parameters:
    ///   - endpoint: `Endpoint.Session`
    ///   - body: `Content`
    ///
    /// - Returns: Future<ResponseEncodable>
    public func session<C: Content>(_ endpoint: Endpoint.Session, body: C? = nil) throws -> EventLoopFuture<ResponseEncodable> {
        send(endpoint.method, to: endpoint.uri, beforeSend: { req in
            if let content = body { try req.content.encode(content) }
        }).flatMapThrowing { try $0.content.decode(HubkitModel.Session.self, using: decoder) }
    }

    /// `RawData` available endpoints
    ///
    /// - Parameters:
    ///   - endpoint: `Endpoint.RawData`
    ///   - body: `Content`
    ///
    /// - Returns: Future<ResponseEncodable>
    public func rawData<C: Content>(_ endpoint: Endpoint.RawData, body: C? = nil) throws -> EventLoopFuture<ResponseEncodable> {
        send(endpoint.method, to: endpoint.uri, beforeSend: { req in
            if let content = body { try req.content.encode(content) }
        }).flatMapThrowing { try $0.content.decode(HubkitModel.RawData.self, using: decoder) }
    }
}
