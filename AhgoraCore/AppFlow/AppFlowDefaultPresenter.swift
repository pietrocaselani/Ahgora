public final class AppFlowDefaultPresenter: AppFlowPresenter {
	private weak var view: AppFlowView?
	private let dataSource: AppFlowModuleDataSource

	public init(view: AppFlowView, dataSource: AppFlowModuleDataSource) {
		self.view = view
		self.dataSource = dataSource
	}

	public func viewDidLoad() {
		view?.show(pages: dataSource.modulePages)
	}
}
