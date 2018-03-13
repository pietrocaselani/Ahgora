import Foundation

public struct MirrorDay {
	static let empty = MirrorDay()
	public let punches: [MirrorDayPunch]
	public let results: [MirrorDayResult]
	public let date: Date

	init() {
		self.punches = [MirrorDayPunch]()
		self.results = [MirrorDayResult]()
		self.date = Date(timeIntervalSince1970: 0)
	}

	init?(json: [String: Any], date: Date) {
		guard let punchesJSON = json["batidas"] as? Array<Dictionary<String, Any>>,
			let resultsJSON = json["resultado"] as? Array<Dictionary<String, Any>> else {
				return nil
		}

		self.punches = punchesJSON.flatMap { MirrorDayPunch(json: $0) }
		self.results = resultsJSON.flatMap { MirrorDayResult(json: $0) }
		self.date = date
	}
}
