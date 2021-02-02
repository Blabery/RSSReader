//
//  ViewController.swift
//  Lab_2
//
//  Created by Владислав Якубец on 28.11.2020.
//

import UIKit

class NewsVC: UIViewController, XMLParserDelegate {

    @IBOutlet weak var table: UITableView!
    
    var newsCount: Int = 0
    var count: Int = 0
    var imageCount: Int = 0
    
    var sources: [Source] = []
    var posts: [Post] = []
    var tempPost: Post? = nil
    var tempElement: String?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Привет"
    }
    
    func parseDataFrom(fromURL url: String) {
        
        let url = URL(string: url)
        let parser = XMLParser(contentsOf: url!)
        parser?.delegate = self
        parser?.parse()
        
        table.reloadData()
    }
    
    private func parser(parser: XMLParser, parseErrorOccurred parseError: NSError) {
        
            print("parse error: \(parseError)")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        tempElement = elementName
        
        if tempElement == "item" {
            
            count += 1
            if  count <= newsCount {
                tempPost = Post(title: "", link: "", date: "", imageURL: "")
                
            } else {
                parser.abortParsing()
                count = 0
            }
        }
        
        if tempPost != nil && imageCount < 1{
            
            if elementName == "media:content" {
                
                guard let url = attributeDict["url"] else { return }
                tempPost?.imageURL = url
                imageCount += 1
            }
        } else {
            
            imageCount = 0
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if let post = tempPost {
            
            if tempElement == "title" {
                tempPost?.title = post.title + string
            } else if tempElement == "link" {
                tempPost?.link = post.link + string
            } else if tempElement == "pubDate" {
                tempPost?.date = post.date + string
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if let post = tempPost {
            
            if elementName == "item" {
                
                
                posts.append(post)
                
                tempPost = nil
                
            }
        }
    }
    
    @IBAction func changeSorcesList(_ sender: Any) {
        
        
        
        let sourcesVC = storyboard?.instantiateViewController(identifier: "sourcesVC") as? SourcesVC
        self.present(sourcesVC!, animated: true, completion: nil)
        
        sourcesVC!.completion = { [self] selectedSources, index in
            
            newsCount = index
            sources = selectedSources
            posts = []
            for source in sources {
                
                parseDataFrom(fromURL: source.sourceRssLink)
            }
        }
    }
}




extension NewsVC {
    
    override func viewDidAppear(_ animated: Bool) {
        
        if sources.count == 0 {
            
            if let sourcesVC = storyboard?.instantiateViewController(identifier: "sourcesVC") as? SourcesVC {
                sourcesVC.modalPresentationStyle = .fullScreen
                self.present(sourcesVC, animated: true, completion: nil)
                
                sourcesVC.completion = { [self] selectedSources, index in
                    newsCount = index
                    sources = selectedSources
                    
                }
                
            }
        } else {
            
            for source in sources {
                
                parseDataFrom(fromURL: source.sourceRssLink)
            }
        }
        
    }
}

//TABLE METHODS
extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as? NewsTableViewCell
        cell?.titleLabel.text = posts[indexPath.row].title
        cell?.pudDateLabel.text = posts[indexPath.row].date
        cell?.newsImage.image = UIImage(systemName: "house")
        
        if posts[indexPath.row].imageURL != "" {
            
            let url = URL(string: posts[indexPath.row].imageURL)
            let task = URLSession.shared.dataTask(with: url!) { (data, _, _) in
                
                guard let data = data else { return }
                
                DispatchQueue.main.sync {
                    cell?.newsImage.image = UIImage(data: data)
                }
                
            }
            task.resume()
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let destinationVC = storyboard?.instantiateViewController(identifier: "newsBrowserVC") as? NewsBrowserVC {
            
            destinationVC.urlString = posts[indexPath.row].link
            destinationVC.modalPresentationStyle = .fullScreen
            present(destinationVC, animated: true, completion: nil)
            
            destinationVC.completion = { () in
                
                destinationVC.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
}

