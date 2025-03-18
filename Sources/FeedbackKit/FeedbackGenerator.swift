import Foundation
import UIKit

@MainActor
public struct FeedbackGenerator: Sendable {
    private let generator = UINotificationFeedbackGenerator()
    private let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    private let mediumGenerator = UIImpactFeedbackGenerator(style: .medium)
    private let heavyGenerator = UIImpactFeedbackGenerator(style: .heavy)

    public static let shared = FeedbackGenerator()

    public init() {}

    public func light() {
        lightGenerator.impactOccurred()
    }

    public func medium() {
        mediumGenerator.impactOccurred()
    }

    public func heavy() {
        heavyGenerator.impactOccurred()
    }

    public func success() {
        generator.notificationOccurred(.success)
    }

    public func warning() {
        generator.notificationOccurred(.warning)
    }

    public func error() {
        generator.notificationOccurred(.error)
    }
}
