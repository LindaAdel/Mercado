//
//  NoInternetConnectionViewController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/6/21.
//

import UIKit
import Lottie

class NoInternetConnectionViewController: UIViewController {

    @IBOutlet weak var noConnectionView: AnimationView!
  
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
