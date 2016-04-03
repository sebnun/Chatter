//
//  ChatWindowController.swift
//  Chatter
//
//  Created by Sebastian on 4/2/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import Cocoa

private let ChatWindowDidSendNotification = "com.landab.chatter.ChatWindowDidSendNotification"
private let ChatWindowControllerMessageKey = "com.landab.chatter.ChatWindowControllerMessageKey"

class ChatWindowController: NSWindowController {

    dynamic var log: NSAttributedString = NSAttributedString(string: "")
    dynamic var message: String?
    
    @IBOutlet var textView: NSTextView!
    
    //MARK: - Lifecycle
    
    override var windowNibName: String? {
        return "ChatWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

      let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(ChatWindowController.receiveDidSendMessageNotification(_:)), name: ChatWindowDidSendNotification, object: nil)
    }
    
    deinit {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self)
    }
    
    //MARK: - Actions
    
    @IBAction func send(sender: AnyObject) {
        
        sender.window?.endEditingFor(nil)
        
        if let message = message {
            
            let userInfo = [ChatWindowControllerMessageKey: message]
            
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.postNotificationName(ChatWindowDidSendNotification, object: self, userInfo: userInfo)
        }
        
        message = ""
    }
    
    //MARK: - Notofications
    
    func receiveDidSendMessageNotification(note: NSNotification) {
        
        let mutableLog = log.mutableCopy() as! NSMutableAttributedString
        
        if log.length > 0 {
            mutableLog.appendAttributedString(NSAttributedString(string: "\n"))
        }
        
        let userInfo = note.userInfo! as! [String: String]
        let message = userInfo[ChatWindowControllerMessageKey]!
        
        let logLine = NSAttributedString(string: message)
        mutableLog.appendAttributedString(logLine)
        
        log = mutableLog.copy() as! NSAttributedString
        
        textView.scrollRangeToVisible(NSRange(location: log.length, length: 0))
    }
    
}
