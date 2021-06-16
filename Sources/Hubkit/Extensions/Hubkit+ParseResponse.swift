import Vapor

extension HubkitClient {
    func parse(response: ClientResponse) throws -> ClientResponse {
        guard !response.status.isValid else { return response }

        switch response.status {
        case .unauthorized: throw HubkitError.authenticationFailed
        default: throw HubkitError.unknownError(response)
        }
    }
}

extension HTTPStatus {
    var isValid: Bool { ((HTTPStatus.ok.code)..<(HTTPStatus.badRequest.code)).contains(code) }
}
