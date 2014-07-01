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

class ColorCubeViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var mainImageView : UIImageView
    @IBOutlet var colorCubeSelectionColorCube : UITableView
    var currentFilter : ColorCubeFilterList
    var rawImage : UIImage { return UIImage(named: "example") }
    
    init(coder aDecoder: NSCoder!) {
        currentFilter = ColorCubeFilterList.vibrance
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func generateColorCubeWithFilterListValue(colorCubeFilterListValue  : ColorCubeFilterList) -> CIFilter {
        currentFilter = colorCubeFilterListValue
        let keyImage = UIImage(named: colorCubeFilterListValue.toRaw())
        return InstaCubeGenerator.instaCubeWithKeyImage(keyImage)
    }
    
    func filterImageWithColorCube(filter colorCubeCIFilter : CIFilter) {
        if let rawCGImage = rawImage.CGImage {
            if let ciImage = CIImage(CGImage: rawCGImage) as CIImage? {
                colorCubeCIFilter.setValue(ciImage, forKey: kCIInputImageKey)
            }
            else {
                return
            }
        }
        else {
            return
        }
        
        let outgoingImage = colorCubeCIFilter.valueForKey(kCIOutputImageKey) as CIImage
        mainImageView.image = UIImage(CIImage: outgoingImage)
    }
    
    @IBAction func imageViewWasTapped(sender : UITapGestureRecognizer) {
        if sender.state == .Ended {
            mainImageView.image = rawImage;
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return ColorCubeFilterList.allValues.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let tableViewCell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let filter = ColorCubeFilterList.allValues[indexPath.row]
        tableViewCell.textLabel.text = filter.displayName
        
        return tableViewCell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let filterListChoice = ColorCubeFilterList.allValues[indexPath.row]
        let colorCubeFilter = generateColorCubeWithFilterListValue(filterListChoice)
        filterImageWithColorCube(filter: colorCubeFilter)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

enum ColorCubeFilterList : String {
    case solarize = "colorCube_solarize"
    case vibrance = "colorCube_vibrance"
    case threshold = "colorCube_threshold"
    case warming = "colorCube_warming"
    case green = "colorCube_green"
    case moody = "colorCube_moody"
    case chrome = "colorCube_chrome"
    case posterize = "colorCube_posterize"
    case inverse = "colorCube_inverse"
    
    var displayName : String {
        switch self {
            case .solarize:
                return "Solarized"
            case .vibrance:
                return "Vibrance"
            case .threshold:
                return "Threshold"
            case .green:
                return "Green Hue"
            case .warming:
                return "Warming"
            case .moody:
                return "Moody"
            case .chrome:
                return "Chrome"
            case .posterize:
                return "Posterize"
        case .inverse:
            return "Inverse"
            default:
                return "No display name"
            }
    }
    
    static let allValues = [solarize, vibrance, threshold, green, warming, moody, chrome, posterize, inverse]
}
