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

    private func configure() {
        view.backgroundColor = .gray
    }

    private func configureDevPanel() {
        RSDevPanel.shared.addButton(RSDevPanelButtonElementConfig(title: "Make yellow", action: { [weak self] in
            self?.view.backgroundColor = .yellow
        }), holder: self)

        RSDevPanel.shared.addElement(RSDevPanelButtonElement(RSDevPanelButtonElementConfig(title: "Close VC2", action: { [weak self] in
            self?.dismiss(animated: true)
        }), holder: self))
    }
}
