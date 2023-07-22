//
//  RSDevPanelNewsElementView
//

import UIKit
import SnapKit

// DEV: Fileprivate extension is not suitable for distributing a library as a single file. Ref.
extension RSDevPanelNewsElementView {
    struct Constants {
        var insets: UIEdgeInsets { .init(top: 2, left: 0, bottom: 2, right: 0) }
        var spacing: CGFloat { 4 }
        var textFont: UIFont { .systemFont(ofSize: 12) }
        var textColor: UIColor { .black }
        var titleFont: UIFont { .systemFont(ofSize: 12, weight: .bold) }
        var titleColor: UIColor { .black }
        var loadingText: String { "Loading..." }
    }
}

final class RSDevPanelNewsElementView: RSDevPanelElementView  {

    override var insets: UIEdgeInsets { constants.insets }

    // MARK: - Private variables
    private let constants = Constants()
    private let titleLabel = UILabel()
    private let newsStackView = UIStackView()

    private var items: [RSDevPanelNewsItem] = []

    // MARK: - Internal functions

    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(titleLabel)
        contentView.addSubview(newsStackView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        newsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func configure() {
        super.configure()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = constants.titleColor
        titleLabel.font = constants.titleFont
        newsStackView.axis = .vertical
        newsStackView.spacing = constants.spacing
        addLoading()
    }

    // MARK: - Internal functions

    func set(_ vm: RSDevPanelNewsElementViewModel) {
        self.titleLabel.text = vm.title
        self.items = vm.items
        newsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        items.enumerated().forEach { i, item in
            let newsItem = makeNewsItem(text: item.text, index: i)
            newsStackView.addArrangedSubview(newsItem)
        }
    }

    // MARK: - Private functions

    private func makeNewsItem(text: String, index: Int) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = constants.textFont
        label.textColor = constants.textColor
        label.text = text
        label.tag = index
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandle)))
        label.isUserInteractionEnabled = true
        return label
    }

    private func addLoading() {
        let loading = makeNewsItem(text: constants.loadingText, index: -1)
        newsStackView.addArrangedSubview(loading)
    }

    @objc private func tapHandle(recognizer: UITapGestureRecognizer) {
        guard
            let index = recognizer.view?.tag,
            index >= 0
        else {
            return
        }
        
        let url = items[index].url
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

}
