import Vapor

extension Request {
    public func hubkit() -> HubkitProvider {
        application.hubkitClient().delegating(to: self.eventLoop)
    }
}
