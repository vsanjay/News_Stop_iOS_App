//
//  NewsApi.swift
//  News Stop
//
//  Created by VERDU SANJAY on 05/04/18.
//  Copyright © 2018 VERDU SANJAY. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class NewsApi{
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
     func getNews(category : String , completion : @escaping (_ data : [News],_ success : Bool) -> Void){
        
        var newsArray = [News]()
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=\(category)&apiKey=\(Constants.Key.API_KEY)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                
                completion(newsArray,false)
                
            }else{
                
                let jsonData = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                
                let articles = jsonData["articles"] as! [[String : AnyObject]]
                
                for article in articles{
                    
                    let news = News(context: self.context)
                    
                    news.newsTitle = article["title"] as! String
                    news.newsDescription = article["description"] as! String
                    news.linkToGo = article["url"] as! String
                    news.category = ""
                    newsArray.append(news)
                }
                
                
                completion(newsArray, true)
                
            }
            
        }
        
        task.resume()
        
    }
    
    
    
    class func sharedInstance() -> NewsApi {
        struct Singleton {
            static var sharedInstance = NewsApi()
        }
        return Singleton.sharedInstance
    }
    
    
}
