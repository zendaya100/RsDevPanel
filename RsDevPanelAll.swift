//
//  RSDevPanelBuilder.swift
//

// swiftlint:disable all
import Foundation

final class RSDevPanelBuilder {
    func build() -> RSDevPanel {
        let presenter = RDDevPanelPresenter()
        let interactor = RDDevPanelInteractor(presenter: presenter)
        let controller = RSDevPanel(interactor: interactor)
        presenter.controller = controller
        return controller
    }
}
//
//  RDDevPanelDataFlow.swift
//

import UIKit

enum RDDevPanelDataFlow {

    enum Initial {
        struct Request {

        }
        struct Response {

        }
    }

    enum Show {
        struct Request {

        }
        
        struct Response {
            let elements: [RSDevPanelBaseElement]
        }
    }

    enum Hide {
        struct Request {

        }
        struct Response {

        }
    }

    enum Toggle {
        struct Request {

        }
        struct Response {

        }
    }

    enum AddElement {
        struct Request {
            let element: RSDevPanelBaseElement
        }
        
        struct Response{
            let elements: [RSDevPanelBaseElement]
        }
    }

    enum TimerCheck {
        struct Response{
            let updatedElements: [RSDevPanelBaseElement]?
        }
    }

    enum InfoView {
        struct Response {
            let isShow: Bool?
            let text: String?
        }
    }

    enum ViewModel {
        case items([UIView])
        case panelShow(Bool)
        case bringToFront
        case infoShow(Bool)
        case infoText(String)
    }
    
}
//
//  Constants.swift
//

import Foundation

enum Constants {
    static let logPrefix: String = "!!! RSDevPanel"
}
//
//  Extensions.swift
//

// DEV: check ios14
// DEV: geenrate one file script, swiftlint

import UIKit
import SnapKit

extension UIEdgeInsets {
    var verticalInsets: CGFloat {
        self.top + self.bottom
    }
}

extension UIWindow {
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first(where: \.isKeyWindow)
    }
}
//
//  RSDevPanelTools.swift
//

import Foundation

/// Вспомогательные инструменты
public enum RSDevPanelTools {

    /// Convert json string to json object
    /// - Parameter jsonString: json string
    /// - Returns: object
    public static func jsonObject(from jsonString: String) -> Any? {
        let jsonString = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }

        do {
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            RSDevPanel.log(#function, error)
            return nil
        }
    }
}
//
//  RSSimpleStorage.swift
//

import Foundation

/// Simple data storage (in ram memory)
final public class RSSimpleStorage {
    class TypeNotDefined {}

    /// Subscript for Dictionary
    public subscript(key: String) -> Any? {
        get {
            return dict[key]
        }
        set(newValue) {
            dict[key] = newValue
        }
    }

    /// Dictionary
    public var dict: [String: Any] = [:] {
        didSet { logDict() }
    }

    // MARK: - Fast variables
    
    public var any1: Any = TypeNotDefined() {
        didSet { log(nameId: 1, value: any1) }
    }

    public var any2: Any = TypeNotDefined() {
        didSet { log(nameId: 2, value: any2) }
    }

    public var any3: Any = TypeNotDefined() {
        didSet { log(nameId: 3, value: any3) }
    }

    public var any4: Any = TypeNotDefined() {
        didSet { log(nameId: 4, value: any4) }
    }

    public var any5: Any = TypeNotDefined() {
        didSet { log(nameId: 5, value: any5) }
    }

    public var any6: Any = TypeNotDefined() {
        didSet { log(nameId: 6, value: any6) }
    }

    public var any7: Any = TypeNotDefined() {
        didSet { log(nameId: 7, value: any7) }
    }

    public var any8: Any = TypeNotDefined() {
        didSet { log(nameId: 8, value: any8) }
    }

    public var any9: Any = TypeNotDefined() {
        didSet { log(nameId: 9, value: any9) }
    }

    public var any10: Any = TypeNotDefined() {
        didSet { log(nameId: 10, value: any10) }
    }

    // MARK: - Private functions

    private func log(nameId: Int, value: Any) {
        RSDevPanel.log("SimpleStorage. Set Any\(nameId) (\(type(of: value)))", value)
    }

    private func logDict() {
        RSDevPanel.log("SimpleStorage. Update dict", dict)
    }
}
//
//  RSDevPanelKeysElement.swift
//

import UIKit

/// Element group of horizontal buttons
public class RSDevPanelKeysElement: RSDevPanelBaseElement {

    public override var id: String { configs.map {$0.title}.joined() }

    // MARK: - Private variables

    private let configs: [RSDevPanelButtonElementConfig]

