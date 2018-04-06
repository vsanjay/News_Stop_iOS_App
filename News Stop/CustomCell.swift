//
//  CustomCell.swift
//  News Stop
//
//  Created by VERDU SANJAY on 05/04/18.
//  Copyright © 2018 VERDU SANJAY. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    
    
    var linkToGo = ""
    
    
    @IBAction func linkButtonTapped(_ sender: Any) {
        
        if let url = URL(string: linkToGo) {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    
}
