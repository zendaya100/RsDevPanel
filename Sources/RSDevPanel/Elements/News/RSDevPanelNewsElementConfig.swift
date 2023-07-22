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
