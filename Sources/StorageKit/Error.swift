import Foundation

public enum StorageKitError: Error {
    case failedToGenerateKey
    case failedToEncodeValue
    case failedToStoreValue
    case failedToRetrieveValue
    case failedToDecodeValue
    case failedToRemoveValue
}
