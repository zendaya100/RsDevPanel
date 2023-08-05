//
//  RSSimpleStorage.swift
//

import Foundation

/// Simple data storage (in ram memory)
final public class RSSimpleStorage {
    class TypeNotDefined {}

    /// Subscript for Dictionary
    public subscript(key: String) -> Any? {
        get {
            return dict[key]
        }
        set(newValue) {
            dict[key] = newValue
        }
    }

    /// Dictionary
    public var dict: [String: Any] = [:] {
        didSet { logDict() }
    }

    // MARK: - Fast variables
    
    public var any1: Any = TypeNotDefined() {
        didSet { log(nameId: 1, value: any1) }
    }

    public var any2: Any = TypeNotDefined() {
        didSet { log(nameId: 2, value: any2) }
    }

    public var any3: Any = TypeNotDefined() {
        didSet { log(nameId: 3, value: any3) }
    }

    public var any4: Any = TypeNotDefined() {
        didSet { log(nameId: 4, value: any4) }
    }

    public var any5: Any = TypeNotDefined() {
        didSet { log(nameId: 5, value: any5) }
    }

    public var any6: Any = TypeNotDefined() {
        didSet { log(nameId: 6, value: any6) }
    }

    public var any7: Any = TypeNotDefined() {
        didSet { log(nameId: 7, value: any7) }
    }

    public var any8: Any = TypeNotDefined() {
        didSet { log(nameId: 8, value: any8) }
    }

    public var any9: Any = TypeNotDefined() {
        didSet { log(nameId: 9, value: any9) }
    }

    public var any10: Any = TypeNotDefined() {
        didSet { log(nameId: 10, value: any10) }
    }

    // MARK: - Private functions

    private func log(nameId: Int, value: Any) {
        RSDevPanel.log("SimpleStorage. Set Any\(nameId) (\(type(of: value)))", value)
    }

    private func logDict() {
        RSDevPanel.log("SimpleStorage. Update dict", dict)
    }
}
