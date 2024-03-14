//
//  AirPodsCheckViewController.swift
//  CB_Prototype
//
//  Created by tw on 3/15/24.
//

import UIKit
import ReactorKit
import RxSwift
import CoreMotion

class AirPodsCheckViewController: UIViewController, StoryboardView {

    var disposeBag = DisposeBag()
    
    var isDeviceMotionCheck: Bool = true
    private let motionManager = CMHeadphoneMotionManager()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setUpView()
        bind(reactor: self.reactor ?? Reactor())
        startHeadphoneMotionUpdates()
    }
    
    func performBinding() {
        return
    }
    
    func bind(reactor: AirPodsCheckReactor) {
        guard self.isViewLoaded else { return }
    }
    
    deinit {
        // 뷰 컨트롤러가 해제될 때 모션 업데이트 중지
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}

extension AirPodsCheckViewController: CMHeadphoneMotionManagerDelegate {
    
    func startHeadphoneMotionUpdates() {
        // 모션 매니저가 사용 가능한지 확인
        guard !isDeviceMotionCheck else {
            print("Device Motion is not available.")
            return
        }
        
        // 모션 업데이트 시작
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
            guard error == nil, let motion = motion else {
                print("Error reading motion data: \(error!)")
                return
            }
            
            // 여기에서 모션 데이터를 사용
            // 예: 가속도계와 자이로스코프 데이터 읽기
            let attitude = motion.attitude
            let rotationRate = motion.rotationRate
            let userAcceleration = motion.userAcceleration
            
            print("Attitude: \(attitude)")
            print("Rotation Rate: \(rotationRate)")
            print("User Acceleration: \(userAcceleration)")
        }
    }
    
    func headphoneMotionManagerDidConnect(_ manager: CMHeadphoneMotionManager) {
        if manager.isDeviceMotionAvailable {
            print("available OK")
        } else {
            print("available No")
        }
    }
}
