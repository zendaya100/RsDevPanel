//
//  RSDevPanelElementView.swift
//

import UIKit
import SnapKit

/// Basic view to create an element
class RSDevPanelElementView: RSDevPanelBaseView {

    // MARK: - Internal variables

    let contentView = UIView()
    var insets: UIEdgeInsets  { .zero }

    // MARK: - Private variables

    // MARK: - Override functions

    override func addSubviews() {
        super.addSubviews()
        addSubview(contentView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }
    }
}
