public struct MirrorDayPunch {
	public let hour: String
	public let type: String
	public let equipment: String

	init?(json: [String: Any]) {
		guard var hour = json["hora"] as? String,
			let type = json["tipo"] as? String,
			let equipment = json["equipamento"] as? String else {
				return nil
		}

		let twoDotsIndex = hour.index(hour.endIndex, offsetBy: -2)

		hour.insert(":", at: twoDotsIndex)

		self.hour = hour
		self.type = type
		self.equipment = equipment
	}
}
