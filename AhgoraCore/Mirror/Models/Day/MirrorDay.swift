import Foundation
import TimeIntervals

public struct MirrorDay {
	static let empty = MirrorDay()
	public let punches: [MirrorDayPunch]
	public let results: [MirrorDayResult]
	public let date: Date
	private let dateFormatter: DateFormatter

	public var exitHour: String {
		let message = "Impossível calcular hora de saída"

		guard punches.count > 0 else {
			return ""
		}

		guard punches.count % 2 != 0, let lastPunch = punches.last else {
			return ""
		}

		let result = results.first { $0.type == MirrorResultType.workedHours }
		guard let workedHoursResult = result else {
			return message
		}

		guard let workedHours = workedHoursResult.workedHours else {
			return message
		}

		let values = lastPunch.hour.split(separator: ":")

		guard let hours = Int(values[0])?.hours, let minutes = Int(values[1])?.minutes else {
			return message
		}

		let exitTime = 8.hours - workedHours + hours + minutes

		let exitTimeDate = Date(timeIntervalSince1970: exitTime.timeInterval)

		let exitTimeText = dateFormatter.string(from: exitTimeDate)

		return exitTimeText
	}

	init() {
		self.punches = [MirrorDayPunch]()
		self.results = [MirrorDayResult]()
		self.date = Date(timeIntervalSince1970: 0)

		self.dateFormatter = DateFormatter()
		self.dateFormatter.timeZone = TimeZone(identifier: "GMT")
		self.dateFormatter.dateFormat = "HH:mm"
	}

	init?(json: [String: Any], date: Date) {
		guard let punchesJSON = json["batidas"] as? Array<Dictionary<String, Any>>,
			let resultsJSON = json["resultado"] as? Array<Dictionary<String, Any>> else {
				return nil
		}

		self.punches = punchesJSON.flatMap { MirrorDayPunch(json: $0) }
		self.results = resultsJSON.flatMap { MirrorDayResult(json: $0) }
		self.date = date

		self.dateFormatter = DateFormatter()
		self.dateFormatter.timeZone = TimeZone(identifier: "GMT")
		self.dateFormatter.dateFormat = "HH:mm"
	}
}
