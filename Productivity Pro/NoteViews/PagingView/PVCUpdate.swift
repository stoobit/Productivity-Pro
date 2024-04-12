//
//  PVCUpdate.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.04.24.
//

import SwiftUI

extension PagingViewController {
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        if context.coordinator.controllers.indices.contains(currentPage) {
            pageViewController.setViewControllers([
                context.coordinator.controllers[currentPage]
            ], direction: .forward, animated: true, completion: { _ in
                if context.coordinator.controllers.indices.contains(currentPage + 1) {
                    context.coordinator.controllers[currentPage + 1].loadViewIfNeeded()
                }

                if context.coordinator.controllers.indices.contains(currentPage - 1) {
                    context.coordinator.controllers[currentPage - 1].loadViewIfNeeded()
                }
            })
        }
    }
}
