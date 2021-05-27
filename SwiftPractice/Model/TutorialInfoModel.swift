//
//  TutorialInfoModel.swift
//  SwiftPractice
//
//  Created by Yu-Chun Hsu on 2021/5/27.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import Foundation

let DEF_KEY_TITLE = "title"
let DEF_KEY_CLASS_NAME = "className"

struct TutorialInfoModel {
    var title: String
    var className: String
    
    init(title: String, className: String) {
        self.title = title
        self.className = className
    }
}
