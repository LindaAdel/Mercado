//
//  SceneDelegate.swift
//  Mercado
//
//  Created by Linda adel on 4/16/21.
//

import UIKit
import Firebase
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainStoryboard : UIStoryboard?
    var initialViewController: UIViewController?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        print("scene delegate")
        guard let windowScnen = (scene as? UIWindowScene) else { return }
//        //initialize window
//        self.window = UIWindow(windowScene: windowScnen)
//        //initialize main storyboard
//        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            
//            //check if user already signed in
//            if Auth.auth().currentUser != nil
//            {
//                print(Auth.auth().currentUser?.email!)
//                //open home screen
//                initialViewController = mainStoryboard?.instantiateViewController(withIdentifier: "first")as! ViewController
//                  
//                } else {
//                    initialViewController = mainStoryboard?.instantiateViewController(withIdentifier: "login")as! LoginTableViewController
//                }
//         //set initial view controller
//        self.window?.rootViewController = initialViewController
//        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

