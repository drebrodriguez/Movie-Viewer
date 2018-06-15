//
//  CustomNavigationController.swift
//  movie-viewer
//
//  Created by Dreb Rodriguez on 14/06/2018.
//  Copyright © 2018 Dreb Rodriguez. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.Custom.freeSpeechBlue
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}
