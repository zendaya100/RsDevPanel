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
