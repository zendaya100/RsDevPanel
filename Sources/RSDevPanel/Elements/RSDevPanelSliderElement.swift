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
    /// - Parameter config: slider configuration
    public init(_ config: RSDevPanelSliderElementConfig, holder: AnyObject) {
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
