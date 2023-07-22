//
//  ExampleController.swift
//

import UIKit
import RSDevPanel

class ExampleController: BaseController {

    private let customView = ExampleView()

    override func loadView() {
        view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configure()
    }

    private func configureNavigationItem() {
        title = "Example"
        navigationItem.title = "Example"
    }

    private func configure() {
        // full method add element
        RSDevPanel.shared.addElement(RSDevPanelButtonElement(RSDevPanelButtonElementConfig(title: "Open VC2", action: { [weak self] in
            let vc2 = SecondViewController()
            self?.present(vc2, animated: true)
        }), holder: self))

        // shot method add element
        RSDP.add(.news(.init(source: .engadget, count: 2), self))

        // DEV: make example app better
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            RSDevPanel.shared.toggleShow()
        }
    }


}


class TestElement: RSDevPanelBaseElement {


    override var id: String {
        "Sdf"
    }

    override func getView() -> UIView {
        UIView()
    }
    override func viewWillAppear() {
//        infoView?.set(text: "Sdf")
//        infoView?.show()
        
    }
}
