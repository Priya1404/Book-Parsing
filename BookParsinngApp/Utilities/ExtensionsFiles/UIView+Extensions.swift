//
//  UIView+Extensions.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 25/09/23.
//

import Foundation
import UIKit

extension UIView {
    
    ///Helper to show loader on the current view
    func showLoader(_ activityIndicatorStyle: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.medium,onTopOf : UIView? = nil, color : UIColor? = UIColor.blue,withYOffest : CGFloat = 0){
        var frameView = self
        if let onTopOf = onTopOf{
            frameView = onTopOf
            
        }
        if self.viewWithTag(12345) == nil{
            //Make sure multiple activityIndicators are not added to the same UIActivityIndicatorView.Style.medium
            self.isUserInteractionEnabled = false
            let activityIndicator = UIActivityIndicatorView(style: activityIndicatorStyle)
            activityIndicator.tag = 12345
            activityIndicator.frame = CGRect(x: frameView.frame.origin.x + frameView.frame.size.width/2 - 13,y: frameView.frame.origin.y +  frameView.frame.size.height/2 - 13 + withYOffest, width: 26, height: 26)
            self.addSubview(activityIndicator)
            activityIndicator.color = color
            activityIndicator.startAnimating()
        }
    }
    
    //Helper to dismiss the loader on the current view
    func dismissloader(){
        self.isUserInteractionEnabled = true
        if let activityIndicator = self.viewWithTag(12345) as? UIActivityIndicatorView{
            activityIndicator.removeFromSuperview()
        }
    }
}
