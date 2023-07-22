//
//  BaseController.swift
//

import UIKit
import RSDevPanel

class BaseController: UIViewController {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            RSDevPanel.shared.toggleShow()
        }
    }
}
