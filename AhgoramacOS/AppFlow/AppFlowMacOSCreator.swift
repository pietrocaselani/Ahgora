import AhgoraCore

final class AppFlowMacOSCreator: AppFlowModuleDataSource {
	var modulePages: [ModulePage]

	init() {
		let punchView = PunchModule.setupModule()
		let punchPage = ModulePage(view: punchView, title: "Ponto")

		let settingsView = SettingsModule.setupModule()
		let settingsPage = ModulePage(view: settingsView, title: "Configurações")

		let mirrorView = MirrorModule.setupModule()
		let mirrorPage = ModulePage(view: mirrorView, title: "Espelho")

		self.modulePages = [punchPage, mirrorPage, settingsPage]
	}
}
