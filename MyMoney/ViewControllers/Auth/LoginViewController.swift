//
//  LoginViewController.swift
//  MyMoney
//
//  Created by Kirill on 15.02.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginDidTap(_ sender: Any) {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            presentAlert(withTitle: "Error", message: "Email")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            presentAlert(withTitle: "Error", message: "Password")
            return
        }
        
        view.showBlurLoader()

        
        view.removeBluerLoader()
        
        
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let nav = mainStoryboardIpad.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
        self.view.window?.rootViewController = nav
        
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
