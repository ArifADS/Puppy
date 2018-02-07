//
//  ResultCell.swift
//  Puppy
//
//  Created by Arif De Sousa on 2/7/18.
//  Copyright © 2018 arifads. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var ingredientsStack: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    var model: QueryResult! {
        didSet{ build() }
    }
    
    override func prepareForReuse() {
        ingredientsStack.arrangedSubviews.forEach{ view in
            self.ingredientsStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        thumbnailImageView.image = nil
    }
    
    
    func build() {
        titleLabel.text = model.title
        let ingredients = model.ingredients.components(separatedBy: ",")
        .map{  $0.trimmingCharacters(in: .whitespaces) }
        
        
        ingredients.forEach{ text in
            let label = UILabel()
            label.text = "* " + text
            label.numberOfLines = 0
            
            self.ingredientsStack.addArrangedSubview(label)
        }
        
        API.downloadImage(href: model.thumbnail)
        .then{ data -> Void in
            print(self.model.thumbnail)
            self.thumbnailImageView.image = UIImage(data: data)
        }
    }
}
