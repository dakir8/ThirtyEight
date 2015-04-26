
import MBProgressHUD

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webview: UIWebView! {
        didSet {
            if let videoUrl = self.video?.videoUrl {
                webview.delegate = self
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
        shareVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
        
        self.presentViewController(shareVC, animated: true, completion: nil)
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        MBProgressHUD.hideHUDForView(webView, animated: true)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        MBProgressHUD.showHUDAddedTo(webView, animated: true)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        MBProgressHUD.hideHUDForView(webView, animated: true)
    }
}
