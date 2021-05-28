import Vapor
import AsyncHTTPClient

extension HubkitClient {
    func getRequest(endpoint: String) -> EventLoopFuture<ClientResponse> {
        var headers = HTTPHeaders()
        headers.add(name: .accept, value: "application/json")
        headers.add(name: "apikey", value: config.apiKey)

        let hubkitURI = URI(string: "\(self.baseApiUrl)/\(endpoint)")

        return self.client.get(hubkitURI, headers: headers) { _ in }
            .flatMapThrowing { try self.parse(response: $0) }
    }
}
