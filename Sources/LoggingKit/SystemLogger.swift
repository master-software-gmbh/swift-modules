import OSLog

public struct SystemLogger: LoggerProtocol, Sendable {
    private let logger = Logger()

    public init() {}

    public func log(_ message: String) {
        logger.info("\(message)")
    }
}
