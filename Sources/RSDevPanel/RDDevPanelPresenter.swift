//
//  RDDevPanelPresenter.swift
//

import UIKit

protocol RDDevPanelPresentationLogic {
    func present(_ response: RDDevPanelDataFlow.Initial.Response)
    func present(_ response: RDDevPanelDataFlow.Show.Response)
    func present(_ response: RDDevPanelDataFlow.Hide.Response)
    func present(_ response: RDDevPanelDataFlow.Toggle.Response)
    func present(_ response: RDDevPanelDataFlow.AddElement.Response)
    func present(_ response: RDDevPanelDataFlow.TimerCheck.Response)
    func present(_ response: RDDevPanelDataFlow.InfoView.Response)
}

final class RDDevPanelPresenter: RDDevPanelPresentationLogic {
    weak var controller: RSDevPanelDisplayLogic?

    // MARK: Internal functions

    func present(_ response: RDDevPanelDataFlow.Initial.Response) {

    }

    func present(_ response: RDDevPanelDataFlow.Show.Response) {
        controller?.display(state: .show)

    }

    func present(_ response: RDDevPanelDataFlow.Hide.Response) {
        controller?.display(state: .hide)
    }

    func present(_ response: RDDevPanelDataFlow.Toggle.Response) {

    }

    func present(_ response: RDDevPanelDataFlow.AddElement.Response) {
        let views = response.elements.map { $0.getView() }
        controller?.display(state: .items(views))
    }

    func present(_ response: RDDevPanelDataFlow.TimerCheck.Response) {
        if let elements = response.updatedElements {
            let views = elements.map { $0.getView() }
            controller?.display(state: .items(views))
        }
        controller?.display(state: .bringToFront) // DEV: ref to new uiwindow?

    }

    func present(_ response: RDDevPanelDataFlow.InfoView.Response) {
        if let isShow = response.isShow {
            controller?.display(state: isShow ? .infoShow : .infoHide)
        }
        if let infoText = response.text {
            controller?.display(state: .infoText(infoText))
        }
    }

    // MARK: - Private functions

//    private func prepareViews(from elements: [RSDevPanelBaseElement]) -> [UIView] {
//        return elements.map { $0.getView() }
//    }
}
