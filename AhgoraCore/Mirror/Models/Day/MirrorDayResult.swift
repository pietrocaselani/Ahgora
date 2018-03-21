import TimeIntervals

public struct MirrorDayResult {
	public let type: MirrorResultType
	public let value: String

	public var workedHours: Interval<Hour>? {
		guard type == .workedHours else {
			return nil
		}

		let values = value.split(separator: ":")
		let hourText = values[0]
		let minutesText = values[1]

		guard let hours = Int(hourText), let minutes = Int(minutesText) else {
			return nil
		}

		let workedHours = hours.hours + minutes.minutes

		return workedHours
	}

	init?(json: [String: Any]) {
		guard let typeJSON = json["tipo"] as? String,
			var valueJSON = json["valor"] as? String else {
				return nil
		}

		self.type = MirrorResultType.create(from: typeJSON)

		if type == .workedHours {
			valueJSON.formatAsAhgoraHour()
		}

		self.value = valueJSON
	}
}
