//
//  Coordinator.swift
//  MyMoney
//
//  Created by Kirill on 23.06.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func goToAuth()
    
    func openMainScreen()
    
    func openSettings()
    
    func openStatics()
    
    func openBalanceData()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func goToAuth() {
        let storyboard = UIStoryboard.storyboard(storyboard: .auth)
        let loginViewController: LoginViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    func openMainScreen() {
        let storyboard = UIStoryboard.storyboard(storyboard: .home)
        let mainViewController: MainViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    func openSettings() {
        let storyboard = UIStoryboard.storyboard(storyboard: .home)
        let settingsViewController: SettingsViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(settingsViewController, animated: false)
    }
    
    func openStatics() {
        let storyboard = UIStoryboard.storyboard(storyboard: .home)
        let statisticsViewController: StatisticViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(statisticsViewController, animated: false)
    }
    
    func openBalanceData() {
        let storyboard = UIStoryboard.storyboard(storyboard: .home)
        let balanceDataViewController: BalanceDataViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(balanceDataViewController, animated: false)
    }
}
