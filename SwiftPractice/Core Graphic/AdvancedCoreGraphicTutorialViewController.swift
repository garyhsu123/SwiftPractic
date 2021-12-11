//
//  AdvancedCoreGraphicTutorialViewController.swift
//  SwiftPractice
//
//  Created by Yu-Chun Hsu on 2021/11/13.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit

class AdvancedCoreGraphicTutorialViewController: UIViewController {
    static func instantiate() -> AdvancedCoreGraphicTutorialViewController
    {
        return UIStoryboard(name: "Tutorials", bundle: nil).instantiateViewController(withIdentifier: "AdvancedCoreGraphicTutorialViewController") as! AdvancedCoreGraphicTutorialViewController
    }
}
