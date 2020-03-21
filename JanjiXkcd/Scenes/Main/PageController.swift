import UIKit
import PromiseKit
import Kingfisher

class PageController: UIViewController {

    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
        }
    }

    let worker: APIWorkable
    let comicNumber: Int

    init(comicNumber: Int, worker: APIWorkable = APIWorker()) {
        self.worker = worker
        self.comicNumber = comicNumber
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComic(at: comicNumber)
    }

    func fetchComic(at: Int) {
        worker
            .fetchComic(number: comicNumber)
            .done(on: .main) { info in
                print(info)
                let url = URL(string: info.image)
                self.imageView.kf.setImage(with: url)
        }.catch { error in
            print(error)
        }
    }
}
