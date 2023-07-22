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
