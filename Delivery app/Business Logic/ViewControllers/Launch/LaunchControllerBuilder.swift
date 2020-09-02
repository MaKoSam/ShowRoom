//
//  LaunchControllerBuilder.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class LaunchControllerBuilder {
    private let viewSettings: ViewSettings
    private let controller: LaunchViewController
    
    init() {
        viewSettings = Session.shared.viewSettings
        controller = LaunchViewController()
    }
    
    func buildController() -> LaunchViewController {
        addViews()
        configureConstraints()
        configureViews()
        configureVideo()
        return controller
    }
    
    private func addViews() {
        controller.playerView.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.playerView)
        
        controller.headlineImage.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.headlineImage)
        
        controller.headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.headlineLabel)
        
        controller.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.activityIndicator)
    }
    
    private func configureConstraints() {
        controller.constraints = [
            controller.playerView.topAnchor.constraint(equalTo: controller.view.topAnchor),
            controller.playerView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            controller.playerView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            controller.playerView.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor),
            
            controller.headlineImage.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor,
                                                              constant: -150.0),
            controller.headlineImage.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            controller.headlineImage.heightAnchor.constraint(equalToConstant: 200.0),
            controller.headlineImage.widthAnchor.constraint(equalToConstant: 200.0),
            
            controller.headlineLabel.topAnchor.constraint(equalTo: controller.headlineImage.bottomAnchor,
                                                          constant: 20.0),
            controller.headlineLabel.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor,
                                                              constant: viewSettings.conteinerSpaceConstant),
            controller.headlineLabel.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor,
                                                               constant: -viewSettings.conteinerSpaceConstant),
            
            controller.activityIndicator.topAnchor.constraint(equalTo: controller.headlineLabel.bottomAnchor,
                                                              constant: viewSettings.conteinerSpaceConstant),
            controller.activityIndicator.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor)
        ]
    }
    
    
    private func configureViews() {
        controller.headlineImage.alpha = 0.0
        controller.headlineImage.image = UIImage(named: "logo.png")
        
        controller.headlineLabel.textAlignment = .center
        controller.headlineLabel.alpha = 0.0
        controller.headlineLabel.font = viewSettings.titleFont
        controller.headlineLabel.textColor = .white
        controller.headlineLabel.addCharacterSpacing(kernValue: 5.0)
        controller.headlineLabel.text = "app_title".localized()
        
        controller.activityIndicator.alpha = 0.0
        controller.activityIndicator.style = .large
        controller.activityIndicator.hidesWhenStopped = true
    }
    
    private func configureVideo() {
        guard let path = Bundle.main.path(forResource: "SesonyAppVideo", ofType: "mp4") else {
            return
        }
        let videoURL = NSURL(fileURLWithPath: path)
        controller.videoPlayer = VideoPlayer(urlAsset: videoURL, view: controller.playerView)
    }
}
