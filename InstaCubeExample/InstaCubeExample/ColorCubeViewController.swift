//
//  ColorCubeViewController.swift
//  InstaCubeExample
//
//  Created by mrJacob on 6/15/14.
//  Copyright (c) 2014 sushiGrass. All rights reserved.
//

import Foundation
import UIKit
import CoreImage
import InstaCube

class ColorCubeViewController : UIViewController {
    
    @IBOutlet var mainImageView : UIImageView
    var mainColorCubeFilter : CIFilter
    var currentFilter : ColorCubeFilterList
    
    init(coder aDecoder: NSCoder!) {
        currentFilter = ColorCubeFilterList.vibrance
        let keyImage = UIImage(named: currentFilter.toRaw())
        mainColorCubeFilter = InstaCubeGenerator.instaCubeWithKeyImage(keyImage)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionButtonWasTapped(sender : UIButton) {
        let incomingImage = CIImage(CGImage: self.mainImageView.image.CGImage)
        mainColorCubeFilter.setValue(incomingImage, forKey: kCIInputImageKey)
        let outgoingImage = mainColorCubeFilter.valueForKey(kCIOutputImageKey) as CIImage
        mainImageView.image = UIImage(CIImage: outgoingImage)
    }
}

enum ColorCubeFilterList : String {
    case solarize = "colorCube_solarize"
    case vibrance = "colorCube_vibrance"
    case threshold = "colorCube_threshold"
    
    static let allValues = [solarize, vibrance, threshold]
}
