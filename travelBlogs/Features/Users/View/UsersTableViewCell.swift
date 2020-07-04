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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
