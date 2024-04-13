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
            ], direction: .forward, animated: false)
        }
    }
}
