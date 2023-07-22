//
//  RSDevPanelNewsElementViewModel.swift
//

import Foundation

struct RSDevPanelNewsElementViewModel {
    let title: String
    let items: [RSDevPanelNewsItem]
}

struct RSDevPanelNewsItem {
    let text: String
    let url: URL
}
