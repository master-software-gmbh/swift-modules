import Foundation

public protocol FormField {
    associatedtype T
    var value: T { get set }
    var isTouched: Bool { get }
    var isValid: Bool { get }
    var error: LocalizedStringResource? { get }

    mutating func touch()
    mutating func reset()
}

public extension Array where Element == any FormField {
    var isValid: Bool {
        allSatisfy { $0.isValid }
    }
}
