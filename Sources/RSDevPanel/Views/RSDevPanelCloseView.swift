//
//  RSDevPanelCloseView.swift
//

import UIKit
import SnapKit

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelCloseView {
    struct Constants {
        var size: CGFloat { 20 }
        var image: UIImage? { .init(systemName: "xmark.circle.fill") }
        var imageTintColor: UIColor { .systemBlue }
        var backgroundColor: UIColor { .white }
    }
}

final class RSDevPanelCloseView: RSDevPanelBaseView {

    // MARK: - Private variables

    private let constants = Constants()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: constants.image)
        imageView.tintColor = constants.imageTintColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = constants.backgroundColor
        return view
    }()

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()
        addSubview(backgroundView)
        addSubview(imageView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        backgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(constants.size / 2)
        }

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(constants.size)
        }
    }
}
