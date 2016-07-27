//
//  ViewController.swift
//  Shop2
//
//  Created by HuuLuong on 7/25/16.
//  Copyright © 2016 CanhDang. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photos: [UIImageView] = []
    var pageImages: [String] = []
    var frontScrollViews: [UIScrollView] = []
    var first = false
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageImages = ["shop1-1", "shop1-2", "shop1-3", "shop1-4", "shop1-5"]
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageImages.count
        
//        scrollView.minimumZoomScale = 0.5
//        scrollView.maximumZoomScale = 2
        
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        if (!first) {
            first = true
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), 0)
            scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollView.frame.size.width, 0)
            for i in 0..<pageImages.count {
                let imgView = UIImageView(image: UIImage(named: pageImages[i] + ".jpg"))
                imgView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
                imgView.contentMode = .ScaleAspectFit
                imgView.userInteractionEnabled = true
                imgView.multipleTouchEnabled = true
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapImg))
                doubleTap.numberOfTapsRequired = 2
                tap.requireGestureRecognizerToFail(doubleTap)
                imgView.addGestureRecognizer(doubleTap)
                
                
                photos.append(imgView)
                
                let frontScrollView = UIScrollView(frame: CGRectMake(CGFloat(i) * scrollView.frame.size.width, 0, scrollView.frame.size.width,scrollView.frame.size.height))
                
                frontScrollView.minimumZoomScale = 1
                frontScrollView.maximumZoomScale = 3
                frontScrollView.delegate = self
                frontScrollView.contentSize = imgView.bounds.size
                frontScrollView.addSubview(imgView)
                frontScrollViews.append(frontScrollView)
                self.scrollView.addSubview(frontScrollView)
            }
        }
        
      
        
    }
    
    @IBAction func onChange(sender: AnyObject) {
        scrollView.contentOffset = CGPointMake(CGFloat(pageController.currentPage) * scrollView.frame.size.width, 0)
       //print(scrollView.contentOffset)
        
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

    }
    func scrollViewDidScroll(scrollView: UIScrollView) {

         let width = scrollView.frame.width
         let page = Int(floor((self.scrollView.contentOffset.x)/(width)))
//
//        if (page != pageController.currentPage)
//        {
           pageController.currentPage = page
//        }
        
//       print(self.scrollView.contentOffset)
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return photos[pageController.currentPage]
    }
    
    func tapImg(gesture: UITapGestureRecognizer) {
        let position = gesture.locationInView(photos[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 1.5, center: position)
    }
    
    func doubleTapImg(gesture: UITapGestureRecognizer) {
        let position = gesture.locationInView(photos[pageController.currentPage])
        zoomRectForScale(frontScrollViews[pageController.currentPage].zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) {
        
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        
        frontScrollViews[pageController.currentPage].zoomToRect(zoomRect, animated: true)
    }
    
    @IBAction func action_PreviousPage(sender: AnyObject) {
        currentPage = pageController.currentPage
        if currentPage > 0 {
            currentPage -= 1
        } else {
            currentPage = pageImages.count - 1
        }
        pageController.currentPage = currentPage
        scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollView.frame.size.width, 0)
    }
    
    @IBAction func action_nextPage(sender: AnyObject) {
        currentPage = pageController.currentPage
        if currentPage < pageImages.count - 1 {
            currentPage += 1
        } else {
            currentPage = 0
        }
        pageController.currentPage = currentPage
        scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollView.frame.size.width, 0)
    }
    
}