    private let stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 4
        return stackview
    }()

    // MARK: - Inits

    /// Element initializer - a group of horizontal buttons
    /// - Parameters:
    ///   - configs: button configurations
    ///   - holder: element holder
    public init(_ configs: [RSDevPanelButtonElementConfig], holder: AnyObject?) {
        self.configs = configs
        super.init(holder: holder)
        createButtons()
    }

    // MARK: - Overrides

    public override func getView() -> UIView {
        return stackview
    }

    // MARK: - Private functions

    private func createButtons() {
        configs.forEach { config in
            let buttonView = RSDevPanelButtonElementView()
            buttonView.set(config: config)
            stackview.addArrangedSubview(buttonView)
        }
    }

}

//
//  RSDevPanelSliderElement.swift
//

import UIKit

/// Element Slider
public class RSDevPanelSliderElement: RSDevPanelBaseElement {
    public override var id: String { config.title }

    // MARK: - Private variables
    
    private let view = RSDevPanelSliderElementView()
    private let config: RSDevPanelSliderElementConfig

    // MARK: - Inits
 
    /// Slider element initializer
    /// - Parameters:
    ///   - config: slider configuration
    ///   - holder: element holder
    public init(_ config: RSDevPanelSliderElementConfig, holder: AnyObject?) {
        self.config = config
        super.init(holder: holder)
        view.delegate = self
        view.set(config: config)
    }

    // MARK: - Overrides

    public override func getView() -> UIView {
        return view
    }
}

// MARK: - RSDevPanelSliderViewDelegate

extension RSDevPanelSliderElement: RSDevPanelSliderViewDelegate {
    func sliderStartChanging(value: Float) {
        delegate?.infoView(isShow: true)
        delegate?.infoView(set: String(value))
    }

    func sliderValueChanging(value: Float) {
        delegate?.infoView(set: String(value))
        if config.isContinuous {
            config.onChange(value)
        }
    }

    func sliderEndChanging(value: Float) {
        delegate?.infoView(isShow: false)
        if !config.isContinuous {
            config.onChange(value)
        }
    }
}
//
//  RSDevPanelSliderView.swift
//

import UIKit

protocol RSDevPanelSliderViewDelegate: AnyObject {
    func sliderStartChanging(value: Float)
    func sliderValueChanging(value: Float)
    func sliderEndChanging(value: Float)
}

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelSliderElementView {
    struct Constants {
        var insets: UIEdgeInsets { .init(top: 4, left: 0, bottom: 4, right: 0) }
        var titleFont: UIFont { .systemFont(ofSize: 11) }
        var titleColor: UIColor { .black }
    }
}

final class RSDevPanelSliderElementView: RSDevPanelElementView  {

    // MARK: - Internal variables

    weak var delegate: RSDevPanelSliderViewDelegate?

    override var insets: UIEdgeInsets { constants.insets }

    // MARK: - Private variables

    private let constants = Constants()

    private let stackView = UIStackView()
    private let slider = UISlider()
    private let titleLabel = UILabel()
    private var step: Float = 0.1

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(slider)
    }

    override func makeConstraints() {
        super.makeConstraints()
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        stackView.axis = .vertical
        titleLabel.font = constants.titleFont
        titleLabel.textColor = constants.titleColor
        titleLabel.numberOfLines = 1
    }

    // MARK: - Internal functions

    func set(config: RSDevPanelSliderElementConfig) {
        titleLabel.text = config.title
        slider.value = config.currentValue
        slider.minimumValue = config.minValue
        slider.maximumValue = config.maxValue
        slider.value = config.currentValue
        slider.addTarget(self, action: #selector(valueChangedHandle(slider:event:)), for: .valueChanged)
        step = config.step
    }

    // MARK: - Private functions

    @objc private func valueChangedHandle(slider: UISlider, event: UIEvent) {
        guard let phase = event.allTouches?.first?.phase else { return }
        let newRoundedValue = round(slider.value / step) * step
        slider.value = newRoundedValue

        switch phase {
        case .began:
            delegate?.sliderStartChanging(value: newRoundedValue)
        case .moved:
            delegate?.sliderValueChanging(value: newRoundedValue)
        case .ended:
            delegate?.sliderEndChanging(value: newRoundedValue)
        default:
            break
        }
    }
}
//
//  RSDevPanelButtonElement.swift
//

import UIKit

/// Element Button
public class RSDevPanelButtonElement: RSDevPanelBaseElement {
    public override var id: String { config.title }

    // MARK: - Private variables
    
    private let view = RSDevPanelButtonElementView()
    private let config: RSDevPanelButtonElementConfig

    // MARK: - Inits
    
    /// Button element initializer
    /// - Parameters:
    ///   - config: button configuration
    ///   - holder: element holder
    public init(_ config: RSDevPanelButtonElementConfig, holder: AnyObject?) {
        self.config = config
        super.init(holder: holder)
        view.set(config: config)
    }

    // MARK: - Overrides

    public override func getView() -> UIView {
        return view
    }
}
//
//  RSDevPanelButtonElementView.swift
//

import UIKit
import SnapKit

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelButtonElementView {
    struct Constants {
        var insets: UIEdgeInsets { .init(top: 2, left: 0, bottom: 2, right: 0) }
        var buttonHeight: CGFloat { 24 }
        var buttonFont: UIFont { .systemFont(ofSize: 12) }
        var buttonCornerRadius: CGFloat { 4 }
    }
}

