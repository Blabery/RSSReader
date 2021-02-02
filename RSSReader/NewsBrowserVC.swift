//
//  NewsBrowserVC.swift
//  Lab_2
//
//  Created by Владислав Якубец on 29.11.2020.
//

import UIKit
import WebKit

class NewsBrowserVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var completion: (() -> Void)?
    
    var urlString: String!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let normalLink = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        print(normalLink)
        if let url = URL(string: normalLink) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webView.configuration.mediaTypesRequiringUserActionForPlayback = .all
        backButton.addTarget(nil, action: #selector(back), for: .touchUpInside)
        shareButton.addTarget(nil, action: #selector(share), for: .touchUpInside)
    }
    
    @objc func share(_ sender: UIButton) {
        let normalLink = urlString.trimmingCharacters(in: (.whitespacesAndNewlines))
        if let link = URL(string: normalLink) {
            let objectsToShare = [link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @objc func back(_ sender: UIButton) {
        
        completion?()
    }
}
