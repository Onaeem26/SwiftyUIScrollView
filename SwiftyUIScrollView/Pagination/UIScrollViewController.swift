//
//  UIScrollViewController.swift
//  Pagination
//
//  Created by Osama Naeem on 14/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI
import UIKit

enum DirectionX {
    case horizontal
    case vertical
}


struct SwiftyUIScrollView<Content: View>: UIViewControllerRepresentable {
    var content: () -> Content
    var axis: DirectionX
    var numberOfPages = 0
    var pagingEnabled: Bool = false
    var pageControlEnabled: Bool = false
    var hideScrollIndicators: Bool = false

    init(axis: DirectionX, numberOfPages: Int, pagingEnabled: Bool, pageControlEnabled: Bool, hideScrollIndicators: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.numberOfPages = numberOfPages
        self.pagingEnabled = pagingEnabled
        self.pageControlEnabled = pageControlEnabled
        self.hideScrollIndicators = hideScrollIndicators
        self.axis = axis
    }

    func makeUIViewController(context: Context) -> UIScrollViewController {
        let vc = UIScrollViewController()
        vc.axis = axis
        vc.numberOfPages = numberOfPages
        vc.pagingEnabled = pagingEnabled
        vc.pageControlEnabled = pageControlEnabled
        vc.hideScrollIndicators = hideScrollIndicators
        vc.hostingController.rootView = AnyView(self.content())
        return vc
    }

    func updateUIViewController(_ viewController: UIScrollViewController, context: Context) {
        viewController.hostingController.rootView = AnyView(self.content())
    }
}

class UIScrollViewController: UIViewController, UIScrollViewDelegate {
    
    var axis: DirectionX = .horizontal
    var numberOfPages: Int = 0
    var pagingEnabled: Bool = false
    var pageControlEnabled: Bool = false
    var hideScrollIndicators: Bool = false
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.isPagingEnabled = pagingEnabled
        view.showsVerticalScrollIndicator = !hideScrollIndicators
        view.showsHorizontalScrollIndicator = !hideScrollIndicators
        return view
    }()
    
    lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
            pageControl.numberOfPages = numberOfPages
            pageControl.currentPage = 0
            pageControl.tintColor = UIColor.white
            pageControl.pageIndicatorTintColor = UIColor.gray
            pageControl.currentPageIndicatorTintColor = UIColor.white
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.isHidden = !pageControlEnabled
        return pageControl
    }()

    
    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        self.makefullScreen(of: self.scrollView, to: self.view)

        self.hostingController.willMove(toParent: self)
        self.scrollView.addSubview(self.hostingController.view)
        self.makefullScreen(of: self.hostingController.view, to: self.scrollView)
        self.hostingController.didMove(toParent: self)
        
        view.addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
       
    }
    
    func makefullScreen(of viewA: UIView, to viewB: UIView) {
          viewA.translatesAutoresizingMaskIntoConstraints = false
          viewB.addConstraints([
              viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
              viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
              viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
              viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
          ])
      }
    
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
            let currentIndexHorizontal = round(scrollView.contentOffset.x / self.view.frame.size.width)
            let currentIndexVertical = round(scrollView.contentOffset.y / self.view.frame.size.height)
        
        switch axis {
        case .horizontal:
             self.pageControl.currentPage = Int(currentIndexHorizontal)
            break
        case .vertical:
            self.pageControl.currentPage = Int(currentIndexVertical)
            break
        default:
            break
        }
           
     }

}