final class RSDevPanelButtonElementView: RSDevPanelElementView  {

    // MARK: - Internal variables

    override var insets: UIEdgeInsets { constants.insets }

    // MARK: - Private variables

    private let constants = Constants()
    private let button = UIButton(type: .system)

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(button)
    }

    override func makeConstraints() {
        super.makeConstraints()
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(constants.buttonHeight)
        }
    }

    override func configure() {
        super.configure()
        button.titleLabel?.font = constants.buttonFont
        button.layer.cornerRadius = constants.buttonCornerRadius
    }

    // MARK: - Internal functions

    func set(config: RSDevPanelButtonElementConfig) {
        button.setTitle(config.title, for: .normal)
        button.addAction(UIAction { _ in config.action() }, for: .touchUpInside)
        button.setTitleColor(config.titleColor, for: .normal)
        button.backgroundColor = config.backgroungColor
    }

}
//
//  RSDevPanelButtonConfig.swift
//

import UIKit

/// Button element configuration
public struct RSDevPanelButtonElementConfig {
    let title: String
    let titleColor: UIColor
    let backgroungColor: UIColor
    let action: () -> Void

    /// Button element configuration initializer
    /// - Parameters:
    ///   - title: button title
    ///   - titleColor: title color
    ///   - backgroungColor: button fill color
    ///   - action: action to be performed
    public init(
        title: String,
        titleColor: UIColor = RSDevPanelViewStyle.default.button.titleColor,
        backgroungColor: UIColor = RSDevPanelViewStyle.default.button.backgroundColor,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.titleColor = titleColor
        self.backgroungColor = backgroungColor
        self.action = action
    }
}
//
//  RSDevPanelNewsElementXML.swift
//

import Foundation

protocol RSDevPanelNewsElementXMLDelegate: AnyObject {
    func xmlNews(items: [RSDevPanelNewsItem])
}

class RSDevPanelNewsElementXML: NSObject {

    // MARK: - Internal variables

    weak var delegate: RSDevPanelNewsElementXMLDelegate?
    var count: Int = 1

    // MARK: - Private variables

    private var newsItems: [RSDevPanelNewsItem] = []
    private var isInsideItem: Bool = false
    private var subElement: Elements = .other
    private var currentTitle: String?
    private var currentLink: String?

    private enum Elements: String {
        case other = "other"
        case item = "item"
        case itemTitle = "title"
        case itemLink = "link"
    }
}

// MARK: - XMLParserDelegate

extension RSDevPanelNewsElementXML: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == Elements.item.rawValue {
            isInsideItem = true
            return
        }

        if isInsideItem {
            switch elementName {
            case "title":
                subElement = .itemTitle
            case "link":
                subElement = .itemLink
            default:
                subElement = .other
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard elementName == Elements.item.rawValue else { return }

        if
            let title = currentTitle,
            let link = currentLink,
            let url = URL(string: link)
        {
            let item = RSDevPanelNewsItem(text: title, url: url)
            newsItems.append(item)
        }

        isInsideItem = false
        subElement = .other
        currentTitle = nil
        currentLink = nil
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty else { return }
        switch subElement {
        case .other:
            break
        case .item:
            break
        case .itemTitle:
            currentTitle = string
        case .itemLink:
            currentLink = string
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        let newItems = Array(newsItems.prefix(count))
        delegate?.xmlNews(items: newItems)
    }
}
//
//  RSDevPanelNewsElementConfig.swift
//

import Foundation

/// Button element configuration
public struct RSDevPanelNewsElementConfig {
    let source: RSDevPanelNewsSource
    let count: Int

    /// News element configuration initializer
    /// - Parameters:
    ///   - source: source rrs
    ///   - count: count news for view
    public init(
        source: RSDevPanelNewsSource,
        count: Int
    ) {
        self.source = source
        self.count = count
    }
}
//
//  RSDevPanelNewsElementView
//

import UIKit
import SnapKit

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelNewsElementView {
    struct Constants {
        var insets: UIEdgeInsets { .init(top: 2, left: 0, bottom: 2, right: 0) }
        var spacing: CGFloat { 4 }
        var textFont: UIFont { .systemFont(ofSize: 12) }
        var textColor: UIColor { .black }
        var titleFont: UIFont { .systemFont(ofSize: 12, weight: .bold) }
        var titleColor: UIColor { .black }
        var loadingText: String { "Loading..." }
    }
}

final class RSDevPanelNewsElementView: RSDevPanelElementView  {

    override var insets: UIEdgeInsets { constants.insets }

    // MARK: - Private variables
    private let constants = Constants()
    private let titleLabel = UILabel()
    private let newsStackView = UIStackView()

    private var items: [RSDevPanelNewsItem] = []

    // MARK: - Internal functions

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(titleLabel)
        contentView.addSubview(newsStackView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        newsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = constants.titleColor
        titleLabel.font = constants.titleFont
        newsStackView.axis = .vertical
        newsStackView.spacing = constants.spacing
        addLoading()
    }

    // MARK: - Internal functions

    func set(_ vm: RSDevPanelNewsElementViewModel) {
        self.titleLabel.text = vm.title
        self.items = vm.items
        newsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        items.enumerated().forEach { i, item in
            let newsItem = makeNewsItem(text: item.text, index: i)
            newsStackView.addArrangedSubview(newsItem)
        }
    }

    // MARK: - Private functions

    private func makeNewsItem(text: String, index: Int) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = constants.textFont
        label.textColor = constants.textColor
        label.text = text
        label.tag = index
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandle)))
        label.isUserInteractionEnabled = true
        return label
    }

    private func addLoading() {
        let loading = makeNewsItem(text: constants.loadingText, index: -1)
        newsStackView.addArrangedSubview(loading)
    }

    @objc private func tapHandle(recognizer: UITapGestureRecognizer) {
        guard
            let index = recognizer.view?.tag,
            index >= 0
        else {
            return
        }
        
        let url = items[index].url
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

}
//
//  RSDevPanelNewsElementViewModel.swift
//

