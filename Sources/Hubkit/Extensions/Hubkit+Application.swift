import Vapor

extension Application {
    public struct Hubkit {
        public typealias HubkitFactory = (Application) -> HubkitProvider
        
        public struct Provider {
            public static var live: Self {
                .init {
                    $0.hubkit.use {
                        guard let config = $0.hubkit.configuration else {
                            fatalError("Hubkit not configured, use: app.hubkit.configuration = .init()")
                        }

                        return HubkitClient(config: config, eventLoop: $0.eventLoopGroup.next(), client: $0.client)
                    }
                }
            }
            
            public let run: ((Application) -> Void)
            
            public init(_ run: @escaping ((Application) -> Void)) {
                self.run = run
            }
        }
        
        let app: Application
        
        private final class Storage {
            var configuration: HubkitConfiguration?
            var makeClient: HubkitFactory?
            
            init() {}
        }
        
        private struct Key: StorageKey {
            typealias Value = Storage
        }
        
        private var storage: Storage {
            if app.storage[Key.self] == nil {
                self.initialize()
            }
            
            return app.storage[Key.self]!
        }
        
        public func use(_ make: @escaping HubkitFactory) {
            storage.makeClient = make
        }
        
        public func use(_ provider: Application.Hubkit.Provider) {
            provider.run(app)
        }
        
        private func initialize() {
            app.storage[Key.self] = .init()
            app.hubkit.use(.live)
        }

        public var configuration: HubkitConfiguration? {
            get { storage.configuration }
            nonmutating set { storage.configuration = newValue }
        }
        
        public func client() -> HubkitProvider {
            guard let makeClient = storage.makeClient else {
                fatalError("Hubkit not configured, use: app.hubkit.use(.real)")
            }
            
            return makeClient(app)
        }
    }
    
    public var hubkit: Hubkit {
        .init(app: self)
    }
    
    public func hubkitClient() -> HubkitProvider {
        self.hubkit.client()
    }
}
