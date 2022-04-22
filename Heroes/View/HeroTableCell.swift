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
        guard let url = URL(string: imageUrl) else {
            print("Invalid Image Path")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { result,_,_  in
            let image = UIImage(data: result!)
            DispatchQueue.main.async {
                self.heroImage.image = image
            }
        }).resume()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
