//
//  FixedViewController.swift
//  IndependentRotation
//
//  Created by Justin Ouellette on 3/1/15.
//  Copyright (c) 2015 Justin Ouellette. All rights reserved.
//

import UIKit

class FixedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blueColor()
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
}
