//
//  RaceConditionViewController.swift
//  SwiftPractice
//
//  Created by Yu-Chun Hsu on 2021/5/29.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit

class RaceConditionViewController: UIViewController {

    @IBOutlet weak var logvView: UILabel!
    
    var array:[NSInteger] = []
    var logContent: [NSString] = []
    
    static func instantiate() -> RaceConditionViewController
    {
        return UIStoryboard(name: "Tutorials", bundle: nil).instantiateViewController(withIdentifier: "RaceConditionViewController") as! RaceConditionViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func updateLabel() {
        var text = ""
        for value in array {
            text.append(String(value))
            text.append(" ,")
        }
        DispatchQueue.main.async {
            self.logvView.text = text
        }
    }
    
    func resetLabel() {
        self.array.removeAll()
    }
    
    @IBAction func appendWithoutSemaphore(_ sender: Any) {
        self.array.removeAll()
        let start = DispatchTime.now() // <<<<<<<<<< Start time
       
        for i in 0..<5000 {
            self.array.append(i)
        }
        let end = DispatchTime.now()   // <<<<<<<<<<   end time
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
        self.logvView.text = "take \(timeInterval) seconds, count = \(self.array.count) \n\narray = \(self.array)"
    }
    
    @IBAction func appendWithSemaphore(_ sender: Any) {
        self.array.removeAll()
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let semaphore = DispatchSemaphore(value: 1)
        let queue = DispatchQueue.global()
        for i in 0..<5000 {
            queue.async {
                if semaphore.wait(timeout: .distantFuture) == .success {
                    self.array.append(i)
                    semaphore.signal()
                }
            }
        }
        let end = DispatchTime.now()   // <<<<<<<<<<   end time
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
        self.logvView.text = "take \(timeInterval) seconds, count = \(self.array.count) \n\narray = \(self.array)"
    }
    
    @IBAction func append(_ sender: Any) {
        self.array.removeAll()
        let start = DispatchTime.now() // <<<<<<<<<< Start time
      
        let queue = DispatchQueue.main
        for i in 0..<5000 {
            queue.async {
             
                    self.array.append(i)
                  
            }
        }
        let end = DispatchTime.now()   // <<<<<<<<<<   end time
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
        self.logvView.text = "take \(timeInterval) seconds, count = \(self.array.count) \n\narray = \(self.array)"
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


