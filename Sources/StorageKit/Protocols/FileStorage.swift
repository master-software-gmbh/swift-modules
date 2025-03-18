import Foundation
import SwiftKit

public protocol FileStorage: Sendable {
    /// Checks if a file at the `location` exists.
    func exists(at location: FileLocation) throws (StorageKitError) -> Bool

    /// Stores the `data` as a file at the `location`.
    @discardableResult
    func store(data: Data, at location: FileLocation) throws (StorageKitError) -> URL

    /// Retrieves data from the `url` and stores it as a file at the `location`.
    @discardableResult
    func store(from url: URL, at location: FileLocation) throws (
        StorageKitError
    ) -> URL

    /// Retrieves data from the `stream` and stores it as a file at the `location`.
    @discardableResult
    func store(stream: AnyAsyncSequence<ArraySlice<UInt8>>, at location: FileLocation) async throws -> URL

    /// Retrieves the file with the `url`.
    func retrieve(from url: URL) throws (StorageKitError) -> Data?

    /// Retrieves the file with the `url` as a stream of chunks
    func retrieveChunks(of size: BinarySize, from url: URL) -> AsyncThrowingStream<Data, Error>

    /// Remove the file at the `url`.
    func remove(at url: URL) throws (StorageKitError)

    /// Retrievese the list of files in the `folder`.
    func list(in folder: String) throws (StorageKitError) -> [URL]
}
