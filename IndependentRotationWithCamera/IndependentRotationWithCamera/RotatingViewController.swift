//
//  RotatingViewController.swift
//  IndependentRotationWithCamera
//
//  Created by Justin Ouellette on 3/1/15.
//  Copyright (c) 2015 Justin Ouellette. All rights reserved.
//

import UIKit

class RotatingViewController: UIViewController {
    var contentView: UIView!
    var labelView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = UIView(frame: CGRectZero)
        contentView.backgroundColor = UIColor.clearColor()
        contentView.opaque = false

        labelView = UILabel(frame: CGRectZero)
        labelView.text = "tap to take a photo"
        labelView.textColor = UIColor.whiteColor()
        labelView.textAlignment = NSTextAlignment.Center
        labelView.sizeToFit()
        contentView.addSubview(labelView)

        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        view.addSubview(contentView)

        let tap = UITapGestureRecognizer(target: self, action: "recognizedTap:")
        view.addGestureRecognizer(tap)
    }

    func recognizedTap(gesture: UITapGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.Ended {
            CameraManager.shared().captureStillImageWithOrientation(interfaceOrientation)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let screenBounds = UIScreen.mainScreen().bounds
        let offset: CGFloat = fabs(screenBounds.width - screenBounds.height)

        view.frame = CGRectOffset(view.bounds, offset, offset)
        contentView.frame = view.bounds

        labelView.center = contentView.center
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
}
