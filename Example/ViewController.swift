import UIKit
import UnionPay

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = UPPaymentControl.default()
    }
}
