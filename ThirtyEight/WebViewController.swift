//
//  WebViewController.swift
//  ThirtyEight
//
//  Created by 邱建平 on 15/4/19.
//  Copyright (c) 2015年 daniel. All rights reserved.
//

class WebViewController: UIViewController {
    
    @IBOutlet weak var webview: UIWebView! {
        didSet {
            if let videoUrl = self.video?.videoUrl {
                webview.loadRequest(NSURLRequest(URL: NSURL(string: videoUrl)!))
            }
            
        }
    }
    
    var video: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareAction"), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareAction() {
        println("shareAction(): url = \(self.video?.videoUrl)")
        
        let title = self.video!.name
        let url = NSURL(string: self.video!.videoUrl!)
        
        let shareVC = UIActivityViewController(activityItems: [title!, url!], applicationActivities: nil)
        
        self.presentViewController(shareVC, animated: true, completion: nil)
    }

}
