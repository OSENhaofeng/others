//
//  ViewController.swift
//  CollectionView
//
//  Created by Carlos Butron on 02/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var items : NSArray = [UIImage(named:"image1.jpg")!,UIImage(named:"image2.jpg")!,UIImage(named:"image3.jpg")!,UIImage(named:"image4.jpg")!,UIImage(named:"image5.jpg")!,UIImage(named:"image6.jpg")!,UIImage(named:"image7.jpg")!,UIImage(named:"image8.jpg")!,UIImage(named:"image9.jpg")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String = "CollectionCell"
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) 
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = items.object(at: (indexPath as NSIndexPath).row%9) as? UIImage
        return cell
    }

}
