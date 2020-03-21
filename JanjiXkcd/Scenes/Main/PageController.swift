import UIKit
import PromiseKit
import Kingfisher

class PageController: UIViewController {

    // MARK: - Outlets

    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.accessibilityTraits = .image
            imageView.contentMode = .scaleAspectFit
        }
    }

    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.accessibilityTraits = .header
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
        }
    }

    @IBOutlet var altTextLabel: UILabel! {
        didSet {
            altTextLabel.accessibilityTraits = .summaryElement
            altTextLabel.numberOfLines = 0
            altTextLabel.textAlignment = .center
        }
    }

    let spinner = SpinnerViewController()

    // MARK: - Properties

    let worker: APIWorkable
    let comicNumber: Int

    // MARK: - Inits

    init(comicNumber: Int, worker: APIWorkable = APIWorker()) {
        self.worker = worker
        self.comicNumber = comicNumber
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComic(at: comicNumber)
    }

    // MARK: - Methods

    func fetchComic(at: Int) {
        add(spinner)
        worker
        .fetchComic(number: comicNumber)
        .done(on: .main) { info in
            self.spinner.remove()
            self.setupUI(with: info)
        }.catch { error in
            print(error)
        }
    }

    func setupUI(with info: Info) {
        let url = URL(string: info.image)
        self.imageView.kf.setImage(with: url)
        self.imageView.accessibilityLabel = info.transcript
        self.titleLabel.text = info.title.uppercased()
        self.titleLabel.accessibilityLabel = info.title
        self.altTextLabel.text = info.alternativeText
        self.altTextLabel.accessibilityLabel = info.alternativeText
    }
}
