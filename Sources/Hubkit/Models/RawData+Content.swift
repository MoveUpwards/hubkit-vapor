import Vapor
import HubkitModel

extension HubkitModel.RawData: Content {
    public static var defaultContentType: HTTPMediaType { .multipart }
}

public extension HubkitModel.RawData {
    struct Form: Content {
        public let session: UUID
        public let device: UUID
        public let file: File

        public init(session: UUID, device: UUID, file: File) {
            self.session = session
            self.device = device
            self.file = file
        }
    }
}
