//
//  MultiThreadTutorialViewController.swift
//  SwiftPractice
//
//  Created by Yu-Chun Hsu on 2021/5/27.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit

class MultiThreadTutorialViewController: UIViewController {

    static func instantiate() -> MultiThreadTutorialViewController
    {
        return UIStoryboard(name: "Tutorials", bundle: nil).instantiateViewController(withIdentifier: "MultiThreadTutorialViewController") as! MultiThreadTutorialViewController
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
