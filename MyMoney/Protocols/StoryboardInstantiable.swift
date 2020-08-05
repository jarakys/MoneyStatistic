//
//  StoryboardInstantiable.swift
//  MyMoney
//
//  Created by Kirill on 26.05.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
}

extension StoryboardInstantiable where Self: UIViewController {
    static var className: String {
        return String(describing: Self.self)
    }
}
