//
//  TabBarViewWireframe.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 28.08.2022.
//

import UIKit

class TabBarViewWireframe: NSObject, TabBarViewWireframeProtocol {
    
    static var instance: TabBarViewWireframe?

    static func getInstance() -> TabBarViewWireframe {
        if (instance == nil) {
            instance = TabBarViewWireframe()
        }
        return instance!
    }

    private override init() {}

    
    var tabBarScreenViewController: TBViewController?
    var window: UIWindow?
    
    func presentTabBarViewControllerInWindow() {
        let vc = TBViewController()
        vc.modalPresentationStyle = .fullScreen
        self.tabBarScreenViewController = vc
        
        self.window?.rootViewController = tabBarScreenViewController
        self.window?.makeKeyAndVisible()
//        present(vc, animated: true, completion: nil)
    }

    

    
    
}
