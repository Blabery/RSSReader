//
//  SourcesVC.swift
//  Lab_2
//
//  Created by Владислав Якубец on 28.11.2020.
//

import UIKit

class SourcesVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    public var completion: (([Source]) -> Void)?
    
    var selectedSourcesCount: Int = 0
    
    var sourcesList: [Source] = []
    var selectedSourcesList: [Source] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourcesList.append(Source(sourceName: "Tut.by", sourceRssLink: "https://news.tut.by/rss/all.rss"))
        sourcesList.append(Source(sourceName: "Lenta.ru", sourceRssLink: "https://lenta.ru/rss"))
        sourcesList.append(Source(sourceName: "Meduza.io", sourceRssLink: "https://meduza.io/rss2/all"))
        sourcesList.append(Source(sourceName: "The New York Times", sourceRssLink: "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml"))
        
        sourcesList.append(Source(sourceName: "BBC", sourceRssLink: "http://feeds.bbci.co.uk/news/world/rss.xml"))
        sourcesList.append(Source(sourceName: "Euronews", sourceRssLink: "http://feeds.feedburner.com/euronews/en/home/"))
        
        table.dataSource = self
        table.delegate = self
        
        table.allowsMultipleSelection = true
        
        
    }
    
    @IBAction func complete() {
        
        if let selectedCount = table.indexPathsForSelectedRows {
            for indexPath in selectedCount {
                selectedSourcesList.append(sourcesList[indexPath.row])
            }
            completion?(selectedSourcesList)
            
            self.dismiss(animated: true, completion: nil)
        }
        else {

            let alert = UIAlertController(title: "", message: "Выберите хотя бы один источник", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension SourcesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sourcesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "sourceCell")
        cell?.textLabel?.text = sourcesList[indexPath.row].sourceName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if let sr = tableView.indexPathsForSelectedRows {
            if sr.count == 3 {
                let alert = UIAlertController(title: "", message: "Максимальное количество источников – 3", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return nil
            }
        }
        return indexPath
    }
}
