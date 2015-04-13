//
//  ImagesOperation.swift
//  XMLAppStore
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2014 Carlos Butron.
//
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
//  License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
//  version.
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//  You should have received a copy of the GNU General Public License along with this program. If not, see
//  http:/www.gnu.org/licenses/.
//

import UIKit
import Foundation


protocol ImagesOperationDelegate{
    func imageOperation(imagesOperation:ImagesOperation, app:AppInfo)
}

class ImagesOperation: NSOperation, NSURLConnectionDelegate {
    
    var delegate: ImagesOperationDelegate?
    var app: AppInfo!
    var currentData:NSMutableData!
    
    override func main(){
        var connection = NSURLConnection(request: NSURLRequest(URL: NSURL(string: app.urlImage)!), delegate: self, startImmediately: false)
        connection!.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        connection!.start()
        self.currentData = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.currentData.appendData(data)
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!){
        self.currentData = nil
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        var image: UIImage? = UIImage(data: self.currentData)
            if(image != nil){
                self.app.image = image
                self.delegate?.imageOperation(self, app: self.app)
            }
    }

}