//
//  TutorialInfoViewModel.swift
//  SwiftPractice
//
//  Created by Yu-Chun Hsu on 2021/5/27.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit

class TutorialInfoViewModel: NSObject {
    
    var title: String
    var className: String
    var viewController: UIViewController? {
        get {
            return TutorialInfoViewModel.instantiateVC(className: className)
        }
    }
    
    init(model: TutorialInfoModel) {
        title = model.title
        className = model.className
        super.init()
    }
    
    static func instantiateVC(className: String?) -> UIViewController? {
        switch className {
        case String(describing: CoreGraphicTutorialViewController.self):
            return CoreGraphicTutorialViewController.instantiate()
        case String(describing: MultiThreadTutorialViewController.self):
            return MultiThreadTutorialViewController.instantiate()
        case String(describing: RaceConditionViewController.self):
            return RaceConditionViewController.instantiate()
        case String(describing: GraphViewController.self):
            return GraphViewController.instantiate()
        case String(describing: AdvancedCoreGraphicTutorialViewController.self):
            return AdvancedCoreGraphicTutorialViewController.instantiate()
        default:
            return nil
        }
    }
}
