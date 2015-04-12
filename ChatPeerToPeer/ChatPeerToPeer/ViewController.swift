//
//  ViewController.swift
//  ChatPeerToPeer
//
//  Created by Carlos Butron on 07/12/14.
//  Copyright (c) 2015 Carlos Butron. All rights reserved.
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
import MultipeerConnectivity

class ViewController: UIViewController,  MCSessionDelegate, MCBrowserViewControllerDelegate,UITextFieldDelegate {
    var browserVC:MCBrowserViewController!
    var advertiserAssistant: MCAdvertiserAssistant!
    var session: MCSession!
    var peerID: MCPeerID!
    
    @IBAction func button(sender: UIButton) {
        showBrowserVC()
    }
    
    
    @IBOutlet weak var textBox: UITextView!
    @IBOutlet weak var sendText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMultipeer()
    }
    
    func setUpMultipeer(){
        peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        session = MCSession(peer: peerID)
        session.delegate = self
        browserVC = MCBrowserViewController(serviceType: "chat", session: session)
        browserVC.delegate = self
        advertiserAssistant = MCAdvertiserAssistant(serviceType: "chat", discoveryInfo: nil, session: session)
        advertiserAssistant.start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendMessage(){
        var message:NSString = self.sendText.text
        self.sendText.text = ""
        var data :NSData = message.dataUsingEncoding(NSUTF8StringEncoding)!
        var error:NSError?
        self.session.sendData(data, toPeers:
            self.session.connectedPeers, withMode: MCSessionSendDataMode.Unreliable, error: &error)
        self.messageReception(message, peer: self.peerID)
    }
    
    func messageReception(message:NSString, peer:MCPeerID){
        var finalText:NSString
        if(peer == self.peerID){
            finalText = "\nYo: \(message)"
        }
        else{
            finalText = "\n\(peer.displayName): \(message)"
        }
        self.textBox.text =
            self.textBox.text.stringByAppendingString(finalText)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        textField.resignFirstResponder()
        self.sendMessage()
        return true
    }
    
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState){
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!){
        var message = NSString(data: data, encoding:
            NSUTF8StringEncoding)
        dispatch_async(dispatch_get_main_queue(),
            {self.messageReception(message!, peer: peerID)})
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID:MCPeerID!){
    }
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!){
    }
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!){
    }
    
    func browserViewControllerDidFinish(browserViewController:
        MCBrowserViewController!){
            self.dismissBrowserVC()
    }
    // Notifies delegate that the user taps the cancel button.
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!){
        self.dismissBrowserVC()
    }
    func showBrowserVC(){
        self.presentViewController(self.browserVC, animated: true,
            completion: nil)
    }
    func dismissBrowserVC(){
        self.browserVC.dismissViewControllerAnimated(true, completion:
            nil) }
    
    
}

