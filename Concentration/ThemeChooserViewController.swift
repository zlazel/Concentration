//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by AhmedZlazel on 6/2/18.
//  Copyright © 2018 AhmedZlazel. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController , UISplitViewControllerDelegate {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🥅🏒" ,
        "Animals": "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮" ,
        "Faces": "😄😅😂🤣😇😉😍😘🤑😎🤡"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
        ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.theme == nil{
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitVieDetailConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
                }
        }else if let cvc = lastSeguedConcentrationViewControler{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
                }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else{
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitVieDetailConcentrationViewController: ConcentrationViewController?{
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    private var lastSeguedConcentrationViewControler: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle ,let theme = themes[themeName]{
                if let cvc = segue.destination as? ConcentrationViewController{
                    cvc.theme = theme
                    lastSeguedConcentrationViewControler = cvc
                }
            }
        }
    }
}
