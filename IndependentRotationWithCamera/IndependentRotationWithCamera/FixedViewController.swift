//
//  FixedViewController.swift
//  IndependentRotationWithCamera
//
//  Created by Justin Ouellette on 3/1/15.
//  Copyright (c) 2015 Justin Ouellette. All rights reserved.
//

import UIKit
import AVFoundation

class FixedViewController: UIViewController {
    class PreviewView: UIView {
        override class func layerClass() -> AnyClass {
            return AVCaptureVideoPreviewLayer.self
        }
    }

    override func loadView() {
        view = PreviewView(frame: CGRectZero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blackColor()

        CameraManager.shared().configurePreviewLayer(self.view.layer as AVCaptureVideoPreviewLayer)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        CameraManager.shared().startSession()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

        CameraManager.shared().stopSession()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        view.frame = UIScreen.mainScreen().bounds
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
}
