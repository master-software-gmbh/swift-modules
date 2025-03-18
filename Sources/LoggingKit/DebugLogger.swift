import Foundation

public struct DebugLogger: LoggerProtocol, Sendable {
    public init() {}

    public func log(_ message: String) {
        print(message)
    }
}
