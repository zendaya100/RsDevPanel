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
    ///   - holder: element holder
    /// - Returns: Element to be added
    public static func button(_ config: RSDevPanelButtonElementConfig, _ holder: AnyObject) -> RSDevPanelFastAdd {
        let element = RSDevPanelButtonElement(config, holder: holder)
        return Self(element: element)
    }

    /// Group of horizontal buttons
    /// - Parameters:
    ///   - configs: configurations
    ///   - holder: element holder
    /// - Returns: Element to be added
    public static func keys(_ configs: [RSDevPanelButtonElementConfig], _ holder: AnyObject) -> RSDevPanelFastAdd {
        let element = RSDevPanelKeysElement(configs, holder: holder)
        return Self(element: element)
    }

    /// Slider element
    /// - Parameters:
    ///   - config: configuration
    ///   - holder: element holder
    /// - Returns: Element to be added
    public static func slider(_ config: RSDevPanelSliderElementConfig, _ holder: AnyObject) -> RSDevPanelFastAdd {
        let element = RSDevPanelSliderElement(config, holder: holder)
        return Self(element: element)
    }

    /// News element
    /// - Parameters:
    ///   - config: configuration
    ///   - holder: element holder
    /// - Returns: Element to be added
    public static func news(_ config: RSDevPanelNewsElementConfig, _ holder: AnyObject) -> RSDevPanelFastAdd {
        let element = RSDevPanelNewsElement(config: config, holder: holder)
        return Self(element: element)
    }
}