import Foundation

struct RSDevPanelNewsElementViewModel {
    let title: String
    let items: [RSDevPanelNewsItem]
}

struct RSDevPanelNewsItem {
    let text: String
    let url: URL
}
//
//  RSDevPanelNewsElement.swift
//

import UIKit

/// Element RSS News
public class RSDevPanelNewsElement: RSDevPanelBaseElement {
    public override var id: String { _id }

    // MARK: - Private variables

    private let _id: String = UUID().uuidString
    private let view = RSDevPanelNewsElementView()
    private let xmldelegate = RSDevPanelNewsElementXML()
    private let source: RSDevPanelNewsSource

    // MARK: - Inits

    /// News element initializer
    /// - Parameters:
    ///   - config: news configuration
    ///   - holder: element holder
    public init(config: RSDevPanelNewsElementConfig, holder: AnyObject?) {
        self.source = config.source
        super.init(holder: holder)
        xmldelegate.delegate = self
        xmldelegate.count = config.count
    }

    // MARK: - Overrides

    public override func getView() -> UIView {
        return view
    }

    public override func viewWillAppear() {
        load()
    }

    // MARK: - Private functions

    private func load() {
        let urlRequest = URLRequest(url: source.url)
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let data {
                let xml = XMLParser(data: data)
                xml.delegate = self.xmldelegate
                xml.parse()
            } else if let error {
                RSDevPanel.log("News loading error:", error.localizedDescription)
            }
            else {
                RSDevPanel.log("News loading error")
            }
            // DEV: display error state
        }.resume()
    }

}

extension RSDevPanelNewsElement: RSDevPanelNewsElementXMLDelegate {
    func xmlNews(items: [RSDevPanelNewsItem]) {
        let vm = RSDevPanelNewsElementViewModel(title: source.title, items: items)
        DispatchQueue.main.async { [weak self] in
            self?.view.set(vm)
        }

    }
}
//
//  RSDevPanelNewsSource.swift
//

import Foundation

/// RSS news source
public struct RSDevPanelNewsSource {
    let title: String
    let url: URL

    /// RSS feed source initializer
    /// - Parameters:
    ///   - title: name to display
    ///   - url: link rss feed
    public init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
}

/// Preinstalled news aggregators. To add your own news source, extend class `RSDevPanelNewsSource`, or just create an instance of this class
public extension RSDevPanelNewsSource {

    static let engadget = Self(title: "Engadget",
                               url: URL(string: "https://www.engadget.com/rss.xml")!)

    static let bbcWorld = Self(title: "BBC World",
                               url: URL(string: "https://feeds.bbci.co.uk/news/world/rss.xml")!)

    static let cnet = Self(title: "CNET",
                               url: URL(string: "https://www.cnet.com/rss/news/")!)

    static let lentaRu = Self(title: "Lenta.ru",
                              url: URL(string: "https://lenta.ru/rss/top7")!)

    // DEV: need support
//    static let habrIOSRu = Self(title: "Habr iOS",
//                                url: URL(string: "https://habr.com/ru/rss/hub/ios_dev/all/?fl=ru")!)
//
//    static let habrIOSEn = Self(title: "Habr iOS",
//                                url: URL(string: "https://habr.com/ru/rss/hub/ios_dev/all/?fl=en")!)

}
//
//  RSDevPanelSliderConfig.swift
//

import UIKit

/// Slider element configuration
public struct RSDevPanelSliderElementConfig {
    let title: String
    let currentValue: Float
    let minValue: Float
    let maxValue: Float
    let step: Float
    let onChange: (Float) -> Void
    let isContinuous: Bool

