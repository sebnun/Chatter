//
//  AppDelegate.swift
//  Chatter
//
//  Created by Sebastian on 4/2/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowControllers: [ChatWindowController] = []


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        addWindowController()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    //MARK: - Actions
    
    @IBAction func displayNewWindow(sender: NSMenuItem) {
        addWindowController()
    }

    //MARK: - Helpers
    
    func addWindowController() {
        
        let windowController = ChatWindowController()
        windowController.showWindow(self)
       
        windowControllers.append(windowController)
    }
    
    func applicationDidResignActive(notification: NSNotification) {
        NSBeep()
    }
}

