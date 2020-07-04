//
//  UserDetailViewController.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 04/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLbl: UILabel!
    @IBOutlet private weak var userDesignationLbl: UILabel!
    @IBOutlet private weak var userCityLbl: UILabel!
    @IBOutlet private weak var userAboutLbl: UILabel!
    
    private var userDetails: UserDataModel?
    
    class func initWithStoryboard(_ details: UserDataModel) -> UserDetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let userDetailVC = storyboard.instantiateViewController(withIdentifier: "userDetailVC") as? UserDetailViewController else {
            return nil
        }
        userDetailVC.userDetails = details
        return userDetailVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User Profile"
        self.updateUI()
    }
    
    private func updateUI() {
        guard let dataModel = self.userDetails else { return }
        
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width/2
        
        let viewModel = UserViewModel(dataModel: dataModel)
        if let imageURL = viewModel.userImageURL {
            ImageFetcher().downloadImage(url: imageURL, completion: { (image, _, _) in
                self.userImageView.image = image
            })
        }
        self.userNameLbl.text = viewModel.userName
        self.userDesignationLbl.text = viewModel.designation
        self.userCityLbl.text = viewModel.userCity
        self.userAboutLbl.text = viewModel.about
    }

}
