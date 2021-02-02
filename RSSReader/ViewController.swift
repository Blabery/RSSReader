//
//  ViewController.swift
//  Lab_2
//
//  Created by Владислав Якубец on 28.11.2020.
//

import UIKit

class NewsVC: UIViewController, XMLParserDelegate {

    @IBOutlet weak var table: UITableView!
        
    var posts: [Post] = []
    var tempPost: Post? = nil
    var tempElement: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://lenta.ru/rss")
        let parser = XMLParser(contentsOf: url!)
        parser?.delegate = self
        parser?.parse()
        
    }
    
    private func parser(parser: XMLParser, parseErrorOccurred parseError: NSError) {
            print("parse error: \(parseError)")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        tempElement = elementName
        
        if tempElement == "item" {
            tempPost = Post(title: "", link: "", date: "")
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
                print(post.link)
                tempPost = nil
            }
        }
        
    }
    
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = posts[indexPath.row].title
        cell?.detailTextLabel?.text = posts[indexPath.row].date
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(posts[indexPath.row].link)
    }
}

