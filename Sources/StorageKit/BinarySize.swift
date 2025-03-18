import Foundation

public enum BinarySize: Sendable {
    case bytes(Int)
    case kilobytes(Int)
    case megabytes(Int)
    case gigabytes(Int)

    public var bytes: Int {
        switch self {
        case .bytes(let amount):
            return amount
        case .kilobytes(let amount):
            return amount * 1024
        case .megabytes(let amount):
            return amount * 1024 * 1024
        case .gigabytes(let amount):
            return amount * 1024 * 1024 * 1024
        }
    }
}
