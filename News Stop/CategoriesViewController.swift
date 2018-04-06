//
//  CategoriesViewController.swift
//  News Stop
//
//  Created by VERDU SANJAY on 05/04/18.
//  Copyright © 2018 VERDU SANJAY. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    var newsCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        
        let tag = sender.tag
        
        if tag == 1{
            
            newsCategory = "General"
            
        }else if tag == 2{
            
            newsCategory = "Business"
            
        }else if tag == 3{
            
            newsCategory = "Sports"
            
        }else if tag == 4{
            
            newsCategory = "Entertainment"
            
        }else {
            
            newsCategory = "Technology"
            
        }
        
        performSegue(withIdentifier: "goToNews", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! NewsViewController
        
        destinationVC.newsCategory = newsCategory
        
    }
    
    

}
