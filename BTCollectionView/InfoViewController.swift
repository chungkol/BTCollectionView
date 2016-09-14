//
//  InfoViewController.swift
//  BTCollectionView
//
//  Created by Chung on 9/14/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var item: Car!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView?.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lbName?.text = item.name
        imageView?.image = UIImage(named: "\(item.images[0]).jpg")
        lbContent?.text = item.content!
        imageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.tapImg))
        imageView.addGestureRecognizer(tap)
    }
    func tapImg(){
        pushView(0)
    }
    func pushView(index: Int){
        let listView = self.storyboard?.instantiateViewControllerWithIdentifier("listView") as! ListViewController
        listView.currentPage = index
        listView.pageImages = item.images
        self.navigationController?.pushViewController(listView, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        pushView(indexPath.row)
        
    }
    
    

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.images.count - 1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        if indexPath.row < item.images.count {
            cell.imageCell.image = UIImage(named: "\(item.images[indexPath.row + 1]).jpg")

        }
        return cell
        
        
    }
    
    
    
    
    
}