    /// Slider element configuration initializer
    /// - Parameters:
    ///   - title: title
    ///   - currentValue: start value
    ///   - minValue: minimum value
    ///   - maxValue: maximum value
    ///   - step: chage step
    ///   - onChange: action on change
    ///   - isContinuous: Perform an action whenever the value changes when the slider is moved. If the value is `false` the action will be triggered when the user stops interacting with the slider
    public init(
        title: String,
        currentValue: Float,
        minValue: Float,
        maxValue: Float,
        step: Float,
        isContinuous: Bool,
        onChange: @escaping (Float) -> Void
        )
    {
        self.title = title
        self.currentValue = currentValue
        self.minValue = minValue
        self.maxValue = maxValue
        self.step = step
        self.onChange = onChange
        self.isContinuous = isContinuous
    }
}
//
//  RSDevPanelElementView.swift
//

import UIKit
import SnapKit

/// Basic view to create an element
class RSDevPanelElementView: RSDevPanelBaseView {

    // MARK: - Internal variables

    let contentView = UIView()
    var insets: UIEdgeInsets  { .zero }

    // MARK: - Private variables

    // MARK: - Override functions

    override func addSubviews() {
        super.addSubviews()
        addSubview(contentView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }
    }
}
//
//  RSDevPanelBaseElement.swift
//

import UIKit

public protocol RSDevPanelBaseElementDelegate: AnyObject {
    /// Show/hide info
    func infoView(isShow: Bool)

    /// Set text
    /// - Parameter text: text for display
    func infoView(set text: String)
}

/// Base class of the devpanel element
open class RSDevPanelBaseElement {
    open weak var delegate: RSDevPanelBaseElementDelegate?

    /// Unique identificator
    /// For example, you can use the button title
    open var id: String {
        fatalError("Inherit")
    }

    /// The element will be displayed as long as its holder exists
    weak var holder: AnyObject?

    /// Base class of the devpanel element initializer
    /// - Parameter holder: the element will be displayed as long as its holder exists
    public init(holder: AnyObject?) {
        self.holder = holder
    }

    /// Get a view of an element to display in the devpanel
    /// - Returns: вью
    open func getView() -> UIView {
        fatalError("Inherit")
    }

    /// The element will be appear
    open func viewWillAppear() {

    }

    // DEV: in dev
    /// The element disappear
//    open func viewDidDisappear() {
//
//    }
}
import UIKit

protocol RSDevPanelDisplayLogic: AnyObject {
    func display(state: RDDevPanelDataFlow.ViewModel)
}

/// Short alias
public typealias RSDP = RSDevPanel

/// Developer Panel
public class RSDevPanel {

    // MARK: - Public variables

    /// Class instance
    public static let shared: RSDevPanel = RSDevPanelBuilder().build()

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

    /// Method for quickly adding elements
    /// - Parameter item: added element
    public func add(_ item: RSDevPanelFastAdd) {
        addElement(item.element)
    }


    // MARK: - Internal static functions

    static func log(_ arg: Any...) {
        print(Constants.logPrefix, arg)
    }
}

// MARK: - Statict fast methods

extension RSDevPanel {
    /// Method for quickly adding one element
    /// - Parameters:
    ///   - item: element
    ///   - holder: element holder
    public static func add(_ item: RSDevPanelFastAdd, _ holder: AnyObject) {
        item.element.holder = holder
        RSDevPanel.shared.addElement(item.element)
    }

    /// Method for quickly adding many elements
    /// - Parameters:
    ///   - items: element
    ///   - holder: element holder
    public static func add(_ items: [RSDevPanelFastAdd], _ holder: AnyObject) {
        items.forEach {
            add($0, holder)
        }
    }
}

// MARK: - RSDevPanelDisplayLogic

extension RSDevPanel: RSDevPanelDisplayLogic {
    func display(state: RDDevPanelDataFlow.ViewModel) {
        switch state {
        case .items(let items):
            view.set(items: items)
        case .panelShow(let isShow):
            isShow ? view.show() : view.hide()
        case .bringToFront:
            view.bringToFront()
        case .infoShow(let isShow):
            view.infoView(isShow: isShow)
        case .infoText(let text):
            view.infoView(text: text)
        }
    }
}

// MARK: - RSDevPanelViewDelegate

extension RSDevPanel: RSDevPanelViewDelegate {
    func viewClosePressed() {
        interactor.request(RDDevPanelDataFlow.Hide.Request())
    }
}
//
//  RSDevPanelFastAdd.swift
//

import Foundation

/// Quick add Items
public struct RSDevPanelFastAdd {
    public let element: RSDevPanelBaseElement

    public init(element: RSDevPanelBaseElement) {
        self.element = element
    }

    /// Button element 
    /// - Parameters:
    ///   - config: configuration
    /// - Returns: Element to be added
    public static func button(_ config: RSDevPanelButtonElementConfig) -> RSDevPanelFastAdd {
        let element = RSDevPanelButtonElement(config, holder: nil)
        return Self(element: element)
    }

