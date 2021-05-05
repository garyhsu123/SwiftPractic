//
//  ViewController.swift
//  SwiftXibPractice
//
//  Created by PCNB2003010 on 2020/3/8.
//  Copyright © 2020 PCNB2003010. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.register(UINib.init(nibName: "TutorialSubjectCell", bundle: nil), forCellWithReuseIdentifier: TutorialSubjectCell.identifier)
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = CoreGraphicTutorialViewController.instantiate()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialSubjectCell.identifier, for: indexPath) as! TutorialSubjectCell
        cell.tutorialTitle.text = "Core Graphic"
        return cell
    }
    
    
}



