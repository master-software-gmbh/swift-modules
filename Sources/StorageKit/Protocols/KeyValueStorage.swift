import Foundation

public protocol KeyValueStorage: Sendable {
    /// Stores the given value at the given key. If a value with the same key already exists, it is overwritten
    func store(value: String, key: String) throws (StorageKitError)

    /// Retrieves the value at the given key.
    func retrieve(key: String) throws (StorageKitError) -> String?

    /// Remove the value at the given key.
    func remove(key: String) throws (StorageKitError)
}
