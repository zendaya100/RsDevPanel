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
