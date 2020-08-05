//
//  Storyboard+Type.swift
//  MyMoney
//
//  Created by Kirill on 26.05.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit
extension UIStoryboard {
    enum Storyboard: String {
        case home
        case tutorial
        case auth
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardInstantiable {
        
        guard let viewController = self.instantiateViewController(withIdentifier: T.className) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.className) ")
        }
        
        return viewController
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
}
