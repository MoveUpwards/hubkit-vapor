import Vapor
import HubkitModel

extension HubkitModel.AlgorithmType.Ippt: Content {}

extension HubkitModel.AlgorithmType {
    public struct IpptForm: Content {
        public let algorithm: String
        public let type: String
        public let params: Ippt

        enum CodingKeys: String, CodingKey {
            case algorithm = "algorithm"
            case type = "dataType"
            case params
        }

        public init(algorithm: AlgorithmType, params: Ippt) throws {
            self.algorithm = algorithm.algorithm
            self.type = algorithm.dataType
            self.params = params
        }
    }
}

extension HubkitModel.AlgorithmType.Session: Content {}

extension HubkitModel.AlgorithmType {
    public struct SessionForm: Content {
        public let algorithm: String
        public let type: String
        public let params: Session

        enum CodingKeys: String, CodingKey {
            case algorithm = "algorithm"
            case type = "dataType"
            case params
        }

        public init(algorithm: AlgorithmType, params: Session) throws {
            self.algorithm = algorithm.algorithm
            self.type = algorithm.dataType
            self.params = params
        }
    }
}

extension HubkitModel.AlgorithmType.Timeline: Content {}

extension HubkitModel.AlgorithmType {
    public struct TimelineForm: Content {
        public let algorithm: String
        public let type: String
        public let params: Timeline

        enum CodingKeys: String, CodingKey {
            case algorithm = "algorithm"
            case type = "dataType"
            case params
        }

        public init(algorithm: AlgorithmType, params: Timeline) throws {
            self.algorithm = algorithm.algorithm
            self.type = algorithm.dataType
            self.params = params
        }
    }
}
