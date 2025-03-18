import Foundation

public struct MinLength: FormRule {
    let minLength: Int

    public init(_ minLength: Int) {
        self.minLength = minLength
    }

    public func validate(value: String) -> Bool {
        return value.count >= minLength
    }
}
