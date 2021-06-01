import Vapor
import Foundation
import HubkitModel

// MARK: - Service
public protocol HubkitProvider {
    func account() throws -> EventLoopFuture<HubkitModel.Account>

    func create(device: HubkitModel.Device.Form) throws -> EventLoopFuture<HubkitModel.Device>
    func device(id: UUID) throws -> EventLoopFuture<HubkitModel.Device>
    func activate(device id: UUID) throws -> EventLoopFuture<HubkitModel.Device>

    func create(session: HubkitModel.Session) throws -> EventLoopFuture<HubkitModel.Session>
    func session(id: UUID) throws -> EventLoopFuture<HubkitModel.Session>
    func ready(session id: UUID) throws -> EventLoopFuture<HubkitModel.Session>
    func delete(session id: UUID) throws -> EventLoopFuture<HTTPStatus>

    func create(rawData: HubkitModel.RawData.Form) throws -> EventLoopFuture<HubkitModel.RawData>
    func rawData(id: UUID) throws -> EventLoopFuture<HubkitModel.RawData>
    
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

// MARK: - Account

extension HubkitClient {
    /// Get `Account`
    ///
    /// - Returns: Future<HubkitModel.Account>
    public func account() throws -> EventLoopFuture<HubkitModel.Account> {
        send(.GET, to: "me")
            .flatMapThrowing { try $0.content.decode(HubkitModel.Account.self, using: decoder) }
    }
}

// MARK: - Device

extension HubkitClient {
    /// Create `Device`
    ///
    /// - Returns: Future<HubkitModel.Device>
    public func create(device: HubkitModel.Device.Form) throws -> EventLoopFuture<HubkitModel.Device> {
        send(.POST, to: "devices", beforeSend: { try $0.content.encode(device) })
            .flatMapThrowing { try $0.content.decode(HubkitModel.Device.self, using: decoder) }
    }

    /// Get `Device`
    ///
    /// - Returns: Future<HubkitModel.Device>
    public func device(id: UUID) throws -> EventLoopFuture<HubkitModel.Device> {
        send(.GET, to: "devices/\(id.uuidString)")
            .flatMapThrowing { try $0.content.decode(HubkitModel.Device.self, using: decoder) }
    }

    /// Activate `Device`
    ///
    /// - Returns: Future<HubkitModel.Device>
    public func activate(device id: UUID) throws -> EventLoopFuture<HubkitModel.Device> {
        send(.PATCH, to: "devices/\(id.uuidString)/activate")
            .flatMapThrowing { try $0.content.decode(HubkitModel.Device.self, using: decoder) }
    }
}

// MARK: - Session

extension HubkitClient {
    /// Create `Session`
    ///
    /// - Returns: Future<HubkitModel.Device>
    public func create(session: HubkitModel.Session) throws -> EventLoopFuture<HubkitModel.Session> {
        send(.POST, to: "sessions", beforeSend: { try $0.content.encode(session) })
            .flatMapThrowing { try $0.content.decode(HubkitModel.Session.self, using: decoder) }
    }

    /// Get `Session`
    ///
    /// - Returns: Future<HubkitModel.Session>
    public func session(id: UUID) throws -> EventLoopFuture<HubkitModel.Session> {
        send(.GET, to: "sessions/\(id.uuidString)")
            .flatMapThrowing { try $0.content.decode(HubkitModel.Session.self, using: decoder) }
    }

    /// Ready `Session`
    ///
    /// - Returns: Future<HubkitModel.Session>
    public func ready(session id: UUID) throws -> EventLoopFuture<HubkitModel.Session> {
        send(.PATCH, to: "sessions/\(id.uuidString)/ready")
            .flatMapThrowing { try $0.content.decode(HubkitModel.Session.self, using: decoder) }
    }

    /// Ready `Session`
    ///
    /// - Returns: Future<HubkitModel.Session>
    public func delete(session id: UUID) throws -> EventLoopFuture<HTTPStatus> {
        send(.DELETE, to: "sessions/\(id.uuidString)")
            .flatMapThrowing { $0.status }
    }
}

// MARK: - RawData

extension HubkitClient {
    /// Create `RawData`
    ///
    /// - Returns: Future<HubkitModel.RawData>
    public func create(rawData: HubkitModel.RawData.Form) throws -> EventLoopFuture<HubkitModel.RawData> {
        send(.POST, to: "raw_datas", beforeSend: { try $0.content.encode(rawData) })
            .flatMapThrowing { try $0.content.decode(HubkitModel.RawData.self, using: decoder) }
    }

    /// Get `RawData`
    ///
    /// - Returns: Future<HubkitModel.RawData>
    public func rawData(id: UUID) throws -> EventLoopFuture<HubkitModel.RawData> {
        send(.GET, to: "raw_datas/\(id.uuidString)")
            .flatMapThrowing { try $0.content.decode(HubkitModel.RawData.self, using: decoder) }
    }
}
