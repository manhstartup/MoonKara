//
//  AppDelegate.swift
//  MoonKara
//
//  Created by JoJo on 5/5/17.
//  Copyright © 2017 JoJo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.backgroundColor = UIColor.white;
        /*
        let kclass:String = String.init(describing: MoonHomeVC.self)
        let vc:MoonHomeVC = MoonHomeVC(nibName: kclass, bundle: nil)
        window?.rootViewController = vc;
        window?.makeKeyAndVisible();
        */
        //test
        let kclass:String = String.init(describing: MoonHomeVC.self)
        let vc1:MoonHomeVC = MoonHomeVC(nibName: kclass, bundle: nil)
        vc1.view.backgroundColor = UIColor.cyan
        vc1.tabBarItem.badgeValue = "1"
        vc1.title = "Home"
        vc1.tabBarItem.image = UIImage(named: "tabbar_home")
        vc1.tabBarItem.selectedImage = UIImage(named: "tabbar_home_selected")

        
        let vc2: UIViewController = UIViewController()
        vc2.view.backgroundColor = UIColor.cyan
        vc2.tabBarItem.badgeValue = "1"
        vc2.title = "Message"
        vc2.tabBarItem.image = UIImage(named: "tabbar_message_center")
        vc2.tabBarItem.selectedImage = UIImage(named: "tabbar_message_center_selected")

        let vc3: UIViewController = UIViewController()
        vc3.view.backgroundColor = UIColor.cyan
        vc3.tabBarItem.badgeValue = "1"
        vc3.title = "Discover"
        vc3.tabBarItem.image = UIImage(named: "tabbar_discover")
        vc3.tabBarItem.selectedImage = UIImage(named: "tabbar_discover_selected")

        let vc4: UIViewController = UIViewController()
        vc4.view.backgroundColor = UIColor.cyan
        vc4.tabBarItem.badgeValue = "4"
        vc4.title = "Profile"
        vc4.tabBarItem.image = UIImage(named: "tabbar_profile")
        vc4.tabBarItem.selectedImage = UIImage(named: "tabbar_profile_selected")

        let navC1: UINavigationController = UINavigationController(rootViewController: vc1)
        let navC2: UINavigationController = UINavigationController(rootViewController: vc2)
        let navC3: UINavigationController = UINavigationController(rootViewController: vc3)
        let navC4: UINavigationController = UINavigationController(rootViewController: vc4)

        let tabBarC: MoonTabBarVC = MoonTabBarVC()
        tabBarC.viewControllers = [navC1,navC2,navC3,navC4]
        window?.rootViewController = tabBarC;
        window?.makeKeyAndVisible();

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

