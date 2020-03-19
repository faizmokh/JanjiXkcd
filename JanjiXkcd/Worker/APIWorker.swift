import Foundation
import PromiseKit

protocol APIWorkable {
    func fetchCurrentComic() -> Promise<Info>
    func fetchComic(number: Int) -> Promise<Info>
}

class APIWorker: APIWorkable {
    func fetchCurrentComic() -> Promise<Info> {
        return Promise { seal in
            seal.reject(NSError())
        }
    }

    func fetchComic(number: Int) -> Promise<Info> {
        return Promise { seal in
            seal.reject(NSError())
        }
    }
}
