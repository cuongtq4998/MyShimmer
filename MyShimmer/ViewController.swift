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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition(in: nil) { [weak self] context in
            self?.shimmerDelegate?.clean()
            self?.configShimmer()
        }
    }
    
    private func configShimmer() {
        shimmerDelegate = ShimmerFactory.create(on: shimmerView)
        shimmerDelegate?.start()
    }
}

