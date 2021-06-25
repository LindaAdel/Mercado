//
//  EmailNotVerifiedViewController.swift
//  Mercado
//
//  Created by Linda adel on 6/24/21.
//

import UIKit
import Lottie

class EmailNotVerifiedViewController: UIViewController {

    @IBOutlet weak var EmailNotVerifiedView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        EmailNotVerifiedView!.contentMode = .scaleAspectFit
               
        EmailNotVerifiedView!.loopMode = .loop
               
        EmailNotVerifiedView!.animationSpeed = 0.5
               
        EmailNotVerifiedView!.play()
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
