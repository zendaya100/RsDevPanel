//
//  RsDevPanelWindow.swift
//

import UIKit

final class RsDevPanelWindow: UIWindow {
    var hitTestWindow: UIWindow?

//    init(frame: CGRect, keyWindow: UIWindow) {
//        self.keyWindow = keyWindow
//        super.init(frame: frame)
//    }

//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let view = super.hitTest(point, with: event), view != self {
            return view
        }
        guard let hitTestWindow else { return nil }
    
        return hitTestWindow.hitTest(hitTestWindow.convert(point, from: self), with: event)
    }
}
