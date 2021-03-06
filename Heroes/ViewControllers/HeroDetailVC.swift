//
//  HeroDetailVC.swift
//  Heroes
//
//  Created by Aditya on 23/04/22.
//

import UIKit

class HeroDetailVC: UIViewController {
    var hero : Result!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    func setupView() {
        heroDetailLabel.text = hero.name
        let thumbNail = hero.thumbnail
        var thumbNailPath = thumbNail.path + "." + thumbNail.thumbnailExtension
        thumbNailPath = thumbNailPath.replacingOccurrences(of: "http://", with: "https://")
        MvlNetworkManager.shared.fetchImage(from: thumbNailPath) { image in
            DispatchQueue.main.async { [weak self] in
                self?.heroImageView.image = image
            }
        }
    }
}
