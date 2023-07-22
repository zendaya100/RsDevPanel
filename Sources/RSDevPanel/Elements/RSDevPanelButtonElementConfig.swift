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
