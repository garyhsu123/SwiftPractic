//
//  ViewController.swift
//  SwiftXibPractice
//
//  Created by PCNB2003010 on 2020/3/8.
//  Copyright © 2020 PCNB2003010. All rights reserved.
//

import UIKit

let tutorialInfos: [[String: String]] = [
    [
        "title": "Core Graphic",
        "className": "CoreGraphicTutorialViewController",
    ],
    [
        "title": "Multi Thread",
        "className": "MultiThreadTutorialViewController",
    ],
    [
        "title": "Race Condition",
        "className": "RaceConditionViewController",
    ],
    [
        "title": "Graph",
        "className": "GraphViewController",
    ]
]

class ViewController: UIViewController {
   
    @IBOutlet var collectionView: UICollectionView!
    
    var tutorialInfoList: [TutorialInfoModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTutorialInfoModel()
        collectionView.register(UINib.init(nibName: "TutorialSubjectCell", bundle: nil), forCellWithReuseIdentifier: TutorialSubjectCell.identifier)
        
    }
    
    func generateTutorialInfoModel() {
        for tutorialInfo in tutorialInfos {
            if let title = tutorialInfo[DEF_KEY_TITLE], let className = tutorialInfo[DEF_KEY_CLASS_NAME] {
            self.tutorialInfoList .append(TutorialInfoModel.init(title: title, className: className))
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tutorialInfoViewModel = TutorialInfoViewModel.init(model: self.tutorialInfoList[indexPath.item])
        let viewController = tutorialInfoViewModel.viewController
    
        assert(viewController != nil, "[ViewController] viewController is nil with \(tutorialInfoViewModel.className)")
        
        viewController?.navigationItem.title = tutorialInfoViewModel.title
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tutorialInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialSubjectCell.identifier, for: indexPath) as! TutorialSubjectCell
        
        let tutorialInfoViewModel = TutorialInfoViewModel.init(model: self.tutorialInfoList[indexPath.item])
        cell.tutorialTitle.text = tutorialInfoViewModel.title
        
        
        return cell
    }
    
    
}



