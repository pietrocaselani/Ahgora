extension String {
	public mutating func formatAsAhgoraHour() {
		let endIndex = self.endIndex
		let twoDotsIndex = self.index(endIndex, offsetBy: -2)

		self.insert(":", at: twoDotsIndex)
	}
}
