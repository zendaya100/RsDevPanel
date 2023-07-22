//
//  Extensions.swift
//

// DEV: check ios14
// DEV: makescript, swiftlint
// swiftlint:disable duplicate_imports
// swiftlint:disable file_length

import UIKit
import SnapKit

extension UIEdgeInsets {
    var verticalInsets: CGFloat {
        self.top + self.bottom
    }
}

extension UIWindow {
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first(where: \.isKeyWindow)
    }
}
