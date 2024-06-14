//
//  ShimmerFactory.swift
//  MyShimmer
//
//  Created by Cường Trần Quốc on 6/13/24.
//

import UIKit
enum ShimmerFactory {
    static func create(on view: UIView) -> ShimmerDelegate{
        return MyShimmer(on: view)
    }
}
