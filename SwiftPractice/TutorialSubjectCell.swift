//
//  TutorialSubjectCell.swift
//  SwiftXibPractice
//
//  Created by Yu-Chun Hsu on 2021/5/4.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit

class TutorialSubjectCell: UICollectionViewCell {
    static let identifier = "TutorialSubjectCellIdentifier"
    
    @IBOutlet weak var tutorialTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
