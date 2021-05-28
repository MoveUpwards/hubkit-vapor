import Vapor

extension HubkitClient {
    func parse(response: ClientResponse) throws -> ClientResponse {
        switch true {
        case response.status == .ok: return response
        case response.status == .unauthorized: throw HubkitError.authenticationFailed
        default: throw HubkitError.unknownError(response)
        }
    }
}
