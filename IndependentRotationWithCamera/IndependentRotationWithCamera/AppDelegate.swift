//
//  AppDelegate.swift
//  IndependentRotationWithCamera
//
//  Created by Justin Ouellette on 3/1/15.
//  Copyright (c) 2015 Justin Ouellette. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var fixedWindow: UIWindow!
    var rotatingWindow: UIWindow!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let screenBounds = UIScreen.mainScreen().bounds
        let inset: CGFloat = fabs(screenBounds.width - screenBounds.height)

        fixedWindow = UIWindow(frame: screenBounds)
        fixedWindow.rootViewController = FixedViewController()
        fixedWindow.backgroundColor = UIColor.blackColor()
        fixedWindow.hidden = false

        rotatingWindow = UIWindow(frame: CGRectInset(screenBounds, -inset, -inset))
        rotatingWindow.rootViewController = RotatingViewController()
        rotatingWindow.backgroundColor = UIColor.clearColor()
        rotatingWindow.opaque = false
        rotatingWindow.makeKeyAndVisible()

        return true
    }
}
