//
//  RSDevPanelBuilder.swift
//

import Foundation

final class RSDevPanelBuilder {
    func build() -> RSDevPanel {
        let presenter = RDDevPanelPresenter()
        let interactor = RDDevPanelInteractor(presenter: presenter)
        let controller = RSDevPanel(interactor: interactor)
        presenter.controller = controller
        return controller
    }
}
