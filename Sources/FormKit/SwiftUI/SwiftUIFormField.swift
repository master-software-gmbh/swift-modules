import Foundation
import SwiftUI

public struct SwiftUIFormField<Value: FormValue>: FormField {
    public var value: Value {
        didSet {
            if value.isSet {
                isTouched = true
            }
        }
    }

    public private(set) var isTouched: Bool = false
    private let initialValue: Value
    private let rules: [(any FormRule<Value>, LocalizedStringResource)]

    public init(
        initialValue: T,
        rules: [(any FormRule<Value>, LocalizedStringResource)] = []
    ) {
        self.initialValue = initialValue
        self.value = initialValue
        self.rules = rules
    }

    public var isValid: Bool {
        !isTouched || error == nil
    }

    public var error: LocalizedStringResource? {
        guard let firstError = rules.compactMap({ rule in
            return rule.0.validate(value: value) ? nil : rule.1
        }).first else {
            return nil
        }

        return firstError
    }

    public mutating func touch() {
        isTouched = true
    }

    public mutating func reset() {
        value = initialValue
        isTouched = false
    }
}
