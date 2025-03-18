import Foundation

public struct ExactLength: FormRule {
    let length: Int

    public init(_ length: Int) {
        self.length = length
    }

    public func validate(value: String) -> Bool {
        return value.count == length
    }
}
