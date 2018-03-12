public struct MirrorDayPunch {
	public let hour: String
	public let type: String
	public let equipment: String

	init?(json: [String: Any]) {
		guard let hour = json["hora"] as? String,
			let type = json["tipo"] as? String,
			let equipment = json["equipamento"] as? String else {
				return nil
		}

		self.hour = hour
		self.type = type
		self.equipment = equipment
	}
}
