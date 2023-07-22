//
//  RSDevPanelView2.swift
//

import UIKit
import SnapKit

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelView {
    struct Constants {
        var panelWidth: CGFloat { 200 }
        var panelCornerRadius: CGFloat { 8 }
        var stackViewInsets: UIEdgeInsets { .init(top: 4, left: 8, bottom: 4, right: 8) }
        var style: RSDevPanelViewStyle { .default } // DEV: remove or some next release
        var infoTopOffset: CGFloat { 4 }
        var defaultOrigin: CGPoint { .init(x: 100, y: 100) }
    }
}

protocol RSDevPanelViewDelegate: AnyObject {
    func viewClosePressed()
}

class RSDevPanelView: RSDevPanelBaseView {
    weak var delegate: RSDevPanelViewDelegate?

    private let constants = Constants()
    private let closeImageView = RSDevPanelCloseView()

    private lazy var panelView: UIView = {
        let view = UIView()
        view.backgroundColor = constants.style.panelColor
        view.layer.cornerRadius = constants.panelCornerRadius
        return view
    }()

    private let elementsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private let infoView = RSDevPanelInfoView()

    private var currentOrigin: CGPoint?
    private var dragStartOrigin: CGPoint = .zero
    private var rootTopConstraint: Constraint?
    private var rootLeadingConstraint: Constraint?

    // MARK: - Overrides functions

    override func addSubviews() {
        super.addSubviews()
        addSubview(closeImageView)
        addSubview(panelView)
        addSubview(infoView)
        panelView.addSubview(elementsStackView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        snp.makeConstraints {
            $0.width.equalTo(constants.panelWidth)
        }

        closeImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }

        panelView.snp.makeConstraints {
            $0.top.equalTo(closeImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        elementsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(constants.stackViewInsets)
        }

        infoView.snp.makeConstraints {
            $0.top.equalTo(panelView.snp.bottom).offset(constants.infoTopOffset)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGustureHandle)))
        closeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closePressedHandle)))
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .zero
    }

    // MARK: - Internal functions

    func set(items: [UIView]) {
        elementsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        items.forEach(elementsStackView.addArrangedSubview)
    }

    func show() {
        guard let keyWindow = UIWindow.keyWindow else { return }
        keyWindow.addSubview(self)
        keyWindow.bringSubviewToFront(self)
        let originPoint = getPanelOriginPoint()
        snp.makeConstraints {
            rootLeadingConstraint = $0.leading.equalToSuperview().inset(originPoint.x).constraint
            rootTopConstraint = $0.top.equalToSuperview().inset(originPoint.y).constraint
        }
    }

    func hide() {
        performHide()
    }

    // DEV: ref, new uiwindow?
    func bringToFront() {
        UIWindow.keyWindow?.bringSubviewToFront(self)
    }

    func infoView(isShow: Bool) {
        isShow ? infoView.show() : infoView.hide()
    }

    func infoView(text: String) {
        infoView.set(text: text)
    }

    // MARK: - Private functions

    private func getPanelOriginPoint() -> CGPoint {
        if let origin = currentOrigin {
            return CGPoint(x: origin.x, y: origin.y)
        } else {
            return constants.defaultOrigin // DEV: make center?
        }
    }

    @objc private func performHide() {
        removeFromSuperview()
    }

    @objc private func panGustureHandle(sender: UIPanGestureRecognizer) {
        guard
            let maxX = UIWindow.keyWindow?.frame.maxX,
            let maxY = UIWindow.keyWindow?.frame.maxY
        else {
            return
        }

        switch sender.state {
        case .began:
            dragStartOrigin = frame.origin
        case .changed:
            let translation = sender.translation(in: UIWindow.keyWindow)
            let x = min(maxX - frame.width, max(0, dragStartOrigin.x + translation.x))
            let y = min(maxY - frame.height, max(0, dragStartOrigin.y + translation.y))
            let newOrigin = CGPoint(x: x, y: y)
            frame.origin = newOrigin
        case .ended:
            rootTopConstraint?.update(inset: frame.origin.y)
            rootLeadingConstraint?.update(inset: frame.origin.x)
            currentOrigin = frame.origin
        default:
            break
        }
    }

    @objc private func closePressedHandle() {
        delegate?.viewClosePressed()
    }

}
