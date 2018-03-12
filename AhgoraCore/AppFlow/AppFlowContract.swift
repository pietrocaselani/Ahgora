public protocol AppFlowView: class {
	var presenter: AppFlowPresenter! { get set }

	func show(pages: [ModulePage])
}

public protocol AppFlowModuleDataSource: class {
	var modulePages: [ModulePage] { get }
}

public protocol AppFlowPresenter: class {
	init(view: AppFlowView, dataSource: AppFlowModuleDataSource)

	func viewDidLoad()
}
