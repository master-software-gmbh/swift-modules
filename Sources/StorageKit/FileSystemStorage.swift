import Foundation
import SwiftKit

public struct FileSystemStorage: FileStorage, Sendable {
    public static let shared = FileSystemStorage()

    public init() {}

    public func exists(at location: FileLocation) throws (StorageKitError) -> Bool {
        let targetURL = try location.toURL()

        return FileManager.default.fileExists(atPath: targetURL.path)
    }

    public func store(data: Data, at location: FileLocation) throws (StorageKitError) -> URL {
        let targetURL = try location.toURL()

        do {
            try data.write(to: try location.toURL())
        } catch {
            throw StorageKitError.failedToStoreValue
        }

        return targetURL
    }

    public func store(from url: URL, at location: FileLocation) throws (StorageKitError) -> URL {
        let targetURL = try location.toURL()

        do {
            try FileManager.default.copyItem(at: url, to: targetURL)
        } catch {
            throw StorageKitError.failedToStoreValue
        }

        return targetURL
    }

    public func store(stream: AnyAsyncSequence<ArraySlice<UInt8>>, at location: FileLocation) async throws -> URL {
        let targetURL = try location.toURL()

        do {
            if !FileManager.default.fileExists(atPath: targetURL.path) {
                FileManager.default.createFile(atPath: targetURL.path, contents: nil, attributes: nil)
            }

            let fileHandle = try FileHandle(forWritingTo: targetURL)

            defer {
                do {
                    try fileHandle.close()
                } catch {
                    print("Failed to close file handle: \(error)")
                }
            }

            for try await chunk in stream {
                try fileHandle.write(contentsOf: chunk)
            }

            return targetURL
        } catch {
            throw StorageKitError.failedToStoreValue
        }
    }

    public func retrieve(from url: URL) throws (StorageKitError) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            throw StorageKitError.failedToRetrieveValue
        }
    }

    public func retrieveChunks(of size: BinarySize, from url: URL) -> AsyncThrowingStream<Data, Error> {
        return AsyncThrowingStream { continuation in
            do {
                let fileHandle = try FileHandle(forReadingFrom: url)

                continuation.onTermination = { @Sendable _ in
                    try? fileHandle.close()
                }

                while let chunk = try fileHandle.read(upToCount: size.bytes), !chunk.isEmpty {
                    continuation.yield(chunk)
                }

                try fileHandle.close()

                continuation.finish()
            } catch {
                continuation.finish(throwing: error)
            }
        }
    }

    public func remove(at url: URL) throws (StorageKitError) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            throw StorageKitError.failedToRemoveValue
        }
    }

    public func list(in folder: String) throws (StorageKitError) -> [URL] {
        let targetFolder = try FileLocation.getFolderURL(folder)

        do {
            return try FileManager.default.contentsOfDirectory(
                at: targetFolder,
                includingPropertiesForKeys: [.creationDateKey]
            )
        } catch {
            throw StorageKitError.failedToRetrieveValue
        }
    }
}
