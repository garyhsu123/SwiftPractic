//
//  CoreGraphicTutorialViewController.swift
//  SwiftXibPractice
//
//  Created by Yu-Chun Hsu on 2021/5/4.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit

class CoreGraphicTutorialViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphViewContainer: UIView!
    var graphView: GraphView?
    
    var isGraphicViewShowing = false
    
    static func instantiate() -> CoreGraphicTutorialViewController
    {
        return UIStoryboard(name: "Tutorials", bundle: nil).instantiateViewController(withIdentifier: "CoreGraphicTutorialViewController") as! CoreGraphicTutorialViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initGraphView()
        // Do any additional setup after loading the view.
        counterLabel.text = String(counterView.counter)
        counterView.isHidden = isGraphicViewShowing
        graphViewContainer.isHidden = !isGraphicViewShowing
    }
    
    func initGraphView() {
        guard let graphView = GraphView.initialize() else {
            return
        }
        self.graphView = graphView
        graphViewContainer.addSubview(graphView)
        graphView.frame = graphViewContainer.bounds
    }
    
    @IBAction func pushButtonPressed(_ button: PushButton) {
        if button.isAddButton {
            if (counterView.counter < counterView.maxNumberOfGlasses) {
                counterView.counter += 1
            }
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        
        if isGraphicViewShowing {
            containerViewTap(nil)
        }
    }

    @IBAction func containerViewTap(_ sender: Any?) {
        if (isGraphicViewShowing) {
            UIView.transition(from: graphViewContainer, to: counterView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: counterView, to: graphViewContainer, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        isGraphicViewShowing.toggle()
        setupGraphDisplay()
    }
    
    
   func setupGraphDisplay() {
    guard let graphView = graphView else {
        return
    }
    let maxDayIndex = graphView.stackView.arrangedSubviews.count - 1
     
     // 1 - Replace last day with today's actual data
     graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
     // 2 - Indicate that the graph needs to be redrawn
     graphView.setNeedsDisplay()
    graphView.maxLabel.text = "\(graphView.graphPoints.max() ?? 0)"
       
     // 3 - Calculate average from graphPoints
     let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
    graphView.averageWaterDrunk.text = "\(average)"
       
     // 4 - Setup date formatter and calendar
     let today = Date()
     let calendar = Calendar.current
       
     let formatter = DateFormatter()
     formatter.setLocalizedDateFormatFromTemplate("EEEEE")
     
     // 5 - Set up the day name labels with correct days
     for i in 0...maxDayIndex {
       if let date = calendar.date(byAdding: .day, value: -i, to: today),
          let label = graphView.stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
         label.text = formatter.string(from: date)
       }
     }
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
