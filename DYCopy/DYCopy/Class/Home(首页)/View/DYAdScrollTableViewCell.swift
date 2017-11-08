//
//  DYAdScrollTableViewCell.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/4/15.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit
import SDCycleScrollView

class DYAdScrollTableViewCell: UITableViewCell, SDCycleScrollViewDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        
        didSet {

            let cycleScrollView = SDCycleScrollView.init(frame: self.frame, imageNamesGroup: [UIImage.init(named: "IMG_0111")!,
                                                                                              UIImage.init(named: "IMG_0112")!,
                                                                                              UIImage.init(named: "IMG_0113")!])
            
            cycleScrollView?.frame = self.bounds
            
            cycleScrollView?.autoScrollTimeInterval = 3
            self.addSubview(cycleScrollView!)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
