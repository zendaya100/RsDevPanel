//
//  ExampleView.swift
//

import UIKit
import RSDevPanel
import SnapKit

final class ExampleView: BaseView {

    // MARK: - Private variables

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private var items: [UILabel] = []
    private var fontSize: CGFloat = 17

    // MARK: - Overrides

    override func addSubviews() {
        super.addSubviews()
        addSubview(stackView)
    }

    override func makeConstraints() {
        super.makeConstraints()
        stackView.snp.makeConstraints {
            let insets: CGFloat = 16
            $0.top.equalTo(safeAreaLayoutGuide).inset(insets)
            $0.leading.trailing.equalToSuperview().inset(insets)
        }
    }

    override func configure() {
        super.configure()
        backgroundColor = .white
        configureInitialItems()
        configureDevPanel()
    }

    // MARK: - Private functions

    private func configureInitialItems() {
        (0...4).forEach { _ in
            addItem()
        }
    }

    private func configureDevPanel() {


        RSDevPanel.add(.button(RSDevPanelButtonElementConfig(title: "Add item", action: { [weak self] in
            self?.addItem()
        }), self))


        RSDevPanel.add(.button(RSDevPanelButtonElementConfig(title: "Remove item", action: { [weak self] in
            self?.removeItem()
        }), self))

        RSDevPanel.add(.slider(RSDevPanelSliderElementConfig(title: "Size (continuous)",
                                                             currentValue: 17,
                                                             minValue: 6,
                                                             maxValue: 32,
                                                             step: 1,
                                                             isContinuous: true, onChange: { [weak self] val in
            self?.size(val)
        }), self))

        RSDevPanel.add(.slider(RSDevPanelSliderElementConfig(title: "Size (not continuous)",
                                                             currentValue: 17,
                                                             minValue: 6,
                                                             maxValue: 32,
                                                             step: 1,
                                                             isContinuous: false, onChange: { [weak self] val in
            self?.size(val)
        }), self))

        RSDevPanel.shared.addElement(RSDevPanelKeysElement([
            .init(title: "Clear", backgroungColor: .red, action: { [weak self] in
                self?.clear()
            }),
            .init(title: "+5", action: { [weak self] in
                self?.addItem(count: 5)
            }),
            .init(title: "🐥", action: { [weak self] in
                self?.addItem(count: 1, text: "🐥🐥🐥🐥🐥")
            }),
            .init(title: "🐦", action: { [weak self] in
                self?.addItem(count: 1, text: "🐦🐦🐦🐦🐦")
            })
        ], holder: self))
    }

    private func addItem(count: Int = 1, text: String = "Item") {
        (1...count).forEach { _ in
            let item = createItem(text: text)
            items.append(item)
            stackView.addArrangedSubview(item)
        }
    }

    private func createItem(text: String) -> UILabel {
        let item = UILabel()
        item.text = text
        item.textColor = .black
        item.font = .systemFont(ofSize: fontSize)
        return item
    }

    private func removeItem() {
        guard let item = items.popLast() else { return }
        item.removeFromSuperview()
    }

    private func clear() {
        items = []
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    private func size(_ size: Float) {
        fontSize = CGFloat(size)
        items.forEach { item in
            item.font = .systemFont(ofSize: fontSize)
        }
    }

}
