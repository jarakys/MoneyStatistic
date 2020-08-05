//
//  UIView+blurLoader.swift
//  Leards
//
//  Created by Kirill on 28.12.2019.
//  Copyright © 2019 Samax. All rights reserved.
//

import UIKit
extension UIView {
    func showBlurLoader() {
        let blurLoader = BlurLoader(frame: frame)
        self.addSubview(blurLoader)
        blurLoader.isUserInteractionEnabled = true
        blurLoader.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blurLoader.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blurLoader.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        blurLoader.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        blurLoader.translatesAutoresizingMaskIntoConstraints = false
    }

    func removeBluerLoader() {
        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
            blurLoader.isUserInteractionEnabled = false
            blurLoader.removeFromSuperview()
        }
    }
}
