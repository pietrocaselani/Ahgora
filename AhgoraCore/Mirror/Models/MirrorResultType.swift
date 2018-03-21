public enum MirrorResultType: Hashable {
	case workedHours
	case other(name: String)

	static func create(from value: String) -> MirrorResultType {
		if value == "Horas Trabalhadas" {
			return .workedHours
		} else {
			return .other(name: value)
		}
	}

	public var hashValue: Int {
		switch self {
		case .workedHours:
			return "Horas Trabalhadas".hashValue
		case .other(let name):
			return name.hashValue
		}
	}

	public var name: String {
		switch self {
		case .workedHours:
			return "Horas Trabalhadas"
		case .other(let name):
			return name
		}
	}

	public static func == (lhs: MirrorResultType, rhs: MirrorResultType) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
