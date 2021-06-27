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

        NotificationCenter.default.addObserver(self, selector: #selector(presentNoConnectionVC(_:)), name: .internetNotification, object: nil)
        // Do any additional setup after loading the view.
        noConnectionView!.contentMode = .scaleAspectFit
        
        noConnectionView!.loopMode = .loop
        
        noConnectionView!.animationSpeed = 0.5
        
        noConnectionView!.play()
    }
    
    @objc func presentNoConnectionVC(_ notification : Notification) {
        if let data = notification.userInfo{
         let isConnected : Bool = data["isConnected"]! as! Bool
         if isConnected{
             DispatchQueue.main.async {
                 self.dismiss(animated: true, completion: nil)
             }
         }
      }
    }
    

  

}
