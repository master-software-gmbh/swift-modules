import Foundation

public struct TelephoneNumber: FormRule {
    let validator: TelephoneNumberValidator

    public init(_ validator: TelephoneNumberValidator) {
        self.validator = validator
    }

    public func validate(value: String) -> Bool {
        return validator.isValidTelephoneNumber(value: value)
    }
}
