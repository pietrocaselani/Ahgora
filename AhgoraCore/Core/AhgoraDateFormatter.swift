import Foundation

public struct AhgoraDateFormatter {
	public static let instance = AhgoraDateFormatter()
	public let dateFormatter: DateFormatter

	private init() {
		self.dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
	}

	func date(from text: String) -> Date? {
		return dateFormatter.date(from: text)
	}
}
