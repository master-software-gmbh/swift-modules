import Foundation

public protocol FormRule<Value> {
    associatedtype Value
    func validate(value: Value) -> Bool
}
