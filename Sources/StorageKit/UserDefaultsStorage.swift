import Foundation

public struct UserDefaultsStorage: KeyValueStorage, Sendable {
    public static let shared = UserDefaultsStorage()

    public func store(value: String, key: String) throws (StorageKitError) {
        UserDefaults.standard.set(value, forKey: key)
    }

    public func retrieve(key: String) throws (StorageKitError) -> String? {
        UserDefaults.standard.string(forKey: key)
    }

    public func remove(key: String) throws (StorageKitError) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
