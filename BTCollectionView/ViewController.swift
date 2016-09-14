//
//  ViewController.swift
//  BTCollectionView
//
//  Created by Chung on 9/13/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var myCollectionView: UICollectionView!
    var infoVC: InfoViewController!
    
    var datas: [Car] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        var myDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("items", ofType: "plist"){
            myDict = NSDictionary(contentsOfFile: path)
        }
        for dic in myDict!.allValues {
             datas.append(Car(name: dic["name"] as! String, content: dic["content"] as! String, images: dic["images"] as! NSArray as! [String]))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = myCollectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CellItem
        cell.addSubViews()
        let item: Car = datas[indexPath.row]
        cell.imageView.image = UIImage(named: "\(item.images[2]).jpg")
        cell.nameLabel.text = item.name
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if infoVC == nil {
            infoVC = self.storyboard?.instantiateViewControllerWithIdentifier("Info") as! InfoViewController
        }
        let item: Car = datas[indexPath.row]
        infoVC.item = item
        self.navigationController?.pushViewController(infoVC, animated: true)
        
    }
    
    


}

