import Vapor
import AsyncHTTPClient

extension HubkitClient {
    func postRequest<Message: Content>(_ content: Message, endpoint: String) -> EventLoopFuture<ClientResponse> {
        var headers = HTTPHeaders()
        headers.add(name: .accept, value: "application/json")
        headers.add(name: "apikey", value: config.apiKey)

        let hubkitURI = URI(string: "\(self.baseApiUrl)/\(endpoint)")

        return self.client.post(hubkitURI, headers: headers) { try $0.content.encode(content) }
            .flatMapThrowing { try self.parse(response: $0) }
    }
}
