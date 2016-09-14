//
//  ListViewController.swift
//  BTCollectionView
//
//  Created by Chung on 9/14/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UIScrollViewDelegate {
    
    var photo: [UIImageView] = []
    
    var frontScrollViews: [UIScrollView] = []
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var mPageControl: UIPageControl!
    @IBOutlet weak var mScrollView: UIScrollView!
    
    var first = false
    var currentPage = 0
    var pageImages: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mPageControl.currentPage = currentPage
        mPageControl.numberOfPages = pageImages.count
        mScrollView.minimumZoomScale = 1
        mScrollView.maximumZoomScale = 2
        mScrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (!first) {
            first = true
            let pagesScrollViewSize = mScrollView.frame.size
            
            mScrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), 0)
            mScrollView.contentOffset = CGPointMake(CGFloat(currentPage) * mScrollView.frame.size.width, 0)
            
            for (var i = 0; i < pageImages.count; i++){
                let imgView = UIImageView(image: UIImage(named: pageImages[i]+".jpg"))
                imgView.frame = CGRectMake(0, 0, mScrollView.frame.size.width, mScrollView.frame.size.height)
                imgView.contentMode = .ScaleAspectFill
                
                photo.append(imgView)
                
                imgView.userInteractionEnabled = true
                imgView.multipleTouchEnabled = true
                
                //su kien tap
                let tap = UITapGestureRecognizer(target: self, action: #selector(ListViewController.tapImg(_:)))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ListViewController.doubleTab(_:)))
                doubleTap.numberOfTapsRequired = 2
                tap.requireGestureRecognizerToFail(doubleTap)
                imgView.addGestureRecognizer(doubleTap)
                //
                
                let frontScrollView = UIScrollView(frame: CGRectMake( CGFloat(i) * mScrollView.frame.size.width, 0, mScrollView.frame.size.width, mScrollView.frame.size.height))
                frontScrollView.minimumZoomScale = 1
                frontScrollView.maximumZoomScale = 2
                frontScrollView.delegate = self
                frontScrollView.addSubview(imgView)
                frontScrollViews.append(frontScrollView)
                mScrollView.backgroundColor = UIColor.brownColor()
                self.mScrollView.addSubview(frontScrollView)
                
            }
            
        }
        //
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        print( mPageControl.currentPage)
        return photo[mPageControl.currentPage]
    }
    func tapImg(gesture: UITapGestureRecognizer){
        let position = gesture.locationInView(photo[mPageControl.currentPage])
        zoomRectForScale(frontScrollViews[mPageControl.currentPage].zoomScale * 1.5, center: position)
        
    }
    func doubleTab(gesture: UITapGestureRecognizer){
        let position = gesture.locationInView(photo[mPageControl.currentPage])
        zoomRectForScale(frontScrollViews[mPageControl.currentPage].zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale: CGFloat , center: CGPoint){
        var zoomRect = CGRect()
        let scrollViewSize = mScrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        
        print(zoomRect)
        frontScrollViews[mPageControl.currentPage].zoomToRect(zoomRect, animated: true)
    }
    
    
    @IBAction func pageChange(sender: UIPageControl) {
        print( mPageControl.currentPage)
        mScrollView.contentOffset = CGPointMake(CGFloat(mPageControl.currentPage) * mScrollView.frame.size.width, 0)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        mPageControl.currentPage = Int(pageNumber)
        print(pageNumber)
    }
    
    @IBAction func next(sender: UIButton) {
        var current = mPageControl.currentPage
        if (current < pageImages.count - 1) {
            current = current + 1
            mScrollView.contentOffset = CGPointMake(CGFloat(current) * mScrollView.frame.size.width, 0)
            mPageControl.currentPage = current
        }
        print(current)
    }
    @IBAction func previous(sender: UIButton) {
        var current = mPageControl.currentPage
        if current == 0 {
            btnPre.hidden = true
        }
        if (current > 0) {
            current = current - 1
            mScrollView.contentOffset = CGPointMake(CGFloat(current) * mScrollView.frame.size.width, 0)
            mPageControl.currentPage = current
        }
        print(current)
    }
    
}
