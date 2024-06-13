//
//  ViewController.swift
//  MyShimmer
//
//  Created by Cường Trần Quốc on 6/13/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var shimmerView: UIView!
    @IBAction func stopAnim(_ sender: Any) {
        shimmerDelegate?.clean()
    }
    
    @IBAction func restartAnim(_ sender: Any) {
        configShimmer()
    }
    
    
    private var shimmerDelegate: ShimmerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configShimmer()
        view.backgroundColor = .darkGray
    }
    
    private func configShimmer() {
        shimmerDelegate = ShimmerFactory.create(on: shimmerView)
        shimmerDelegate?.start()
    }
}

enum ShimmerFactory {
    static func create(on view: UIView) -> ShimmerDelegate{
        return MyShimmer(on: view)
    }
}

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
        let gradientLayer = createCGGradientLayer()
        let anime = createAnim()
        gradientLayer.add(anime, forKey: anime.keyPath)
        currentLayer = gradientLayer
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

