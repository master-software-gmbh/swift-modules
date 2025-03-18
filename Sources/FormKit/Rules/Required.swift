import Foundation

public struct Required<T: FormValue>: FormRule {
    public init() {}

    public func validate(value: T) -> Bool {
        return value.isSet
    }
}
