import Foundation

public final class DefaultDateProvider: DateProvider {
	public var now: Date { return Date() }

	public init() {}
}
