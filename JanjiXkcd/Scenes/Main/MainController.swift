import UIKit
import PromiseKit
import Kingfisher

class MainController: UIViewController {

    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    let worker: APIWorkable

    init(worker: APIWorkable = APIWorker()) {
        self.worker = worker
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        worker
        .fetchCurrentComic()
        .done(on: .main) { info in
                print(info)
            let url = URL(string: info.image)
            self.imageView.kf.setImage(with: url)
        }.catch { error in
            print(error)
        }
    }
}
