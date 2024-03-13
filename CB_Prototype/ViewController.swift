
import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let motionManager = CMHeadphoneMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func setBluetooth() {
        startHeadphoneMotionUpdates()
    }
    
    func startHeadphoneMotionUpdates() {
        // 모션 매니저가 사용 가능한지 확인
        guard motionManager.isDeviceMotionAvailable else {
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
    
    deinit {
        // 뷰 컨트롤러가 해제될 때 모션 업데이트 중지
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}