    /// Group of horizontal buttons
    /// - Parameters:
    ///   - configs: configurations
    /// - Returns: Element to be added
    public static func keys(_ configs: [RSDevPanelButtonElementConfig]) -> RSDevPanelFastAdd {
        let element = RSDevPanelKeysElement(configs, holder: nil)
        return Self(element: element)
    }

    /// Slider element
    /// - Parameters:
    ///   - config: configuration
    /// - Returns: Element to be added
    public static func slider(_ config: RSDevPanelSliderElementConfig) -> RSDevPanelFastAdd {
        let element = RSDevPanelSliderElement(config, holder: nil)
        return Self(element: element)
    }

    /// News element
    /// - Parameters:
    ///   - config: configuration
    /// - Returns: Element to be added
    public static func news(_ config: RSDevPanelNewsElementConfig) -> RSDevPanelFastAdd {
        let element = RSDevPanelNewsElement(config: config, holder: nil)
        return Self(element: element)
    }
}
//
//  RDDevPanelPresenter.swift
//

import UIKit

protocol RDDevPanelPresentationLogic {
    func present(_ response: RDDevPanelDataFlow.Initial.Response)
    func present(_ response: RDDevPanelDataFlow.Show.Response)
    func present(_ response: RDDevPanelDataFlow.Hide.Response)
    func present(_ response: RDDevPanelDataFlow.Toggle.Response)
    func present(_ response: RDDevPanelDataFlow.AddElement.Response)
    func present(_ response: RDDevPanelDataFlow.TimerCheck.Response)
    func present(_ response: RDDevPanelDataFlow.InfoView.Response)
}

final class RDDevPanelPresenter: RDDevPanelPresentationLogic {
    weak var controller: RSDevPanelDisplayLogic?

    // MARK: Internal functions

    func present(_ response: RDDevPanelDataFlow.Initial.Response) {

    }

    func present(_ response: RDDevPanelDataFlow.Show.Response) {
        controller?.display(state: .panelShow(true))

    }

    func present(_ response: RDDevPanelDataFlow.Hide.Response) {
        controller?.display(state: .panelShow(false))
    }

    func present(_ response: RDDevPanelDataFlow.Toggle.Response) {

    }

    func present(_ response: RDDevPanelDataFlow.AddElement.Response) {
        let views = response.elements.map { $0.getView() }
        controller?.display(state: .items(views))
    }

    func present(_ response: RDDevPanelDataFlow.TimerCheck.Response) {
        if let elements = response.updatedElements {
            let views = elements.map { $0.getView() }
            controller?.display(state: .items(views))
        }
        controller?.display(state: .bringToFront) // DEV: ref to new uiwindow?

    }

    func present(_ response: RDDevPanelDataFlow.InfoView.Response) {
        if let isShow = response.isShow {
            controller?.display(state: .infoShow(isShow))
        }
        if let infoText = response.text {
            controller?.display(state: .infoText(infoText))
        }
    }
}
//
//  RSDevPanelViewAppearance.swift
//

import UIKit

// DEV: Future
public struct RSDevPanelViewStyle {
    public let button: RSDevPanelButtonStyle
    public let panelColor: UIColor

    public static var `default` = RSDevPanelViewStyle(button: .default,
                                                      panelColor: .white/*.withAlphaComponent(0.8)*/)
    
}

// DEV: Future
public struct RSDevPanelButtonStyle {
    public let titleColor: UIColor
    public let backgroundColor: UIColor
    
    public static var `default` = RSDevPanelButtonStyle(titleColor: .white,
                                                        backgroundColor: .systemBlue)
}

//
//  RSDevPanelInfoView.swift
//

import UIKit

/// Window for displaying dynamic information
/// For example, the current slider value
public protocol RSDevPanelInfoViewProtocol: AnyObject {
    /// Show info
    func show()

    /// Hide info
    func hide()

    /// Set text
    /// - Parameter text: text for display
    func set(text: String)
}

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelInfoView {
    struct Constants {
        var insets: UIEdgeInsets { .init(top: 8, left: 8, bottom: 8, right: 8) }
        var cornerRadius: CGFloat { 8 }
        var textFont: UIFont { .systemFont(ofSize: 11) }
        var textColor: UIColor { .black }
        var backgroundColor: UIColor { .white }
        var showDuration: CGFloat { 0.2 }
        var hideDuration: CGFloat { 0.4 }
        var hideDelay: CGFloat { 0.3 }
    }
}

final class RSDevPanelInfoView: RSDevPanelBaseView, RSDevPanelInfoViewProtocol {

    // MARK: - Private variables

    private let constants = Constants()
    private let textLabel = UILabel()

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()
        addSubview(textLabel)
    }

    override func makeConstraints() {
        super.makeConstraints()
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(constants.insets)
        }
    }

    override func configure() {
        super.configure()
        backgroundColor = constants.backgroundColor
        layer.cornerRadius = constants.cornerRadius
        alpha = 0

        textLabel.font = constants.textFont
        textLabel.textColor = constants.textColor
        textLabel.textAlignment = .center
        textLabel.text = "..."
    }

    // MARK: - Internal functions

    func show() {
        UIView.animate(withDuration: constants.showDuration) { [weak self] in
            self?.alpha = 1
        }
    }

    func hide() {
        UIView.animate(withDuration: constants.hideDuration, delay: constants.hideDelay) { [weak self] in
            self?.alpha = 0
        }
    }

    func set(text: String) {
        textLabel.text = text
    }
}
//
//  RSDevPanelBaseView.swift
//

