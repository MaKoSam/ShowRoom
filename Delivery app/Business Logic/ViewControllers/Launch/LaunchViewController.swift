//
//  LaunchViewController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class LaunchViewController: UIViewController {
    //MARK: - Subviews
    var playerView = PlayerView()
    var headlineImage = UIImageView()
    var headlineLabel = UILabel()
    
    var activityIndicator = UIActivityIndicatorView()
    
    //MARK: - Properties
    var videoPlayer: VideoPlayer?
    var constraints = [NSLayoutConstraint]()
    
    var launchManager = LaunchManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLayoutConstraint.activate(constraints)
        playerView.player?.play()
        activityIndicator.startAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let timeNow = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: timeNow + .seconds(3)) {
            self.presentHeadling()
        }
        completeLaunchProcedures {
            DispatchQueue.main.asyncAfter(deadline: timeNow + .seconds(5)){
                self.navigateToShop()
            }
        }
    }
    
    private func presentHeadling() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 3.0) {
                self.headlineImage.alpha = 1.0
                self.headlineLabel.alpha = 1.0
                self.activityIndicator.alpha = 1.0
            }
        }
    }
}

extension LaunchViewController {
    private func navigateToShop() {
        DispatchQueue.main.async {
            AppDelegate.shared.rootViewController.navigateToShopBranch()
        }
    }
}

extension LaunchViewController {
    private func completeLaunchProcedures(completionHandler: @escaping () -> Void) {
        launchManager.configureShop {
            completionHandler()
        }
        launchManager.configureUser()
    }
}
