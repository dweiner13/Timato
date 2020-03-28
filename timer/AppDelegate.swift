//
//  AppDelegate.swift
//  timer
//
//  Created by Dan Weiner on 3/27/20.
//  Copyright © 2020 Dan Weiner. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    var contentView: ContentView?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        contentView = ContentView()

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView, .utilityWindow],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        window.delegate = self
        window.title = "Timer"

        _ = NotificationManager.shared.requestAccess()
            .print()
    }

    @IBAction func startTimer(_ sender: Any) {
        contentView?.pressBigButton()
    }

    @IBAction func setTo25Minutes(_ sender: Any) {
    }

    @IBAction func setTo5Minutes(_ sender: Any) {
    }

}

extension AppDelegate: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        NSApp.terminate(nil)
    }
}

