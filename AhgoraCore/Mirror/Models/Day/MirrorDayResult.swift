public struct MirrorDayResult {
	public let type: String
	public let value: String

	init?(json: [String: Any]) {
		guard let type = json["tipo"] as? String,
			let value = json["valor"] as? String else {
				return nil
		}

		self.type = type
		self.value = value
	}
}
