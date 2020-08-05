//
//  StatisticVCAnimator.swift
//  MyMoney
//
//  Created by Kirill on 26.05.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

// B2 - 8
final class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // B2 - 9
    static let duration: TimeInterval = 0.5

    private let type: PresentationType
    private let firstViewController: UIViewController
    private let secondViewController: UIViewController

    // B2 - 10
    init?(type: PresentationType, firstViewController: UIViewController, secondViewController: UIViewController) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController

        guard let window = firstViewController.view.window ?? secondViewController.view.window
            else { return nil }
    }

    // B2 - 12
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    // B2 - 13
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let toView = secondViewController.view
            else {
                transitionContext.completeTransition(false)
                return
        }

        containerView.addSubview(toView)
        
        guard let window = firstViewController.view.window ?? secondViewController.view.window
            else {
                transitionContext.completeTransition(true)
                return
        }
        toView.alpha = 0
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                toView.alpha = 1
            }
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

// B2 - 14
enum PresentationType {

    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}
