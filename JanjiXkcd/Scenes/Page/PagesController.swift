import UIKit

class PagesController: UIPageViewController {

    private(set) lazy var controllers: [UIViewController] = {
        return [
            PageController(),
            PageController(),
            PageController()
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        if let first = controllers.first {
            setViewControllers([first],
                               direction: .forward,
                               animated: true, completion: nil)
        }
    }
}

extension PagesController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1

        guard previousIndex >= 0 else {
            return nil
        }

        return controllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1

        let count = controllers.count
        guard count != nextIndex,
            count > nextIndex else {
                return nil
        }

        return controllers[nextIndex]
    }


}
