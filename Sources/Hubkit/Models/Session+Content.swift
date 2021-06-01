import Vapor
import HubkitModel

extension HubkitModel.Session: Content {}

public extension HubkitModel.Session {
    struct Form: Content {
        public let project: UUID
        public let capturedAt: Date
        public let callbackUrl: String?
        public let metas: [String]?

        public init(project: UUID, capturedAt: Date, callbackUrl: String? = nil, metas: [String]? = nil) {
            self.project = project
            self.capturedAt = capturedAt
            self.callbackUrl = callbackUrl
            self.metas = metas
        }
    }
}
