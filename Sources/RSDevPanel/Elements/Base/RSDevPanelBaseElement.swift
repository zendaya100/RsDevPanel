//
//  RSDevPanelBaseElement.swift
//

import UIKit

public protocol RSDevPanelBaseElementDelegate: AnyObject {
    /// Show/hide info
    func infoView(isShow: Bool)

    /// Set text
    /// - Parameter text: text for display
    func infoView(set text: String)
}

/// Base class of the devpanel element
open class RSDevPanelBaseElement {
    open weak var delegate: RSDevPanelBaseElementDelegate?

    /// Unique identificator
    /// For example, you can use the button title
    open var id: String {
        fatalError("Inherit")
    }

    /// The element will be displayed as long as its holder exists
    weak var holder: AnyObject?

    /// Base class of the devpanel element initializer
    /// - Parameter holder: the element will be displayed as long as its holder exists
    public init(holder: AnyObject) {
        self.holder = holder
    }

    /// Get a view of an element to display in the devpanel
    /// - Returns: вью
    open func getView() -> UIView {
        fatalError("Inherit")
    }

    /// The element will be appear
    open func viewWillAppear() {

    }

    // DEV: in dev
    /// The element disappear
//    open func viewDidDisappear() {
//
//    }
}
