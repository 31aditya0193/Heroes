//
//  HeroTableCell.swift
//  Heroes
//
//  Created by Aditya on 22/04/22.
//

import UIKit

class HeroTableCell: UITableViewCell {
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name: String, withImage imageUrl: String) {
        self.heroNameLabel.text = name
        self.heroImage.layer.masksToBounds = true
        self.heroImage.layer.cornerRadius = 5
        NetworkManager.shared.fetchImage(from: imageUrl) { image in
            DispatchQueue.main.async {
                self.heroImage.image = image
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
