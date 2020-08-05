//
//  TutorialPageViewController.swift
//  MyMoney
//
//  Created by Kirill on 16.02.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    var pages:[TutorialViewController] = []
    var tutorialStep = TutorialStep.mainDescription {
        didSet {
            initNewTutorialVC()
        }
    }
    
    deinit {
        pages = []
        print("deinit")
    }
    
    var currentViewController: TutorialViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tutorialViewController") as! TutorialViewController
        let statistic = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tutorialViewController") as! TutorialViewController
        let create = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tutorialViewController") as! TutorialViewController
        pages = [main, statistic, create]
        if let mainTutorialVC = pages.first {
            currentViewController = mainTutorialVC
            setViewControllers([mainTutorialVC], direction: .forward, animated: false, completion: nil)
            initNewTutorialVC()
        }
    }
    
    private func initNewTutorialVC() {
        if let vc = currentViewController {
            vc.descriptionLabel.text = tutorialStep.description
            vc.buttonStep.addTarget(self, action: #selector(stepDidTap(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func stepDidTap(_ sender: UIButton) {
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        let nav = mainStoryboardIpad.instantiateViewController(withIdentifier: "AuthController") as! UINavigationController
        self.view.window?.rootViewController = nav
    }
}

extension TutorialPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! TutorialViewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            currentViewController = pages.last
            tutorialStep = TutorialStep(rawValue: pages.count-1)!
            return currentViewController
        }
        guard pages.count > previousIndex else { return nil }
        currentViewController = pages[previousIndex]
        tutorialStep = TutorialStep(rawValue: previousIndex)!
        return currentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = getNextViewControllerIndex(viewController: viewController as! TutorialViewController)
        if index != -1 {
            currentViewController = pages[index]
            tutorialStep = TutorialStep(rawValue: index)!
        }
        return currentViewController
    }
    
    private func getNextViewControllerIndex(viewController: TutorialViewController) -> Int {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return -1 }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else {
            return 0
        }
        guard pages.count > nextIndex else { return -1 }
        
        return nextIndex
    }
}

extension TutorialPageViewController: UIPageViewControllerDelegate {
}
