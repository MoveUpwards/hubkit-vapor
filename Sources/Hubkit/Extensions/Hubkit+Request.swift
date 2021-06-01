import Vapor
import AsyncHTTPClient

extension Request {
    public func hubkit() -> HubkitProvider {
        application.hubkitClient().delegating(to: self.eventLoop)
    }
}

extension HubkitClient {
    public func send(
        _ method: HTTPMethod,
        to endpoint: String,
        beforeSend: (inout ClientRequest) throws -> () = { _ in }
    ) -> EventLoopFuture<ClientResponse> {
        var headers = HTTPHeaders()
        headers.add(name: .accept, value: "application/json")
        headers.add(name: "apikey", value: config.apiKey)

        let uri = URI(string: "\(self.baseApiUrl)/\(endpoint)")

        return self.client.send(method, headers: headers, to: uri, beforeSend: beforeSend)
            .flatMapThrowing { try self.parse(response: $0) }
    }
}
