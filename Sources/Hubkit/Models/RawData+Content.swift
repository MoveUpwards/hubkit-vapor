import Vapor
import HubkitModel

extension HubkitModel.RawData: Content {}

public extension HubkitModel.RawData {
    struct Form: Content {
        //public static var defaultContentType: HTTPMediaType { .formData(boundary: <#T##String#>) }

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
