import XCTest
@testable import FormKit

final class FormRuleTests: XCTestCase {
    // MARK: - validateDigits Tests
    func testValidateDigits_withSufficientDigits() {
        let formRule = Digits(2)
        let result = formRule.validate(value: "a1b2c")
        XCTAssertTrue(result, "Expected validateDigits to return true when the input contains at least 2 digits.")
    }

    func testValidateDigits_withAdjacentDigits() {
        let formRule = Digits(3)
        let result = formRule.validate(value: "a123c")
        XCTAssertTrue(result, "Expected validateDigits to return false when the input contains fewer than 3 digits.")
    }

    func testValidateDigits_withInsufficientDigits() {
        let formRule = Digits(3)
        let result = formRule.validate(value: "a1b2c")
        XCTAssertFalse(result, "Expected validateDigits to return false when the input contains fewer than 3 digits.")
    }

    func testValidateDigits_withNoDigits() {
        let formRule = Digits(1)
        let result = formRule.validate(value: "abc")
        XCTAssertFalse(result, "Expected validateDigits to return false when the input contains no digits.")
    }

    // MARK: - validateLetters Tests
    func testValidateLetters_withSufficientLetters() {
        let formRule = Letters(3)
        let result = formRule.validate(value: "a1b2C")
        XCTAssertTrue(result, "Expected validateLetters to return true when the input contains at least 3 letters.")
    }

    func testValidateLetters_withInsufficientLetters() {
        let formRule = Letters(4)
        let result = formRule.validate(value: "a1b2C")
        XCTAssertFalse(result, "Expected validateLetters to return false when the input contains fewer than 4 letters.")
    }

    func testValidateLetters_withNoLetters() {
        let formRule = Letters(1)
        let result = formRule.validate(value: "12345")
        XCTAssertFalse(result, "Expected validateLetters to return false when the input contains no letters.")
    }

    func testValidateLetters_withMixedCharacters() {
        let formRule = Letters(2)
        let result = formRule.validate(value: "!@#A1b2")
        XCTAssertTrue(result, "Expected validateLetters to return true when the input contains at least 2 letters in mixed characters.")
    }

    // MARK: - validateSpecialCharacters Tests
    func testValidateSpecialCharacters_withSufficientSpecialCharacters() {
        let formRule = SpecialCharacters(2)
        let result = formRule.validate(value: "a!b@c")
        XCTAssertTrue(result, "Expected validateSpecialCharacters to return true when the input contains at least 2 special characters.")
    }

    func testValidateSpecialCharacters_withInsufficientSpecialCharacters() {
        let formRule = SpecialCharacters(3)
        let result = formRule.validate(value: "a!b@c")
        XCTAssertFalse(result, "Expected validateSpecialCharacters to return false when the input contains fewer than 3 special characters.")
    }

    func testValidateSpecialCharacters_withNoSpecialCharacters() {
        let formRule = SpecialCharacters(1)
        let result = formRule.validate(value: "abc123")
        XCTAssertFalse(result, "Expected validateSpecialCharacters to return false when the input contains no special characters.")
    }

    func testValidateSpecialCharacters_withMixedCharacters() {
        let formRule = SpecialCharacters(3)
        let result = formRule.validate(value: "a!@#1b")
        XCTAssertTrue(result, "Expected validateSpecialCharacters to return true when the input contains at least 3 special characters in mixed characters.")
    }
}