import UIKit

//struct RSDevPanelAppearance { } // DEV: find alternative for minified version lib

class RSDevPanelBaseView: UIView {
//   let appearance = RSDevPanelAppearance() // DEV: find alternative for minified version lib
    
    // MARK: - Inits

    init() {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal functions

    func addSubviews() {

    }

    func makeConstraints() {

    }

    func configure() {

    }
}
//
//  RSDevPanelCloseView.swift
//

import UIKit
import SnapKit

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelCloseView {
    struct Constants {
        var size: CGFloat { 20 }
        var image: UIImage? { .init(systemName: "xmark.circle.fill") }
        var imageTintColor: UIColor { .systemBlue }
        var backgroundColor: UIColor { .white }
    }
}

final class RSDevPanelCloseView: RSDevPanelBaseView {

    // MARK: - Private variables

    private let constants = Constants()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: constants.image)
        imageView.tintColor = constants.imageTintColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = constants.backgroundColor
        return view
    }()

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()
        addSubview(backgroundView)
        addSubview(imageView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        backgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(constants.size / 2)
        }

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(constants.size)
        }
    }
}
//
//  RSDevPanelView2.swift
//

import UIKit
import SnapKit

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelView {
    struct Constants {
        var panelWidth: CGFloat { 200 }
        var panelCornerRadius: CGFloat { 8 }
        var stackViewInsets: UIEdgeInsets { .init(top: 4, left: 8, bottom: 4, right: 8) }
        var style: RSDevPanelViewStyle { .default } // DEV: remove or some next release
        var infoTopOffset: CGFloat { 4 }
        var defaultOrigin: CGPoint { .init(x: 100, y: 100) }
    }
}

protocol RSDevPanelViewDelegate: AnyObject {
    func viewClosePressed()
}

class RSDevPanelView: RSDevPanelBaseView {
    weak var delegate: RSDevPanelViewDelegate?

    private let constants = Constants()
    private let closeImageView = RSDevPanelCloseView()

    private lazy var panelView: UIView = {
        let view = UIView()
        view.backgroundColor = constants.style.panelColor
        view.layer.cornerRadius = constants.panelCornerRadius
        return view
    }()

    private let elementsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private let infoView = RSDevPanelInfoView()

    private let emptyView: UIView = {
        let label = UILabel()
        label.text = "No elements"
        return label
    }()

    private var currentOrigin: CGPoint?
    private var dragStartOrigin: CGPoint = .zero
    private var rootTopConstraint: Constraint?
    private var rootLeadingConstraint: Constraint?

    // MARK: - Overrides functions

    override func addSubviews() {
        super.addSubviews()
        addSubview(closeImageView)
        addSubview(panelView)
        addSubview(infoView)
        panelView.addSubview(elementsStackView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        snp.makeConstraints {
            $0.width.equalTo(constants.panelWidth)
        }

        closeImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }

        panelView.snp.makeConstraints {
            $0.top.equalTo(closeImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        elementsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(constants.stackViewInsets)
        }

        infoView.snp.makeConstraints {
            $0.top.equalTo(panelView.snp.bottom).offset(constants.infoTopOffset)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGustureHandle)))
        closeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closePressedHandle)))
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .zero
        setEmptyState()
    }

    // MARK: - Internal functions

    func set(items: [UIView]) {
        elementsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        // DEV: refactor empty state
        if items.isEmpty {
            setEmptyState()
        } else {
            items.forEach(elementsStackView.addArrangedSubview)
        }
    }

    func show() {
        guard let keyWindow = UIWindow.keyWindow else { return }
        keyWindow.addSubview(self)
        keyWindow.bringSubviewToFront(self)
        let originPoint = getPanelOriginPoint()
        snp.makeConstraints {
            rootLeadingConstraint = $0.leading.equalToSuperview().inset(originPoint.x).constraint
            rootTopConstraint = $0.top.equalToSuperview().inset(originPoint.y).constraint
        }
    }

    func hide() {
        performHide()
    }

    // DEV: ref, new uiwindow?
    func bringToFront() {
        UIWindow.keyWindow?.bringSubviewToFront(self)
    }

    func infoView(isShow: Bool) {
        isShow ? infoView.show() : infoView.hide()
    }

    func infoView(text: String) {
        infoView.set(text: text)
    }

    // MARK: - Private functions

    private func setEmptyState() {
        elementsStackView.addArrangedSubview(emptyView)
    }

    private func getPanelOriginPoint() -> CGPoint {
        if let origin = currentOrigin {
            return CGPoint(x: origin.x, y: origin.y)
        } else {
            return constants.defaultOrigin // DEV: make center?
        }
    }

    @objc private func performHide() {
        removeFromSuperview()
    }

    @objc private func panGustureHandle(sender: UIPanGestureRecognizer) {
        guard
            let maxX = UIWindow.keyWindow?.frame.maxX,
            let maxY = UIWindow.keyWindow?.frame.maxY
        else {
            return
        }

        switch sender.state {
        case .began:
            dragStartOrigin = frame.origin
        case .changed:
            let translation = sender.translation(in: UIWindow.keyWindow)
            let x = min(maxX - frame.width, max(0, dragStartOrigin.x + translation.x))
            let y = min(maxY - frame.height, max(0, dragStartOrigin.y + translation.y))
            let newOrigin = CGPoint(x: x, y: y)
            frame.origin = newOrigin
        case .ended:
            rootTopConstraint?.update(inset: frame.origin.y)
            rootLeadingConstraint?.update(inset: frame.origin.x)
            currentOrigin = frame.origin
        default:
            break
        }
    }

    @objc private func closePressedHandle() {
        delegate?.viewClosePressed()
    }

}
//
//  RDDevPanelInteractor.swift
//

