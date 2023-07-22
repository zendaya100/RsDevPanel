//
//  RSDevPanelNewsElementXML.swift
//

import Foundation

protocol RSDevPanelNewsElementXMLDelegate: AnyObject {
    func xmlNews(items: [RSDevPanelNewsItem])
}

class RSDevPanelNewsElementXML: NSObject {

    // MARK: - Internal variables

    weak var delegate: RSDevPanelNewsElementXMLDelegate?
    var count: Int = 1

    // MARK: - Private variables

    private var newsItems: [RSDevPanelNewsItem] = []
    private var isInsideItem: Bool = false
    private var subElement: Elements = .other
    private var currentTitle: String?
    private var currentLink: String?

    private enum Elements: String {
        case other = "other"
        case item = "item"
        case itemTitle = "title"
        case itemLink = "link"
    }
}

// MARK: - XMLParserDelegate

extension RSDevPanelNewsElementXML: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == Elements.item.rawValue {
            isInsideItem = true
            return
        }

        if isInsideItem {
            switch elementName {
            case "title":
                subElement = .itemTitle
            case "link":
                subElement = .itemLink
            default:
                subElement = .other
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard elementName == Elements.item.rawValue else { return }

        if
            let title = currentTitle,
            let link = currentLink,
            let url = URL(string: link)
        {
            let item = RSDevPanelNewsItem(text: title, url: url)
            newsItems.append(item)
        }

        isInsideItem = false
        subElement = .other
        currentTitle = nil
        currentLink = nil
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty else { return }
        switch subElement {
        case .other:
            break
        case .item:
            break
        case .itemTitle:
            currentTitle = string
        case .itemLink:
            currentLink = string
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        let newItems = Array(newsItems.prefix(count))
        delegate?.xmlNews(items: newItems)
    }
}
