//
//  RSDevPanelButtonElementView.swift
//

import UIKit
import SnapKit

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelButtonElementView {
    struct Constants {
        var insets: UIEdgeInsets { .init(top: 2, left: 0, bottom: 2, right: 0) }
        var buttonHeight: CGFloat { 24 }
        var buttonFont: UIFont { .systemFont(ofSize: 12) }
        var buttonCornerRadius: CGFloat { 4 }
    }
}

final class RSDevPanelButtonElementView: RSDevPanelElementView  {

    // MARK: - Internal variables

    override var insets: UIEdgeInsets { constants.insets }

    // MARK: - Private variables

    private let constants = Constants()
    private let button = UIButton(type: .system)

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(button)
    }

    override func makeConstraints() {
        super.makeConstraints()
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(constants.buttonHeight)
        }
    }

    override func configure() {
        super.configure()
        button.titleLabel?.font = constants.buttonFont
        button.layer.cornerRadius = constants.buttonCornerRadius
    }

    // MARK: - Internal functions

    func set(config: RSDevPanelButtonElementConfig) {
        button.setTitle(config.title, for: .normal)
        button.addAction(UIAction { _ in config.action() }, for: .touchUpInside)
        button.setTitleColor(config.titleColor, for: .normal)
        button.backgroundColor = config.backgroungColor
    }

}
