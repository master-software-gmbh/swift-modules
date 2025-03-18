import Foundation

public struct MaxLength: FormRule {
    let maxLength: Int

    public init(_ maxLength: Int) {
        self.maxLength = maxLength
    }

    public func validate(value: String) -> Bool {
        return value.count <= maxLength
    }
}
