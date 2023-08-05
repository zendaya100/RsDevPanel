//
//  RDDevPanelDataFlow.swift
//

import UIKit

enum RDDevPanelDataFlow {

    enum Initial {
        struct Request {

        }
        struct Response {

        }
    }

    enum Show {
        struct Request {

        }
        
        struct Response {
            let elements: [RSDevPanelBaseElement]
        }
    }

    enum Hide {
        struct Request {

        }
        struct Response {

        }
    }

    enum Toggle {
        struct Request {

        }
        struct Response {

        }
    }

    enum AddElement {
        struct Request {
            let element: RSDevPanelBaseElement
        }
        
        struct Response{
            let elements: [RSDevPanelBaseElement]
        }
    }

    enum TimerCheck {
        struct Response{
            let updatedElements: [RSDevPanelBaseElement]?
        }
    }

    enum InfoView {
        struct Response {
            let isShow: Bool?
            let text: String?
        }
    }

    enum ViewModel {
        case items([UIView])
        case panelShow(Bool)
        case bringToFront
        case infoShow(Bool)
        case infoText(String)
    }
    
}
