import Foundation

public struct Digits: FormRule {
    private let regex: RegexMatch

    public init(_ minCount: Int = 1) {
        regex = RegexMatch(pattern: "\\d", minMatches: minCount)
    }

    public func validate(value: String) -> Bool {
        return regex.validate(value: value)
    }
}
