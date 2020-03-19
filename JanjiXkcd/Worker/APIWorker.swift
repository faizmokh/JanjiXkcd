import Foundation
import PromiseKit
import Alamofire
import PMKAlamofire

protocol APIWorkable {
    func fetchCurrentComic() -> Promise<Info>
    func fetchComic(number: Int) -> Promise<Info>
}

class APIWorker: APIWorkable {

    let decoder: JSONDecoder

    init() {
        self.decoder = JSONDecoder()
    }

    func fetchCurrentComic() -> Promise<Info> {
        let url = URL(string: "https://xkcd.com/info.0.json")!
        return firstly {
            Alamofire.request(url).responseData()
        }.compactMap {
            return try self.decoder.decode(Info.self, from: $0.data)
        }
    }

    func fetchComic(number: Int) -> Promise<Info> {
        let url = URL(string: "https://xkcd.com/\(number)/info.0.json")!
        return firstly {
            Alamofire.request(url).responseData()
        }.compactMap {
            return try self.decoder.decode(Info.self, from: $0.data)
        }
    }
}
