import UIKit

class PagesController: UIPageViewController {

    // MARK: - Properties

    let worker: APIWorkable

    var current: Int
    var info: Info?

    // MARK: - Inits

    init(worker: APIWorkable = APIWorker()) {
        self.worker = worker
        self.current = 0
        super.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        fetchLatestComic()
    }

    // MARK: - Methods

    func fetchLatestComic() {
        worker
        .fetchCurrentComic()
        .done(on: .main) { info in
            self.current = info.num
            self.info = info
            let controller = PageController(comicNumber: info.num)
            self.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
        }.catch { error in
            print(error)
        }
    }
}

// MARK: - PageViewController Data Source

extension PagesController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let info = info, current < info.num else { return nil }
        current += 1

        return PageController(comicNumber: current)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        current -= 1
        return PageController(comicNumber: current)
    }
}
