//
//  ViewSettings.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class ViewSettings {
    //MARK: - Colors
    let darkBackgroundColor: UIColor
    let lightBackgroundColor: UIColor
    
    let headerTextColor: UIColor
    let darkTextColor: UIColor
    let lightTextColor: UIColor
    
    let shadowColor: UIColor
    
    //MARK: - Fonts
    let titleFont: UIFont
    
    let headerFont: UIFont
    let smallHeaderFont: UIFont
    
    let contentFont: UIFont
    let smallContentFont: UIFont
    
    //MARK: - Layout Constants
    let conteinerSpaceConstant: CGFloat
    let innerContainerSpaceConstant: CGFloat
    
    let navigationButtonHeightConstant: CGFloat = 44.0
    let navigationButtonWidthConstant: CGFloat = 44.0
    
    let buttonHeightConstant: CGFloat = 44.0
    let viewHeightConstant: CGFloat = 44.0
    
    let restaurantItemRowHeightConstant: CGFloat
    let menuItemRowHeightConstant: CGFloat
    let cartItemRowHeightConstant: CGFloat
    let headerTitleHeightConstant: CGFloat = 34.0
    
    //MARK: - Layer Corner Radius
    let buttonCornerRadius: CGFloat = 16.0
    let viewCornerRadius: CGFloat = 16.0
    
    //MARK: - Shadows
    let shadowRadius: CGFloat = 16.0
    
    //MARK: - System Layout Margins
    let statusBarHeightMargine: CGFloat = 44.0
    let navigationBarHeightMargine: CGFloat = 44.0
    let homeIndicatorHeightMargine: CGFloat = 34.0
    
    var backgroundColor = UIColor()
    var fourthColor = UIColor()
    var secondColor = UIColor()
    
    //MARK: - Custom Init
    init(darkColor: UIColor,
         medLightColor: UIColor,
         lightColor: UIColor,
         layoutMargine: CGFloat,
         innerMargin: CGFloat,
         titleFont: UIFont,
         headerFont: UIFont,
         smallHeaderFont: UIFont,
         contentFont: UIFont,
         smallContentFont: UIFont,
         restaurantItemHeight: CGFloat,
         cartItemHeight: CGFloat,
         menuItemHeight: CGFloat) {
        
        darkBackgroundColor = darkColor
        lightBackgroundColor = medLightColor
        headerTextColor = darkColor
        darkTextColor = medLightColor
        lightTextColor = lightColor
        shadowColor = .black
        
        conteinerSpaceConstant = layoutMargine
        innerContainerSpaceConstant = innerMargin
        
        self.titleFont = titleFont
        self.headerFont = headerFont
        self.smallHeaderFont = smallHeaderFont
        self.contentFont = contentFont
        self.smallContentFont = smallContentFont
        
        restaurantItemRowHeightConstant = restaurantItemHeight
        cartItemRowHeightConstant = cartItemHeight
        menuItemRowHeightConstant = menuItemHeight
    }
    
    //MARK: - Default Init
    init() {
        darkBackgroundColor = UIColor(red: 0.23, green: 0.07, blue: 0.0, alpha: 1.0)
        lightBackgroundColor = UIColor(red: 0.52, green: 0.32, blue: 0.2, alpha: 1.0)
        headerTextColor = UIColor(red: 0.23, green: 0.07, blue: 0.0, alpha: 1.0)
        darkTextColor = UIColor(red: 0.52, green: 0.32, blue: 0.2, alpha: 1.0)
        lightTextColor = UIColor(red: 0.97, green: 0.92, blue: 0.83, alpha: 1.0)
        shadowColor = .black
        
        backgroundColor = darkBackgroundColor
        fourthColor = lightBackgroundColor
        secondColor = lightTextColor
        
        conteinerSpaceConstant = 16.0
        innerContainerSpaceConstant = 8.0
        
        self.titleFont = UIFont(name: "RUSIJA-01", size: 64.0)!
        self.headerFont = UIFont(name: "Rockwell-Bold", size: 34.0)!
        self.smallHeaderFont = UIFont(name: "Rockwell-Bold", size: 20.0)!
        self.contentFont = UIFont(name: "Rockwell", size: 16.0)!
        self.smallContentFont = UIFont(name: "Rockwell", size: 12.0)!
        
        restaurantItemRowHeightConstant = 264.0
        cartItemRowHeightConstant = 132.0
        menuItemRowHeightConstant = 44.0
    }
}