import Foundation

protocol RDDevPanelInteractorBusinessLogic {
    var isVisible: Bool { get }
    func request(_ request: RDDevPanelDataFlow.Initial.Request)
    func request(_ request: RDDevPanelDataFlow.Show.Request)
    func request(_ request: RDDevPanelDataFlow.Hide.Request)
    func request(_ request: RDDevPanelDataFlow.Toggle.Request)
    func request(_ request: RDDevPanelDataFlow.AddElement.Request)
}

final class RDDevPanelInteractor: RDDevPanelInteractorBusinessLogic {

    // MARK: - Internal variables

    var isVisible: Bool = false {
        didSet {
            configureCleanUpTimer()
        }
    }

    // MARK: - Private variables
    
    private let presenter: RDDevPanelPresentationLogic
    private var elements: [RSDevPanelBaseElement] = []

    private var cleanUpTimer: Timer?

    // MARK: - Inits

    init(presenter: RDDevPanelPresentationLogic) {
        self.presenter = presenter
    }

    // MARK: - Internal functions

    func request(_ request: RDDevPanelDataFlow.Initial.Request) {
        
    }

    func request(_ request: RDDevPanelDataFlow.Show.Request) {
        show()
    }

    func request(_ request: RDDevPanelDataFlow.Hide.Request) {
        hide()
    }

    func request(_ request: RDDevPanelDataFlow.Toggle.Request) {
        isVisible.toggle()
        if isVisible {
            show()
        } else {
            hide()
        }
    }

    func request(_ request: RDDevPanelDataFlow.AddElement.Request) {
        addElement(request.element)
    }

    // MARK: - Private functions

    private func show() {
        willAppearAll()
        presenter.present(RDDevPanelDataFlow.Show.Response(elements: elements))
        isVisible = true
    }

    private func hide() {
        presenter.present(RDDevPanelDataFlow.Hide.Response())
        isVisible = false
    }

    private func addElement(_ element: RSDevPanelBaseElement) {
        removeIfExists(element)
        element.delegate = self
        elements.append(element)
        if isVisible {
            willAppear(element)
        }
        presenter.present(RDDevPanelDataFlow.AddElement.Response(elements: elements))
    }

    private func removeIfExists(_ element: RSDevPanelBaseElement) {
        if let index = elements.firstIndex(where: { $0.id == element.id }) {
            elements.remove(at: index)
        }
    }

    private func configureCleanUpTimer() {
        if isVisible {
            startCleanUpTimer()
        } else {
            stopCleanUpTimer()
        }
    }

    private func startCleanUpTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(timerCheck),
                                         userInfo: nil,
                                         repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        cleanUpTimer = timer
    }

    private func stopCleanUpTimer() {
        cleanUpTimer?.invalidate()
        cleanUpTimer = nil
    }

    @objc private func timerCheck() {
        let removeElements = elements.filter { $0.holder == nil }
        removeElements.forEach(removeIfExists)
        if !removeElements.isEmpty {
            presenter.present(RDDevPanelDataFlow.TimerCheck.Response(updatedElements: elements))
        } else {
            presenter.present(RDDevPanelDataFlow.TimerCheck.Response(updatedElements: nil))
        }
    }

    private func willAppearAll() {
        elements.forEach { $0.viewWillAppear() }
    }

    private func willAppear(_ element: RSDevPanelBaseElement) {
        element.viewWillAppear()
    }

}

extension RDDevPanelInteractor: RSDevPanelBaseElementDelegate {
    func infoView(isShow: Bool) {
        presenter.present(RDDevPanelDataFlow.InfoView.Response(isShow: isShow, text: nil))
    }

    func infoView(set text: String) {
        presenter.present(RDDevPanelDataFlow.InfoView.Response(isShow: nil, text: text))
    }
}
