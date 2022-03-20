//
//  MainViewController.swift
//  HW 2
//
//  Created by Назар Ткаченко on 19.03.2022.

import UIKit

protocol SettingsViewControllerDelegate {
    func setMainBackGround (for colorBackGround: UIColor?)
}

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let SettingsVC = segue.destination as? SettingsViewController else { return }
        SettingsVC.mainViewBackGround = view.backgroundColor
        SettingsVC.delegate = self
    }
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}
//MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setMainBackGround(for colorBackGround: UIColor?) {
        view.backgroundColor = colorBackGround
    }
    
    
}
