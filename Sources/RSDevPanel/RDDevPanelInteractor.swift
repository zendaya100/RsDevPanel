//
//  RDDevPanelInteractor.swift
//

import Foundation

protocol RDDevPanelInteractorBusinessLogic {
    var isVisible: Bool { get }
    func request(_ request: RDDevPanelDataFlow.Initial.Request)
    func request(_ request: RDDevPanelDataFlow.Show.Request)
    func request(_ request: RDDevPanelDataFlow.Hide.Request)
    func request(_ request: RDDevPanelDataFlow.Toggle.Request)
    func request(_ request: RDDevPanelDataFlow.AddElement.Request)
}

final class RDDevPanelInteractor: RDDevPanelInteractorBusinessLogic {

    // MARK: - Internal variables

    var isVisible: Bool = false {
        didSet {
            configureCleanUpTimer()
        }
    }

    // MARK: - Private variables
    
    private let presenter: RDDevPanelPresentationLogic
    private var elements: [RSDevPanelBaseElement] = []

    private var cleanUpTimer: Timer?

    // MARK: - Inits

    init(presenter: RDDevPanelPresentationLogic) {
        self.presenter = presenter
    }

    // MARK: - Internal functions

    func request(_ request: RDDevPanelDataFlow.Initial.Request) {
        
    }

    func request(_ request: RDDevPanelDataFlow.Show.Request) {
        show()
    }

    func request(_ request: RDDevPanelDataFlow.Hide.Request) {
        hide()
    }

    func request(_ request: RDDevPanelDataFlow.Toggle.Request) {
        isVisible.toggle()
        if isVisible {
            show()
        } else {
            hide()
        }
    }

    func request(_ request: RDDevPanelDataFlow.AddElement.Request) {
        addElement(request.element)
    }

    // MARK: - Private functions

    private func show() {
        willAppearAll()
        presenter.present(RDDevPanelDataFlow.Show.Response(elements: elements))
        isVisible = true
    }

    private func hide() {
        presenter.present(RDDevPanelDataFlow.Hide.Response())
        isVisible = false
    }

    private func addElement(_ element: RSDevPanelBaseElement) {
        removeIfExists(element)
        element.delegate = self
        elements.append(element)
        if isVisible {
            willAppear(element)
        }
        presenter.present(RDDevPanelDataFlow.AddElement.Response(elements: elements))
    }

    private func removeIfExists(_ element: RSDevPanelBaseElement) {
        if let index = elements.firstIndex(where: { $0.id == element.id }) {
            elements.remove(at: index)
        }
    }

    private func configureCleanUpTimer() {
        if isVisible {
            startCleanUpTimer()
        } else {
            stopCleanUpTimer()
        }
    }

    private func startCleanUpTimer() {
        cleanUpTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                            target: self,
                                            selector: #selector(timerCheck),
                                            userInfo: nil,
                                            repeats: true)
    }

    private func stopCleanUpTimer() {
        cleanUpTimer?.invalidate()
        cleanUpTimer = nil
    }

    @objc private func timerCheck() {
        let removeElements = elements.filter { $0.holder == nil }
        removeElements.forEach(removeIfExists)
        if !removeElements.isEmpty {
            presenter.present(RDDevPanelDataFlow.TimerCheck.Response(updatedElements: elements))
        } else {
            presenter.present(RDDevPanelDataFlow.TimerCheck.Response(updatedElements: nil))
        }
    }

    private func willAppearAll() {
        elements.forEach { $0.viewWillAppear() }
    }

    private func willAppear(_ element: RSDevPanelBaseElement) {
        element.viewWillAppear()
    }

}

extension RDDevPanelInteractor: RSDevPanelBaseElementDelegate {
    func infoView(isShow: Bool) {
        presenter.present(RDDevPanelDataFlow.InfoView.Response(isShow: isShow, text: nil))
    }

    func infoView(set text: String) {
        presenter.present(RDDevPanelDataFlow.InfoView.Response(isShow: nil, text: text))
    }
}
