//
//  ShimmerView.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import UIKit

class ShimmerView: UIView {
    
    private var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShimmer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShimmer()
    }
    
    private func setupShimmer() {
        // Tạo một CAGradientLayer
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        // Cài đặt màu sắc của gradient layer
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.withAlphaComponent(0.3).cgColor,
            UIColor.clear.cgColor
        ]
        
        // Cài đặt vị trí của gradient layer
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // Thêm gradient layer vào view
        self.layer.addSublayer(gradientLayer)
        
        // Tạo animation cho shimmer
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -self.bounds.width
        animation.toValue = self.bounds.width
        animation.duration = 1.5
        animation.repeatCount = .infinity
        
        // Thêm animation vào gradient layer
        gradientLayer.add(animation, forKey: "shimmerAnimation")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}

