//
//  SegmentedCell.swift
//  Yelp
//
//  Created by Lam Hieu on 3/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SegmentedCellDelegate {
    optional func segmentedCell(segmentedCell: SegmentedCell, didChangeValue value: Int)
}

class SegmentedCell: UITableViewCell {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    weak var delegate: SegmentedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        segmentedControl.addTarget(self, action: "segmentedValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func segmentedValueChanged() {
        
        delegate?.segmentedCell?(self, didChangeValue: segmentedControl.selectedSegmentIndex)
    }
}
