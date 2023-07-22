//
//  BaseView.swift
//

import UIKit


class BaseView: UIView {
    
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
