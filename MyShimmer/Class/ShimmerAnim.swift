//
//  ShimmerAnim.swift
//  MyShimmer
//
//  Created by Cường Trần Quốc on 6/13/24.
//

import UIKit
protocol ShimmerDelegate: AnyObject {
    func start()
    func clean()
}

final class MyShimmer: ShimmerDelegate {
    struct GradientColor {
        static let gradientColorOne : CGColor = UIColor(white: 0.75, alpha: 1.0).cgColor
        static let gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
    }
    
    let currentView: UIView
    private var currentLayer: CAGradientLayer?
    init(on view: UIView) {
        self.currentView = view
    }
    
    func start() {
        DispatchQueue.main.async {
            let gradientLayer = self.createCGGradientLayer()
            let anime =  self.createAnim()
            gradientLayer.add(anime, forKey: anime.keyPath)
            self.currentLayer = gradientLayer
        }
    }
    
    func clean() {
        currentLayer?.removeAnimation(forKey: "locations")
    }
    
    private func createCGGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = currentView.bounds
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [
            GradientColor.gradientColorOne,
            GradientColor.gradientColorTwo,
            GradientColor.gradientColorOne
        ]
        
        gradientLayer.locations = [0,0.5,1]
        currentView.layer.addSublayer(gradientLayer)
        return gradientLayer
    }
    
    fileprivate func createAnim() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1, -0.5, 0]
        animation.toValue = [1, 1.5, 2]
        animation.repeatCount = .infinity
        animation.duration = 0.9
        return animation
    }
}
