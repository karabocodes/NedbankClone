//
//  SceneDelegate.swift
//  NedbankClone
//
//  Created by Nagarro on 2024/08/02.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = createTabber()
            window?.makeKeyAndVisible()
        }
        
        // Function to create a UINavigationController with LoginViewController as its root
        func createLoginNavigationController() -> UINavigationController {
            let loginVC = LoginViewController()
            loginVC.title = "Login"
            
            let loginTabBarItem = UITabBarItem(title: "Login",
                                               image: UIImage(systemName: "key"),
                                               selectedImage: UIImage(systemName: "key"))
            loginTabBarItem.tag = 2
            
            loginVC.tabBarItem = loginTabBarItem
            
            return UINavigationController(rootViewController: loginVC)
        }

        // Function to create a UINavigationController with HomeViewController as its root
        func createHomeNavigationController() -> UINavigationController {
            let homeVC = HomeViewController()
            homeVC.title = "Home"
            
            let homeTabBarItem = UITabBarItem(title: "Home",
                                               image: UIImage(systemName: "house.circle"),
                                               selectedImage: UIImage(systemName: "house.circle"))
            homeTabBarItem.tag = 1
            homeVC.tabBarItem = homeTabBarItem
            
            return UINavigationController(rootViewController: homeVC)
        }
    
    func createTransactionsController() -> UINavigationController {
        let transactVC = TransactionsViewController()
        
        transactVC.title = "Transactions"
        
        let transactionTabBarItem = UITabBarItem(title: "transactions",
                                                 image: UIImage(systemName: "transmission"),
                                                 selectedImage: UIImage(systemName: "transmission"))
        transactionTabBarItem.tag = 3
        transactVC.tabBarItem = transactionTabBarItem
        
        return UINavigationController(rootViewController: transactVC)
    }
    
    func createRecipientsController() -> UINavigationController {
        let recipientsVC = RecipientsViewController()
        recipientsVC.title = "Recipients"
        
        let recipientsTabBarItem = UITabBarItem(title: "Recipients",
                                                image: UIImage(systemName: "person"),
                                                selectedImage: UIImage(systemName: "person"))
        recipientsTabBarItem.tag = 4 // Ensure unique tag for the Recipients tab
        recipientsVC.tabBarItem = recipientsTabBarItem
        
        return UINavigationController(rootViewController: recipientsVC)
    }
        
        // Function to create and return a UITabBarController with custom tabs
        func createTabber() -> UITabBarController {
            let tabbar = UITabBarController()
            
            // Set the tintColor of the tab bar to system green
            UITabBar.appearance().tintColor = .systemGreen
            
            // Set the viewControllers property of the tab bar controller
            tabbar.viewControllers = [createLoginNavigationController(), createHomeNavigationController(), createTransactionsController(), createRecipientsController()]
            
            return tabbar
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
    }


}

