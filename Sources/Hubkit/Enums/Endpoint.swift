//
//  Endpoint.swift
//  
//
//  Created by lgriffie on 01/06/2021.
//

import Vapor
import HubkitModel

public enum Endpoint {
    public enum Account {
        case me

        public var method: HTTPMethod {
            switch self {
            case .me: return .GET
            }
        }

        public var uri: String {
            switch self {
            case .me: return "me"
            }
        }
    }

    public enum Device {
        case get(id: UUID)
        case activate(id: UUID)
        case create
        case update(id: UUID)

        public var method: HTTPMethod {
            switch self {
            case .get: return .GET
            case .activate, .update: return .PATCH
            case .create: return .POST
            }
        }

        public var uri: String {
            switch self {
            case .get(let id): return "devices/\(id.uuidString)"
            case .activate(let id): return "devices/\(id.uuidString)/activate"
            case .create: return "devices"
            case .update(let id): return "devices/\(id.uuidString)"
            }
        }
    }

    public enum Session {
        case get(id: UUID)
        case ready(id: UUID)
        case create
        case delete(id: UUID)

        public var method: HTTPMethod {
            switch self {
            case .get: return .GET
            case .ready: return .PATCH
            case .create: return .POST
            case .delete: return .DELETE
            }
        }

        public var uri: String {
            switch self {
            case .get(let id): return "sessions/\(id.uuidString)"
            case .ready(let id): return "sessions/\(id.uuidString)/ready"
            case .create: return "sessions"
            case .delete(let id): return "sessions/\(id.uuidString)"
            }
        }
    }

    public enum RawData {
        case get(id: UUID)
        case create

        public var method: HTTPMethod {
            switch self {
            case .get: return .GET
            case .create: return .POST
            }
        }

        public var uri: String {
            switch self {
            case .get(let id): return "raw_datas/\(id.uuidString)"
            case .create: return "raw_datas"
            }
        }
    }
}
