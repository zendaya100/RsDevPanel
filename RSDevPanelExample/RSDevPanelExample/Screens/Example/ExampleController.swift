//
//  ExampleController.swift
//

import UIKit
import RSDevPanel

// DEV: make example app better like source lib
class ExampleController: BaseController {

    private let customView = ExampleView()

    // MARK: - Overrides

    override func loadView() {
        view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RSDevPanel.shared.show()
    }

    override func configureNavBar() {
        title = "Example VC"
    }

    // MARK: - Private functions

    private func configure() {
        // full method add element
        RSDevPanel.shared.addElement(RSDevPanelButtonElement(RSDevPanelButtonElementConfig(title: "Open VC2", action: { [weak self] in
            let vc2 = SecondViewController()
            self?.present(vc2, animated: true)
        }), holder: self))

        // shot method add element
        RSDP.add(.news(.init(source: .engadget, count: 2)), self)
    }
}
