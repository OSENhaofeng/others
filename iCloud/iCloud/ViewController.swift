//
//  ViewController.swift
//  iCloud
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit
import CloudKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var celdas: NSMutableArray = NSMutableArray()
    var container = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)
    var metadataQuery : NSMetadataQuery!
    
    @IBOutlet weak var collectionView: UICollectionView!
  
    @IBAction func deletePhotos(sender: UIBarButtonItem) {
        
        removeImagesFromICloud()
    }
    
    @IBAction func choosePhotos(sender: UIBarButtonItem) {
        let action = UIAlertController (title: "Photos", message: "Select source", preferredStyle: UIAlertControllerStyle.ActionSheet)
        action.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            print("Choose camera")
            self.getPhoto(true)
        }))
        action.addAction(UIAlertAction(title: "Galery", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            print("Choose galery")
            self.getPhoto(false)
        }))
        self.presentViewController(action, animated: true, completion: nil)
    }
    
    func getPhoto (camera: Bool){
        let picker = UIImagePickerController()
        picker.delegate = self
        if (camera){
            picker.sourceType = UIImagePickerControllerSourceType.Camera
        }else{
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            print("Choose from galery 2")
        }
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let fullImage = (info as NSDictionary)[UIImagePickerControllerOriginalImage] as! UIImage
        print("Choose from galery 3")
        savePhotoICloud(fullImage)
    }

    func savePhotoICloud (image: UIImage){
        let date = NSDate()
        let df = NSDateFormatter()
        df.dateFormat = "dd_MM_yy_hh_mm_ss"
        let photoName = NSString (format: "PHOTO_%@", df.stringFromDate(date))
        
        if (container != nil){
            let fileURLiCloud = container!.URLByAppendingPathComponent("Documents").URLByAppendingPathComponent(photoName as String)
            let photo = DocumentPhoto (fileURL: fileURLiCloud)
            photo.image = image
            photo.saveToURL(fileURLiCloud, forSaveOperation: UIDocumentSaveOperation.ForCreating, completionHandler: { (success) -> Void
                in
                self.celdas.addObject(image)
                print("Choose from galery 4")
                self.collectionView.reloadData()
            })
        }
    }
    
    func removeImagesFromICloud (){
        if (container != nil){
            self.metadataQuery = NSMetadataQuery()
            self.metadataQuery.searchScopes = NSArray (object: NSMetadataQueryUbiquitousDocumentsScope) as [AnyObject]
            
            let predicate = NSPredicate(format: "%K like 'PHOTO*'", NSMetadataItemFSNameKey)
            self.metadataQuery.predicate = predicate
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryDeleted:", name: NSMetadataQueryDidFinishGatheringNotification,
                object: self.metadataQuery)
            
            self.metadataQuery.startQuery()
        }
    }
    
    func loadImagesFromICloud (){
        if (container != nil){
            self.metadataQuery = NSMetadataQuery()
            self.metadataQuery.searchScopes = NSArray (object: NSMetadataQueryUbiquitousDocumentsScope) as [AnyObject]
            
            let predicate = NSPredicate(format: "%K like 'PHOTO*'", NSMetadataItemFSNameKey)
            self.metadataQuery.predicate = predicate
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryFinished:", name: NSMetadataQueryDidFinishGatheringNotification, object: self.metadataQuery)
            self.metadataQuery.startQuery()
        }
    }
    
    func queryFinished(notification: NSNotification){
        let mq = notification.object as! NSMetadataQuery
        mq.disableUpdates()
        mq.stopQuery()
        celdas.removeAllObjects()
        for (var i = 0; i<mq.resultCount;i++){
            let result = mq.resultAtIndex(i) as! NSMetadataItem
           // var nombre = result.valueForAttribute(NSMetadataItemFSNameKey) as! NSString
            let url = result.valueForAttribute(NSMetadataItemURLKey) as! NSURL
            let document : DocumentPhoto! = DocumentPhoto(fileURL: url)
            
            document?.openWithCompletionHandler({ (success) -> Void in
                if (success == true){
                    self.celdas.addObject(document.image)
                    print("addobject in queryfinished")
                    self.collectionView.reloadData()
                }
            }) }
    }
    
    func queryDeleted(notification: NSNotification){
        let mq = notification.object as! NSMetadataQuery
        mq.disableUpdates()
        mq.stopQuery()
        celdas.removeAllObjects()
        for (var i = 0; i<mq.resultCount;i++){
            let result = mq.resultAtIndex(i) as! NSMetadataItem
            let url = result.valueForAttribute(NSMetadataItemURLKey) as! NSURL
            let document : DocumentPhoto! = DocumentPhoto(fileURL: url)
            
            let fileManager = NSFileManager()
            do {
                try fileManager.removeItemAtURL(document.fileURL)
            } catch _ {
            }
            
            self.collectionView.reloadData()
            
            document?.openWithCompletionHandler({ (success) -> Void in
                if (success == true){
                    self.collectionView.reloadData()
                }
            }) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImagesFromICloud ()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier:NSString = "CollectionCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier as String, forIndexPath: indexPath) 
        let imageView:UIImageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = celdas.objectAtIndex(indexPath.row) as? UIImage
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return celdas.count
    }
    
}
