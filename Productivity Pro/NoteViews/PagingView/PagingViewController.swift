//
//  PageViewController.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.03.24.
//

import SwiftUI

struct PagingViewController<Page: View>: UIViewControllerRepresentable {
    var isHorizontal: Bool
    var pages: [Page]

    @Binding var currentPage: Int

    func makeUIViewController(context: Context) -> UIPageViewController {
        let spacing = isHorizontal ? 20 : 0
        
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: isHorizontal ? .horizontal : .vertical,
            options: [
                UIPageViewController.OptionsKey.interPageSpacing: spacing
            ])

        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return pageViewController
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
