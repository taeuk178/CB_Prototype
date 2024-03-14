
import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    // 싱글턴이나 유저디폴트로 개선
    var isDeviceMotionCheck: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func setBluetooth() {
        
        switch isDeviceMotionCheck {
            // 운동 상세화면
        case true:
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExerciseStartViewController") as? ExerciseStartViewController {
                
                let reactor = ExerciseStartReactor()
                vc.reactor = reactor
                self.present(vc, animated: true)
            }
            // 에어팟 감지 화면
        case false: 
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AirPodsCheckViewController") as? AirPodsCheckViewController {
                
                let reactor = AirPodsCheckReactor()
                vc.reactor = reactor
                self.present(vc, animated: true)
            }
        }
//        startHeadphoneMotionUpdates()
    }
}
