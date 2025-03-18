import Foundation

public struct KeychainStorage: KeyValueStorage, Sendable {
    public static let shared = KeychainStorage()

    public func store(value: String, key: String) throws (StorageKitError) {
        guard let data = value.data(using: .utf8) else {
            throw StorageKitError.failedToEncodeValue
        }

        var query = getQueryDictionary(forKey: key)

        query[SecValueData] = data

        let addStatus = SecItemAdd(query as CFDictionary, nil)

        if addStatus == errSecSuccess {
            return
        } else if addStatus == errSecDuplicateItem {
            // Update existing value if item already exists
            let updateStatus = SecItemUpdate(query as CFDictionary, [SecValueData: data] as CFDictionary)

            if updateStatus == errSecSuccess {
                return
            }
        }

        throw StorageKitError.failedToStoreValue
    }

    public func retrieve(key: String) throws (StorageKitError) -> String? {
        var query = getQueryDictionary(forKey: key)

        query[SecMatchLimit] = kSecMatchLimitOne
        query[SecReturnData] = kCFBooleanTrue

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess else {
            throw StorageKitError.failedToRetrieveValue
        }

        guard let data = result as? Data else {
            return nil
        }

        guard let value = String(data: data, encoding: String.Encoding.utf8) else {
            throw StorageKitError.failedToDecodeValue
        }

        return value
    }

    public func remove(key: String) throws (StorageKitError) {
        let query = getQueryDictionary(forKey: key)
        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess else {
            throw StorageKitError.failedToRemoveValue
        }
    }

    private let SecClass = kSecClass as String
    private let SecAttrService = kSecAttrService as String
    private let SecAttrAccount = kSecAttrAccount as String
    private let SecValueData = kSecValueData as String
    private let SecMatchLimit = kSecMatchLimit as String
    private let SecReturnData = kSecReturnData as String

    private var serviceName: String {
        Bundle.main.bundleIdentifier ?? "StorageKit.KeychainStorage"
    }

    private func getQueryDictionary(forKey key: String) -> [String: Any] {
        let encodedKey: Data? = key.data(using: .utf8)

        return [
            SecClass: kSecClassGenericPassword,
            SecAttrAccount: encodedKey!,
            SecAttrService: serviceName
        ]
    }
}
