//
//  CoreGraphicTutorialViewController.swift
//  SwiftXibPractice
//
//  Created by Yu-Chun Hsu on 2021/5/4.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit

class CoreGraphicTutorialViewController: UIViewController {
    
    static func instantiate() -> CoreGraphicTutorialViewController
    {
        return UIStoryboard(name: "Tutorials", bundle: nil).instantiateViewController(withIdentifier: "CoreGraphicTutorialViewController") as! CoreGraphicTutorialViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
