//
//  DocumentPhoto.swift
//  iCloud
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit

class DocumentPhoto: UIDocument {
    var image : UIImage!
    
    override func loadFromContents(contents: AnyObject, ofType typeName: String?) throws {
        
        let data = NSData(bytes: contents.bytes, length: contents.length)
        self.image = UIImage(data: data)
    }
    
    override func contentsForType(typeName: String) throws -> AnyObject {
        let outError: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        
        if let value = UIImageJPEGRepresentation(self.image, 1.0) {
            return value
        }
        throw outError
    }
    
}
