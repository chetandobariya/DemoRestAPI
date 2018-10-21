//
//  TableViewCell.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullname: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let separatorPadding = CGFloat(15.0)
        self.separatorInset = UIEdgeInsets(top: 0.0, left: separatorPadding, bottom: 0.0, right: separatorPadding)
        
        self.selectionStyle = .none
      
    }
    
    func setup(with repositoryItems: Repositories) {
        
        self.username.text = repositoryItems.name
        self.fullname.text = repositoryItems.fullName
        self.username.font = UIFont.futuraMediumOf(size: 18.0)
        self.loadImage(imageURL:repositoryItems.owner?.avatarUrl)
    }
    
    private func loadImage(imageURL:URL?){
        
        guard  let requestURL = imageURL else {
            return
        }
        self.userProfile.af_setImage(withURL: requestURL, placeholderImage: Assets.user.image)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
