import Vapor
import HubkitModel

extension HubkitModel.RawData: Content {}

public extension HubkitModel.RawData {
    struct Form: Content {
        let session: UUID
        let device: UUID
        let file: File
    }
}
