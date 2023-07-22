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
        title = "Example"
        navigationItem.title = "Example"

        RSDevPanel.shared.addElement(RSDevPanelButtonElement(RSDevPanelButtonElementConfig(title: "Open VC2", action: { [weak self] in
            let vc2 = SecondViewController()
            self?.present(vc2, animated: true)
        }), holder: self))
//
        RSDevPanel.shared.addElement(RSDevPanelNewsElement(source: .engadget, count: 2, holder: self))
//        RSDevPanel.shared.addElement(RSDevPanelNewsElement(source: .habrIOSRu, count: 3, holder: self))
//
//        RSDevPanel.shared.addElements([
//            RSDevPanelButtonElement(.init(title: "test 01", action: {
//                print("Test run 10")
//            }), holder: self),
//            RSDevPanelButtonElement(.init(title: "test 02", action: {
//                print("Test run 02", RSDevPanel.shared.simpleStorage.any1 as? String)
//            }), holder: self)
//        ])
////
////        RSDevPanel.shared.addButton(RSDevPanelButtonElementConfig(title: "test 03", action: {
////            print("Test run 03")
////        }), holder: self)
////        RSDevPanel.shared.addButton(RSDevPanelButtonElementConfig(title: "test 04", action: {
////            print("Test run 04", RSDevPanel.shared.simpleStorage.any1 as? String)
////        }), holder: self)
////
////        RSDevPanel.shared.addSlider(RSDevPanelSliderElementConfig(title: "Alpha",
////                                                           currentValue: 0,
////                                                           minValue: 0,
////                                                           maxValue: 100,
////                                                           step: 1,
////                                                           onChange: { [weak self] val in
////            print("Test run 3", val)
////            RSDevPanel.shared.simpleStorage.dict["test"] = 111
////            self?.view.backgroundColor = .white.withAlphaComponent(CGFloat(val) / 100)
////        }, isContinuous: true), holder: self)
//

//
//        RSDevPanel.shared.addElement(RSDevPanelKeysElement([
//            .init(title: "1", action: {
//                print("A1")
//            }),
//            .init(title: "2", action: {
//                print("A2")
//            }),
//            .init(title: "3", action: {
//                print("A3")
//            }),
//            .init(title: "4", action: {
//                print("A4")
//            })
//        ], holder: self))
//
 
//
//
//        RSDevPanel.shared.addElement(RSDevPanelNewsElement(source: .lentaRu, count: 3, holder: self))


        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            RSDevPanel.shared.toggleShow()
        }

//        DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
//            self.present(SecondViewController(), animated: true)
//        }

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
