//
//  GradientTextButton.swift
//  GradientTextButton
//
//  Created by Ацамаз Бицоев on 22/04/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

@IBDesignable
class GradientTextButtonRounded: UIButton {
    
    
    lazy var mainCenter = CGPoint(x: self.center.x - self.frame.minX, y: self.center.y - self.frame.minY)
    let gradientColors: [UIColor] = [#colorLiteral(red: 0.3607843137, green: 0.2078431373, blue: 0.6941176471, alpha: 1),
                                     #colorLiteral(red: 0.003921568627, green: 0.6745098039, blue: 0.7568627451, alpha: 1)]
    lazy var diameter = min(self.bounds.width, self.bounds.height)
    lazy var radius = diameter / 2
    
    @IBInspectable var shouldShowGradient = true
    
    private let shadowView = UIView()
    
    
    override func draw(_ rect: CGRect) {
        
        addShadow()
        addGradientToText()
    }
    
    
    private func addGradientToText() {
        
        let view = UIView(frame: self.bounds.inset(by: UIEdgeInsets(top: 8,
                                                                    left: 8,
                                                                    bottom: 8,
                                                                    right: 8)))
        
        let gradient = CAGradientLayer()
        gradient.colors = [gradientColors[0].cgColor, gradientColors[1].cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1)
        gradient.endPoint = CGPoint(x: 1.0, y: 0)
        gradient.frame = view.bounds
        if shouldShowGradient {
            view.layer.addSublayer(gradient)
        }
        
        let label = UILabel()
        label.frame.origin = view.bounds.origin
        label.frame.size = view.bounds.size
        label.text = self.titleLabel?.text
        label.textColor = self.titleLabel?.textColor
        label.font = self.titleLabel?.font.withSize(diameter * (3/6))
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        view.addSubview(label)
        
        if shouldShowGradient {
            view.mask = label
        }
        self.setTitle("", for: .normal)
        self.addSubview(view)
    }
    
    private func addShadow() {
        
        shadowView.frame = self.bounds
        
        if shadowView.bounds.width == diameter {
            shadowView.frame = CGRect(x: shadowView.frame.minX,
                                       y: shadowView.frame.minY,
                                       width: shadowView.frame.width,
                                       height: shadowView.frame.width)
        } else {
            shadowView.frame = CGRect(x: shadowView.frame.minX,
                                       y: shadowView.frame.minY,
                                       width: shadowView.frame.height,
                                       height: shadowView.frame.height)
        }
        shadowView.center = mainCenter
        
        shadowView.layer.cornerRadius = radius
        shadowView.backgroundColor = UIColor.white
        
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowColor = gradientColors[0].cgColor
        shadowView.layer.shadowRadius = 2
        
        self.addSubview(shadowView)
    }
    
}
