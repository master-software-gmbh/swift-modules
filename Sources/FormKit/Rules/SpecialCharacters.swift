import Foundation

public struct SpecialCharacters: FormRule {
    private let regex: RegexMatch

    public init(_ minCount: Int = 1) {
        regex = RegexMatch(pattern: "[\\^°!\"§$%&/()=?´`*+#'\\-_.:,;@<>\\[\\]{}|~\\\\]", minMatches: minCount)
    }

    public func validate(value: String) -> Bool {
        return regex.validate(value: value)
    }
}
