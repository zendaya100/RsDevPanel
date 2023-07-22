//
//  RSDevPanelBaseView.swift
//

import UIKit

//struct RSDevPanelAppearance { } // DEV: find alternative for minified version lib

class RSDevPanelBaseView: UIView {
//   let appearance = RSDevPanelAppearance() // DEV: find alternative for minified version lib
    
    // MARK: - Inits

    init() {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal functions

    func addSubviews() {

    }

    func makeConstraints() {

    }

    func configure() {

    }
}
