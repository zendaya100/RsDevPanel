//
//  SecondViewController.swift
//

import UIKit
import RSDevPanel

final class SecondViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureDevPanel()
    }

    override func configureNavBar() {
        title = "Second VC"
    }

    private func configure() {
        view.backgroundColor = .gray
    }

    private func configureDevPanel() {
        RSDevPanel.add(.button(.init(title: "Make yellow", action: { [weak self] in
            self?.view.backgroundColor = .yellow
        }), self))

        RSDevPanel.add(.button(.init(title: "Close VC2", action: { [weak self] in
            self?.dismiss(animated: true)
        }), self))

        // Custom created element
        RSDevPanel.add(.myTotoro(holder: self))
    }
}


// MARK: - Make own element easy!

class MyTotoro: RSDevPanelBaseElement {
    override var id: String { "totoro" }

    private let view: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "\nI am your Totoro!\nThis is a user-created element.\n"
        return label
    }()

    override func getView() -> UIView {
        view
    }
}

// Additionally, you can extend the RSDevPanelFastAdd class to quickly add an element
extension RSDevPanelFastAdd {
    static func myTotoro(holder: AnyObject) -> RSDevPanelFastAdd {
        let element = MyTotoro(holder: holder)
        return Self(element: element)
    }
}
