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
    
    init(coder aDecoder: NSCoder!) {
        currentFilter = ColorCubeFilterList.vibrance
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func generateColorCubeWithFilterList(colorCubeFilter  : ColorCubeFilterList) -> CIFilter {
        currentFilter = colorCubeFilter
        let keyImage = UIImage(named: colorCubeFilter.toRaw())
        return InstaCubeGenerator.instaCubeWithKeyImage(keyImage)
    }
    
    func filterImageWithColorCube(colorCubeFilter : CIFilter) {

        let rawImage = UIImage(named: "example").CGImage
        if let checkedRawImage = rawImage {
            if let ciImage = CIImage(CGImage: checkedRawImage) as CIImage? {
                colorCubeFilter.setValue(ciImage, forKey: kCIInputImageKey)
            }
            else {
                return
            }
        }
        else {
            return
        }
        
        let outgoingImage = colorCubeFilter.valueForKey(kCIOutputImageKey) as CIImage
        mainImageView.image = UIImage(CIImage: outgoingImage)
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
        let filter = ColorCubeFilterList.allValues[indexPath.row]
        let colorCubeFilter = generateColorCubeWithFilterList(filter)
        filterImageWithColorCube(colorCubeFilter)
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
            default:
                return "No display name"
            }
    }
    
    static let allValues = [solarize, vibrance, threshold, green, warming, moody]
}
