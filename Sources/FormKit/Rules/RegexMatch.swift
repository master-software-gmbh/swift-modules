import Foundation

struct RegexMatch: FormRule {
    let pattern: String
    let minMatches: Int

    func validate(value: String) -> Bool {
        let regex = try! Regex(pattern)
        return value.matches(of: regex).count >= minMatches
    }
}
