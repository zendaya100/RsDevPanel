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
