import Foundation

public struct FileLocation {
    let fileName: String
    let folderName: String
    let fileExtension: String?

    public init(fileName: String? = nil, folderName: String, fileExtension: String? = nil) {
        self.fileName = fileName ?? UUID().uuidString
        self.folderName = folderName
        self.fileExtension = fileExtension
    }

    public func toURL() throws (StorageKitError) -> URL {
        let base = try FileLocation.getFolderURL(folderName).appending(path: fileName)

        if let fileExtension {
            return base.deletingPathExtension().appendingPathExtension(fileExtension)
        }

        return base
    }

    static func getFolderURL(_ folder: String) throws (StorageKitError) -> URL {
        let targetFolder = URL.documentsDirectory.appending(path: folder)

        do {
            try FileManager.default.createDirectory(
                at: targetFolder,
                withIntermediateDirectories: true,
                attributes: nil
            )
        } catch {
            throw StorageKitError.failedToGenerateKey
        }

        return targetFolder
    }
}
