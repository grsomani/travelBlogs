//
//  UsersTableViewCell.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 04/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    static let reuseIdentifier = "userCell"
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLbl: UILabel!
    @IBOutlet private weak var userDesignationLbl: UILabel!
    @IBOutlet private weak var userCityLbl: UILabel!
    
    private var viewModel: UserViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2.0
    }
    
    func assign(viewModel: UserViewModel) {
        self.viewModel = viewModel
        self.updateUI()
    }
    
    private func updateUI() {
        self.updateUserImage()
        self.userNameLbl.text = self.viewModel?.userName ?? ""
        self.userDesignationLbl.text = self.viewModel?.designation ?? ""
        self.userCityLbl.text = self.viewModel?.userCity ?? ""
    }
    
    private func updateUserImage() {
        if let imageURL = self.viewModel?.userImageURL {
            self.userImageView.image = nil
            ImageFetcher().downloadImage(url: imageURL) { (image, url, _) in
                if url == imageURL {
                    self.userImageView.image = image
                }
            }
        }
    }
}
