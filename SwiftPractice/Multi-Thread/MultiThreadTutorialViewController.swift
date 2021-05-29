//
//  MultiThreadTutorialViewController.swift
//  SwiftPractice
//
//  Created by Yu-Chun Hsu on 2021/5/27.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import UIKit

class MultiThreadTutorialViewController: UIViewController {

    class Downloader {
        
        static let serialQueue = DispatchQueue.init(label: "com.serial.cownload.queue")
        
        static func downloadImageWithURL(_ url:String) -> UIImage! {
            let url = URL(string: url)
            let data = try? Data(contentsOf: url!)
            return UIImage(data: data!)
        }
        
        static func downloadConcurrentWithURL(_ url:String, downloadComplete: @escaping (_ image:UIImage)->()) {
            DispatchQueue.global(qos: .default).async {
                let url = URL(string: url)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                downloadComplete(image!)
            }
        }
        
        static func downloadSerialWithURL(_ url:String, downloadComplete: @escaping (_ image:UIImage)->()) {
            serialQueue.async {
                let url = URL(string: url)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                downloadComplete(image!)
            }
        }
    }
    
    let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "https://d20aeo683mqd6t.cloudfront.net/articles/title_images/000/001/209/original/s_pixta_27156582_S.jpg", "https://d20aeo683mqd6t.cloudfront.net/wp-content/uploads/2014/07/s_pixta_26225430_S.jpg", "https://d20aeo683mqd6t.cloudfront.net/wp-content/uploads/2014/07/s_33831886375_1ed1c4f1c9_z.jpg"]
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    static func instantiate() -> MultiThreadTutorialViewController
    {
        return UIStoryboard(name: "Tutorials", bundle: nil).instantiateViewController(withIdentifier: "MultiThreadTutorialViewController") as! MultiThreadTutorialViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func resetImageView() {
        self.imageView1.image = UIImage(systemName: "square.and.arrow.down")
        self.imageView2.image = UIImage(systemName: "square.and.arrow.down")
        self.imageView3.image = UIImage(systemName: "square.and.arrow.down")
        self.imageView4.image = UIImage(systemName: "square.and.arrow.down")
    }
    
    @IBAction func didClickOnStart(sender: AnyObject) {
        resetImageView()
        let img1 = Downloader.downloadImageWithURL(imageURLs[0])
        self.imageView1.image = img1
        
        let img2 = Downloader.downloadImageWithURL(imageURLs[1])
        self.imageView2.image = img2
        
        let img3 = Downloader.downloadImageWithURL(imageURLs[2])
        self.imageView3.image = img3
        
        let img4 = Downloader.downloadImageWithURL(imageURLs[3])
        self.imageView4.image = img4
        
    }
    
    @IBAction func didClickConcurrentDownload(_ sender: Any) {
        resetImageView()
        Downloader.downloadConcurrentWithURL(imageURLs[0], downloadComplete: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView1.image = image
            }
        })
        
        Downloader.downloadConcurrentWithURL(imageURLs[1], downloadComplete: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView2.image = image
            }
        })
        
        Downloader.downloadConcurrentWithURL(imageURLs[2], downloadComplete: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView3.image = image
            }
        })
        
        Downloader.downloadConcurrentWithURL(imageURLs[3], downloadComplete: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView4.image = image
            }
        })
    }
    
    @IBAction func didClickSerialDownload(_ sender: Any) {
        resetImageView()
        Downloader.downloadSerialWithURL(imageURLs[0], downloadComplete: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView1.image = image
            }
        })
        
        Downloader.downloadSerialWithURL(imageURLs[1], downloadComplete: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView2.image = image
            }
        })
        
        Downloader.downloadSerialWithURL(imageURLs[2], downloadComplete: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView3.image = image
            }
        })
        
        Downloader.downloadSerialWithURL(imageURLs[3], downloadComplete: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView4.image = image
            }
        })
    }
    
    @IBAction func resetAction(_ sender: Any) {
        resetImageView()
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        self.sliderValueLabel.text = "\(Int(sender.value * 100.0))"
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
