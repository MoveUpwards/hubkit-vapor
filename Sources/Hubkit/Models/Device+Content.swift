import Vapor
import HubkitModel

extension Device: Content {}

public extension HubkitModel.Device {
    struct Form: Content {
        public let project: UUID
        public let name: String
        public let macAddress: String
        public let hardwareVersion: String
        public let firmwareVersion: String
        public let sensorType: String
        public let manualMode: Bool
        public let activated: Bool
        public let latitude: Double?
        public let longitude: Double?
        public let battery: Int?
        public let activatedAt: Date?
        public let externalUUID: String?
        
        public init(
            project: UUID,
            name: String,
            macAddress: String,
            hardwareVersion: String,
            firmwareVersion: String,
            sensorType: String,
            manualMode: Bool = false,
            activated: Bool = false,
            latitude: Double? = nil,
            longitude: Double? = nil,
            battery: Int? = nil,
            activatedAt: Date? = nil,
            externalUUID: String? = nil
        ) {
            self.project = project
            self.name = name
            self.macAddress = macAddress
            self.hardwareVersion = hardwareVersion
            self.firmwareVersion = firmwareVersion
            self.sensorType = sensorType
            self.manualMode = manualMode
            self.activated = activated
            self.latitude = latitude
            self.longitude = longitude
            self.battery = battery
            self.activatedAt = activatedAt
            self.externalUUID = externalUUID
        }
    }
}
