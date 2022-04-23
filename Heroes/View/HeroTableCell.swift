//
//  HeroTableCell.swift
//  Heroes
//
//  Created by Aditya on 22/04/22.
//

import UIKit

class HeroTableCell: UITableViewCell {
    var hero : Result!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(forHero hero: Result) {
        self.heroNameLabel.text = hero.name
        self.heroImage.layer.masksToBounds = true
        self.heroImage.layer.cornerRadius = 5
        
        let thumbNail = hero.thumbnail
        var thumbNailPath = thumbNail.path + "." + thumbNail.thumbnailExtension
        thumbNailPath = thumbNailPath.replacingOccurrences(of: "http", with: "https")
        NetworkManager.shared.fetchImage(from: thumbNailPath) { image in
            DispatchQueue.main.async {
                self.heroImage.image = image
            }
        }
    }
}
