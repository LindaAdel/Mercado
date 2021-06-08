//
//  PlaceOrderFailedViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/4/21.
//

import UIKit
import Lottie

class PlaceOrderFailedViewController: UIViewController {

   
    @IBOutlet weak var noConnectionView: AnimationView!
    @IBAction func tryAgainBtn(_ sender: Any) {
        let checkout = storyboard?.instantiateViewController(identifier: "Checkout") as! CheckoutViewController
        checkout.modalPresentationStyle = .fullScreen
        self.present(checkout, animated: true, completion: nil)
    }
    @IBAction func backToHomeBtn(_ sender: Any) {
        let home = storyboard?.instantiateViewController(identifier: "Home") as! HomeTabBarController
        home.modalPresentationStyle = .fullScreen
        self.present(home, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        noConnectionView!.contentMode = .scaleAspectFit
        
        noConnectionView!.loopMode = .loop
        
        noConnectionView!.animationSpeed = 0.5
        
        noConnectionView!.play()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
