import Foundation

public protocol TelephoneNumberValidator {
    func isValidTelephoneNumber(value: String) -> Bool
}
