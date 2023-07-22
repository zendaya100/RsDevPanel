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
    /// - Parameter configs: button configurations
    public init(_ configs: [RSDevPanelButtonElementConfig], holder: AnyObject) {
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

