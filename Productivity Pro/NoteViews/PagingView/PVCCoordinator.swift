//
//  PVCCoordinator.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.04.24.
//

import SwiftUI

extension PagingViewController {
    typealias UIPCDS = UIPageViewControllerDataSource
    typealias UIPVCD = UIPageViewControllerDelegate

    class Coordinator: NSObject, UIPCDS, UIPVCD {
        var parent: PagingViewController
        var controllers = [UIViewController]()

        init(_ pageViewController: PagingViewController) {
            parent = pageViewController
            controllers = parent.pages.map {
                let controller = UIHostingController(rootView: $0)
                controller.view.backgroundColor = .clear

                return controller
            }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return nil
            }

            return controllers[index - 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }

            if index + 1 == controllers.count {
                return nil
            }

            return controllers[index + 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool
        ) {
            if let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController)
            {
                parent.currentPage = index
            }
        }
    }
}
