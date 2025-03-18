import Foundation

public protocol FormValue {
    var isSet: Bool { get }
}

extension String: FormValue {
    public var isSet: Bool {
        !isEmpty
    }
}

extension Date: FormValue {
    public var isSet: Bool {
        true
    }
}

extension Optional: FormValue where Wrapped: FormValue {
    public var isSet: Bool {
        switch self {
        case .none:
            return false
        case .some(let value):
            return value.isSet
        }
    }
}
