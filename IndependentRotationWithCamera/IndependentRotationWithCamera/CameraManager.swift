//
//  CameraManager.swift
//  IndependentRotationWithCamera
//
//  Created by Justin Ouellette on 3/1/15.
//  Copyright (c) 2015 Justin Ouellette. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

private let _queue = dispatch_queue_create("AVCaptureSession", DISPATCH_QUEUE_SERIAL)
private let _shared = CameraManager()

class CameraManager : NSObject {
    private var _captureDevice: AVCaptureDevice?
    private let _captureSession = AVCaptureSession()
    private let _stillImageOutput = AVCaptureStillImageOutput()
    private let _assetsLibrary = ALAssetsLibrary()

    override init() {
        super.init()
        
        dispatch_async(_queue, _configureSession)
    }

    class func shared() -> CameraManager {
        return _shared
    }
    
    func startSession() {
        dispatch_async(_queue) {
            self._captureSession.startRunning()
        }
    }
    
    func stopSession() {
        dispatch_async(_queue) {
            self._captureSession.stopRunning()
        }
    }
    
    func configurePreviewLayer(layer: AVCaptureVideoPreviewLayer) {
        dispatch_async(_queue) {
            layer.session = self._captureSession
        }
    }
    
    private func _configureSession() {
        for device in AVCaptureDevice.devices() {
            if device.hasMediaType(AVMediaTypeVideo) && device.position == AVCaptureDevicePosition.Back {
                _captureDevice = device as? AVCaptureDevice
            }
        }
        
        if _captureDevice == nil {
            return
        }
        
        _captureSession.beginConfiguration()
        
        var error: NSError?
        let input = AVCaptureDeviceInput(device: _captureDevice!, error: &error)
        if let e = error {
            println(e.localizedDescription)
        }
        
        if _captureSession.canSetSessionPreset(AVCaptureSessionPresetPhoto) {
            _captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        }
        
        if _captureSession.canAddInput(input) {
            _captureSession.addInput(input)
        }

        _stillImageOutput.outputSettings = [ AVVideoCodecKey : AVVideoCodecJPEG, AVVideoQualityKey : 1.0 ]
        _stillImageOutput.highResolutionStillImageOutputEnabled = true
        
        if _captureSession.canAddOutput(_stillImageOutput) {
            _captureSession.addOutput(_stillImageOutput)
        }
        
        _captureSession.commitConfiguration()
    }

    func captureStillImageWithOrientation(orientation: UIInterfaceOrientation) {
        dispatch_async(_queue) {
            let connection = self._stillImageOutput.connectionWithMediaType(AVMediaTypeVideo)
            connection.videoOrientation = orientation.avOrientation

            self._stillImageOutput.captureStillImageAsynchronouslyFromConnection(connection, completionHandler: { (buffer, error) in
                if let b = buffer {
                    let mode = CMAttachmentMode(kCMAttachmentMode_ShouldPropagate)
                    let metadata = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, b, mode).takeRetainedValue() as NSDictionary
                    let data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(b)
                    self._assetsLibrary.writeImageDataToSavedPhotosAlbum(data, metadata: metadata, completionBlock: nil)
                }

                if let e = error {
                    println(e.localizedDescription)
                }
            })
        }
    }
}

extension UIInterfaceOrientation {
    var avOrientation: AVCaptureVideoOrientation {
        switch self {
            case UIInterfaceOrientation.LandscapeLeft:
                return AVCaptureVideoOrientation.LandscapeLeft
            case UIInterfaceOrientation.LandscapeRight:
                return AVCaptureVideoOrientation.LandscapeRight
            case UIInterfaceOrientation.PortraitUpsideDown:
                return AVCaptureVideoOrientation.PortraitUpsideDown
            case UIInterfaceOrientation.Portrait:
                return AVCaptureVideoOrientation.Portrait
            default:
                return AVCaptureVideoOrientation.Portrait
        }
    }
}
