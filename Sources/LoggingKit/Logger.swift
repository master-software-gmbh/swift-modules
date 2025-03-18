import Foundation

public protocol LoggerProtocol: Sendable {
    func log(_ message: String)
}
