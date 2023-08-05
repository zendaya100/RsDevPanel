//
//  RSDevPanelTools.swift
//

import Foundation

/// Вспомогательные инструменты
public enum RSDevPanelTools {

    /// Convert json string to json object
    /// - Parameter jsonString: json string
    /// - Returns: object
    public static func jsonObject(from jsonString: String) -> Any? {
        let jsonString = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }

        do {
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            RSDevPanel.log(#function, error)
            return nil
        }
    }
}
