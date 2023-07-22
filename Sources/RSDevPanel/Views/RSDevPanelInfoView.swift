//
//  RSDevPanelInfoView.swift
//

import UIKit

/// Window for displaying dynamic information
/// For example, the current slider value
public protocol RSDevPanelInfoViewProtocol: AnyObject {
    /// Show info
    func show()

    /// Hide info
    func hide()

    /// Set text
    /// - Parameter text: text for display
    func set(text: String)
}

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelInfoView {
    struct Constants {
        var insets: UIEdgeInsets { .init(top: 8, left: 8, bottom: 8, right: 8) }
        var cornerRadius: CGFloat { 8 }
        var textFont: UIFont { .systemFont(ofSize: 11) }
        var textColor: UIColor { .black }
        var backgroundColor: UIColor { .white }
        var showDuration: CGFloat { 0.2 }
        var hideDuration: CGFloat { 0.4 }
        var hideDelay: CGFloat { 0.3 }
    }
}

final class RSDevPanelInfoView: RSDevPanelBaseView, RSDevPanelInfoViewProtocol {

    // MARK: - Private variables

    private let constants = Constants()
    private let textLabel = UILabel()

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()
        addSubview(textLabel)
    }

    override func makeConstraints() {
        super.makeConstraints()
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(constants.insets)
        }
    }

    override func configure() {
        super.configure()
        backgroundColor = constants.backgroundColor
        layer.cornerRadius = constants.cornerRadius
        alpha = 0

        textLabel.font = constants.textFont
        textLabel.textColor = constants.textColor
        textLabel.textAlignment = .center
        textLabel.text = "..."
    }

    // MARK: - Internal functions

    func show() {
        UIView.animate(withDuration: constants.showDuration) { [weak self] in
            self?.alpha = 1
        }
    }

    func hide() {
        UIView.animate(withDuration: constants.hideDuration, delay: constants.hideDelay) { [weak self] in
            self?.alpha = 0
        }
    }

    func set(text: String) {
        textLabel.text = text
    }
}
