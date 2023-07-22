import UIKit

protocol RSDevPanelDisplayLogic: AnyObject {
    func display(state: RDDevPanelDataFlow.ViewModel)
}

/// Developer Panel
public class RSDevPanel {

    // MARK: - Public variables

    /// Class instance
    public static let shared: RSDevPanel = {
        // DEV: builder
        let presenter = RDDevPanelPresenter()
        let interactor = RDDevPanelInteractor(presenter: presenter)
        let controller = RSDevPanel(interactor: interactor)
        presenter.controller = controller
        return controller
    }()

    /// Simple data storage
    public let simpleStorage = RSSimpleStorage()

    /// Panel Visibility
    public var isVisible: Bool {
        interactor.isVisible
    }

    // MARK: - Private variables

    private lazy var view: RSDevPanelView = {
        let view = RSDevPanelView()
        view.delegate = self
        return view
    }()

    private let interactor: RDDevPanelInteractorBusinessLogic

    // MARK: - Inits

    init(interactor: RDDevPanelInteractorBusinessLogic) {
        self.interactor = interactor
    }

    // MARK: - Public functions

    /// Hide or show the panel
    public func toggleShow() {
        interactor.request(RDDevPanelDataFlow.Toggle.Request())
    }

    /// Show panel
    public func show() {
        interactor.request(RDDevPanelDataFlow.Show.Request())
    }

    /// Hide panel
    public func hide() {
        interactor.request(RDDevPanelDataFlow.Hide.Request())
    }

    /// Add element
    /// - Parameter element: element inherited from base class
    public func addElement(_ element: RSDevPanelBaseElement) {
        interactor.request(RDDevPanelDataFlow.AddElement.Request(element: element))
    }

    /// Add an array of elements
    /// - Parameter elements: element inherited from base class
    public func addElements(_ elements: [RSDevPanelBaseElement]) {
        elements.forEach {
            addElement($0)
        }
    }

    /// Add Button
    /// Simplified use of `addElement`
    /// - Parameters:
    ///   - config: element configuration
    ///   - holder: the element will be displayed as long as its holder exists
    public func addButton(_ config: RSDevPanelButtonElementConfig, holder: AnyObject) {
        let element = RSDevPanelButtonElement(config, holder: holder)
        addElement(element)
    }

    /// Add Slider
    /// Simplified use of `addElement`
    /// - Parameters:
    ///   - config: element configuration
    ///   - holder: the element will be displayed as long as its holder exists
    public func addSlider(_ config: RSDevPanelSliderElementConfig, holder: AnyObject) {
        let element = RSDevPanelSliderElement(config, holder: holder)
        addElement(element)
    }

    // MARK: - Internal static functions

    static func log(_ arg: Any...) {
        print(Constants.logPrefix, arg)
    }
}

extension RSDevPanel: RSDevPanelDisplayLogic {
    func display(state: RDDevPanelDataFlow.ViewModel) {
        switch state {
        case .items(let items):
            view.set(items: items)
        case .show:
            view.show()
        case .hide:
            view.hide()
        case .bringToFront:
            view.bringToFront()
        case .infoShow:
            view.infoView(isShow: true)
        case .infoHide:
            view.infoView(isShow: false)
        case .infoText(let text):
            view.infoView(text: text)
        }
    }
}

extension RSDevPanel: RSDevPanelViewDelegate {
    func viewClosePressed() {
        interactor.request(RDDevPanelDataFlow.Hide.Request())
    }
}

// DEV: ref
fileprivate enum Constants {
    static let logPrefix: String = "!!! RSDevPanel"
}
