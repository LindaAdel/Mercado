//
//  LaunchScreenViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/18/21.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var launchScreenView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("AHLAAAAAAAAN")
        launchScreenView!.contentMode = .scaleAspectFit
        
        launchScreenView!.loopMode = .loop
        
        launchScreenView!.animationSpeed = 0.5
        
        launchScreenView!.play()
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
