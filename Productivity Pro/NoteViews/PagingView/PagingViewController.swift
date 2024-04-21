//
//  PageViewController.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.03.24.
//

import SwiftUI

struct PagingViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: [
                UIPageViewController.OptionsKey.interPageSpacing: 20
            ])

        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return pageViewController
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
