//
//  TutorialViewController.swift
//  MyMoney
//
//  Created by Kirill on 16.02.2020.
//  Copyright © 2020 Samax. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tutorialImageView: UIImageView!
    @IBOutlet weak var buttonStep: UIButton!
    var tutorialStep = TutorialStep.mainDescription {
        didSet {
            
        }
    }
    
    deinit {
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextDidTap(_ sender: Any) {
        switch tutorialStep {
        case .mainDescription:
            print("Hi from main")
        case .statisticDescription:
            tutorialStep = TutorialStep.statisticDescription
        case .createDescription:
            tutorialStep = TutorialStep.mainDescription
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  self.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    

}
