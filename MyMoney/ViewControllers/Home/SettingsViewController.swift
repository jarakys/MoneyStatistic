//
//  SettingsViewController.swift
//  MyMoney
//
//  Created by Kirill on 16.02.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = Settings.init(rawValue: indexPath.row)
        switch item {
        case .logout:
            print("logout")
        case .shareMyAccountWith:
            guard true == true else {
                print("gotoAuth")
                return
            }
            print("gotoShareScreen")
        case .turnOnOffNotification:
            guard true == true else {
                //showAlert
                print("gotoAuth")
                return
            }
            print("gotoShareScreen")
        default:
            print("gotoShareScreen")
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        let item = Settings.init(rawValue: indexPath.row)
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text = item.string
            label.textColor = item.textColor
        }
        if let imageIcon = cell.viewWithTag(2) as? UIImageView, item.isNeedAuth {
            imageIcon.image = UIImage(named: "lock")
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
        return cell
    }
}
