//
//  MotionDetector.swift
//  SPM_BubbleLevel
//
//  Created by Luiz Araujo on 13/04/22.
//

import CoreMotion
import UIKit

class MotionDetector: ObservableObject {
    private let motionManager = CMMotionManager()
    
    private var timer = Timer()
    private var updateInterval: TimeInterval = 0.0
    
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    @Published var zAcceleration: Double = 0.0
    
    var onUpdate: (() -> Void) = {}
    
    private var currentOrientation: UIDeviceOrientation = .landscapeLeft
    private var orientationObserver: NSObjectProtocol? = nil
    let notification = UIDevice.orientationDidChangeNotification
    
    init(updateInterval: TimeInterval) {
        self.updateInterval = updateInterval
    }
    
    func start() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        orientationObserver = NotificationCenter.default.addObserver(forName: notification, object: nil, queue: .main) { [weak self] _ in
            
            switch UIDevice.current.orientation {
            case .faceUp, .faceDown, .unknown:
                break
                
            default:
                self?.currentOrientation = UIDevice.current.orientation
            }
        }
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates()
            
            timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { _ in
                self.updateMotionData()
            }
            
        } else {
            print("Motion data isn't available on this device")
        }
    }
    
    func updateMotionData() {
        if let data = motionManager.deviceMotion {
            (roll, pitch) = currentOrientation.adjustedRollAndPitch(data.attitude)
            zAcceleration = data.userAcceleration.z
            
            onUpdate()
        }
    }
    
    func stop(){
        motionManager.stopDeviceMotionUpdates()
        timer.invalidate()
        if let orientationObserver = orientationObserver {
            NotificationCenter.default.removeObserver(orientationObserver, name: notification, object: nil)
        }
        
        orientationObserver = nil
    }
    
    deinit {
        stop()
    }
}
