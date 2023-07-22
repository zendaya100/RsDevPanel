//
//  RSDevPanelNewsElement.swift
//

import UIKit

/// Element RSS News
public class RSDevPanelNewsElement: RSDevPanelBaseElement {
    public override var id: String { _id }

    // MARK: - Private variables

    private let _id: String = UUID().uuidString
    private let view = RSDevPanelNewsElementView()
    private let xmldelegate = RSDevPanelNewsElementXML()
    private let source: RSDevPanelNewsSource

    // MARK: - Inits

    public init(source: RSDevPanelNewsSource, count: Int, holder: AnyObject) {
        self.source = source
        super.init(holder: holder)
        xmldelegate.delegate = self
        xmldelegate.count = count
    }

    // MARK: - Overrides

    public override func getView() -> UIView {
        return view
    }

    public override func viewWillAppear() {
        load()
    }

    // MARK: - Private functions

    private func load() {
        let urlRequest = URLRequest(url: source.url)
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let data {
                let xml = XMLParser(data: data)
                xml.delegate = self.xmldelegate
                xml.parse()
            } else if let error {
                RSDevPanel.log("News loading error:", error.localizedDescription)
            }
            else {
                RSDevPanel.log("News loading error")
            }
            // DEV: display error state
        }.resume()
    }

}

extension RSDevPanelNewsElement: RSDevPanelNewsElementXMLDelegate {
    func xmlNews(items: [RSDevPanelNewsItem]) {
        let vm = RSDevPanelNewsElementViewModel(title: source.title, items: items)
        DispatchQueue.main.async { [weak self] in
            self?.view.set(vm)
        }

    }
}
