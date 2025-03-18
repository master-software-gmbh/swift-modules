import Foundation

public struct Letters: FormRule {
    private let regex: RegexMatch

    public init(_ minCount: Int = 1) {
        regex = RegexMatch(pattern: "[A-Za-z]", minMatches: minCount)
    }

    public func validate(value: String) -> Bool {
        return regex.validate(value: value)
    }
}
