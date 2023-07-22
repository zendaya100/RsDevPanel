//
//  RSDevPanelNewsSource.swift
//

import Foundation

/// RSS news source
public struct RSDevPanelNewsSource {
    let title: String
    let url: URL

    /// RSS feed source initializer
    /// - Parameters:
    ///   - title: name to display
    ///   - url: link rss feed
    public init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
}

/// Preinstalled news aggregators. To add your own news source, extend class `RSDevPanelNewsSource`, or just create an instance of this class
public extension RSDevPanelNewsSource {

    static let engadget = Self(title: "Engadget",
                               url: URL(string: "https://www.engadget.com/rss.xml")!)

    static let bbcWorld = Self(title: "BBC World",
                               url: URL(string: "https://feeds.bbci.co.uk/news/world/rss.xml")!)

    static let cnet = Self(title: "CNET",
                               url: URL(string: "https://www.cnet.com/rss/news/")!)

    static let lentaRu = Self(title: "Lenta.ru",
                              url: URL(string: "https://lenta.ru/rss/top7")!)

    // DEV: need support
//    static let habrIOSRu = Self(title: "Habr iOS",
//                                url: URL(string: "https://habr.com/ru/rss/hub/ios_dev/all/?fl=ru")!)
//
//    static let habrIOSEn = Self(title: "Habr iOS",
//                                url: URL(string: "https://habr.com/ru/rss/hub/ios_dev/all/?fl=en")!)

}
