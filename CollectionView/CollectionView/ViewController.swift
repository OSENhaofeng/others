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
        
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count * 5
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier: String = "CollectionCell"
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) 
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = items.objectAtIndex(indexPath.row%9) as? UIImage
        return cell
    }
    
    



}

