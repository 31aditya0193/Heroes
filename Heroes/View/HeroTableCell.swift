//
//  HeroTableCell.swift
//  Heroes
//
//  Created by Aditya on 22/04/22.
//

import UIKit

class HeroTableCell: UITableViewCell {
    var hero : Result!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(forHero hero: Result) {
        self.heroNameLabel.text = hero.name
        self.heroImageView.layer.masksToBounds = true
        self.heroImageView.layer.cornerRadius = 5
        
        let thumbNail = hero.thumbnail
        var thumbNailPath = thumbNail.path + "." + thumbNail.thumbnailExtension
        thumbNailPath = thumbNailPath.replacingOccurrences(of: "http", with: "https")
        MvlNetworkManager.shared.fetchImage(from: thumbNailPath) { image in
            DispatchQueue.main.async {
                self.heroImageView.image = image
            }
        }
    }
}
