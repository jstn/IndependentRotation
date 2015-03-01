//
//  RotatingViewController.swift
//  IndependentRotation
//
//  Created by Justin Ouellette on 3/1/15.
//  Copyright (c) 2015 Justin Ouellette. All rights reserved.
//

import UIKit

class RotatingViewController: UIViewController {
    var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView = UIView(frame: CGRectZero)
        contentView.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.5)
        contentView.opaque = false

        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        view.addSubview(contentView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let screenBounds = UIScreen.mainScreen().bounds
        let offset: CGFloat = fabs(screenBounds.width - screenBounds.height)

        view.frame = CGRectOffset(view.bounds, offset, offset)
        contentView.frame = view.bounds
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
}
