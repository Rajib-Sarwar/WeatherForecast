//
//  UILabel+Ext.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 4/12/22.
//

import UIKit

extension UILabel {
    func addLeading(image: UIImage, with text:String) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        
        let string = NSMutableAttributedString(string: text, attributes: [:])
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
}
