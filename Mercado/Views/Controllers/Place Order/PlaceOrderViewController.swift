//
//  PlaceOrderViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/1/21.
//

import UIKit
import Lottie

class PlaceOrderViewController: UIViewController {

    @IBAction func backToHomeBtn(_ sender: Any) {
        let home = storyboard?.instantiateViewController(identifier: "Home") as! HomeTabBarController
        home.modalPresentationStyle = .fullScreen
        self.present(home, animated: true, completion: nil)
    }
    @IBOutlet weak var checkmarkView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        checkmarkView!.contentMode = .scaleAspectFit
               
               checkmarkView!.loopMode = .loop
               
               checkmarkView!.animationSpeed = 0.5
               
               checkmarkView!.play()
        
    }
    

   

}
