import Foundation

class AppStore {
    private let config: Config
    private var buffers: [String: [String]] = [:]
    private var observables: [(String, [String]) -> Void] = []

    init(config: inout Config) {
        self.config = config
    }

    func subscribe(onNext: @escaping (String, [String]) -> Void) {
        buffers.forEach { key, value in onNext(key, value) }
        self.observables.append(onNext)
    }

    func push(name: String, data: [String]) {
        if buffers[name] != nil {
            buffers[name]? += data
        } else {
            buffers[name] = data
        }
        self.observables.forEach { f in
            f(name, data)
        }
    }
}
