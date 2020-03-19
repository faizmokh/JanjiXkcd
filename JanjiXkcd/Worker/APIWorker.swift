import Foundation
import PromiseKit

protocol APIWorkable {
    func fetchCurrentComic() -> Promise<Info>
    func fetchComic(number: Int) -> Promise<Info>
}

class APIWorker {

}
