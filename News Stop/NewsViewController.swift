//
//  NewsViewController.swift
//  News Stop
//
//  Created by VERDU SANJAY on 05/04/18.
//  Copyright © 2018 VERDU SANJAY. All rights reserved.
//

import UIKit
import CoreData

class NewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var allNews = [News]()
    
    var newsCategory = ""
    
    var kindOfNews = ["General" : "bbc-news","Business":"bloomberg","Sports":"bbc-sport","Entertainment":"mtv-news","Technology":"techcrunch"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableVideDelegate()
        
        loadData()
        
        myNavigationBar.topItem?.title = newsCategory
        
        
    }
    
    //Hide status bar
    override var prefersStatusBarHidden: Bool{
        
        return true
        
    }
    
    //refresh button tapped
    @IBAction func refreshButtonTapped(_ sender: Any) {
        
        SwiftSpinner.show("Getting News")
        
        for news in allNews{
            
            context.delete(news)
            
        }
        
        save()
        
        allNews = []
        
        myTableView.reloadData()
        
        getNews()
        
    }
    
    func setTableVideDelegate(){
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allNews.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "newscell") as! CustomCell
        
        cell.newsTitle.text = allNews[indexPath.row].newsTitle
        cell.newsDescription.text = allNews[indexPath.row].newsDescription
        cell.linkToGo = allNews[indexPath.row].linkToGo!
        
        return cell
        
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func getNews(){
        
        SwiftSpinner.show("Getting News")
        
        NewsApi.sharedInstance().getNews(category: kindOfNews[newsCategory]!) { (newsArray, success) in
            
            if success{
                
                SwiftSpinner.hide()
                
                self.allNews = newsArray
                
                for news in self.allNews{
                    
                    news.category = self.newsCategory
                    
                }
                
                self.save()
                
                DispatchQueue.main.async {
                    
                    self.myTableView.reloadData()
                    
                }
                
            }else{
                
                self.showAlert(message: "Check Your Internet Connection")
                
                SwiftSpinner.hide()
                
            }
            
        }
        
    }
    
    func showAlert(message : String){
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func save(){
        
        do{
            
            try context.save()
            
        }catch{
            
            print(error)
        }
        
        
    }
    
    func loadData(){
        
        let request : NSFetchRequest<News> = News.fetchRequest()
        
        let predicate = NSPredicate(format: "category == %@", newsCategory)
        
        request.predicate = predicate
        
        do{
            
            allNews = try context.fetch(request)
            
            if allNews.count > 0 {
                
                showSavedData()
                
            }else{
                
                getNews()
                
            }
            
        }catch{}
        
    }
    
    func showSavedData(){
        
        myTableView.reloadData()
        
    }
    
    
    
}
