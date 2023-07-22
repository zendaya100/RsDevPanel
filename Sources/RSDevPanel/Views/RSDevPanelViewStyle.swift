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

