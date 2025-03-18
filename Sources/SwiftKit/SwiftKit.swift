import Foundation

public struct AnyAsyncSequence<Element>: AsyncSequence {
    public typealias AsyncIterator = AnyAsyncIterator<Element>
    public typealias Element = Element

    let _makeAsyncIterator: () -> AnyAsyncIterator<Element>

    public struct AnyAsyncIterator<IteratorElement>: AsyncIteratorProtocol {
        public typealias Element = IteratorElement

        private let _next: () async throws -> IteratorElement?

        init<I: AsyncIteratorProtocol>(itr: I) where I.Element == IteratorElement {
            var itr = itr
            self._next = {
                try await itr.next()
            }
        }

        public mutating func next() async throws -> Element? {
            return try await _next()
        }
    }


    init<S: AsyncSequence>(seq: S) where S.Element == Element {
        _makeAsyncIterator = {
            AnyAsyncIterator(itr: seq.makeAsyncIterator())
        }
    }

    public func makeAsyncIterator() -> AnyAsyncIterator<Element> {
        return _makeAsyncIterator()
    }

}

public extension AsyncSequence {
    func eraseToAnyAsyncSequence() -> AnyAsyncSequence<Element> {
        AnyAsyncSequence(seq: self)
    }
}
