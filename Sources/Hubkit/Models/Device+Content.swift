import Vapor
import HubkitModel

extension Device: Content {}

public extension HubkitModel.Device {
    struct Form: Content {
        let project: UUID
        let name: String
        let macAddress: String
        let hardwareVersion: String
        let firmwareVersion: String
        let sensorType: String
        let manualMode: Bool
        let activated: Bool
        let latitude: Double?
        let longitude: Double?
        let battery: Int?
        let activatedAt: Date?
        let externalUUID: String?

        init(
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
