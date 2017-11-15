//
//  MintCollectionViewCell.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/9.
//

import UIKit
import Kingfisher

public class MintCollectionViewCell: MintCollectionViewBaseCell {
    
    override var cellSelectedColor: UIColor? {
        didSet {
            selectedBackgroundView?.backgroundColor = cellSelectedColor
        }
    }
    override var cellFontColor: UIColor? {
        didSet {
            nameLabel.textColor = cellFontColor
        }
    }
    //MARK: -
    //MARK: public
    override public func emptyData() {
        super.emptyData()
        iconImageView.image = nil
        iconImageView.frame = CGRect()
        nameLabel.text = ""
        unreadLabel.text = ""
        unreadLabel.frame = CGRect()
    }
    //MARK: -
    //MARK: lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(unreadLabel)
        backgroundColor = UIColor.white
        selectedBackgroundView = UIView.init()
        selectedBackgroundView?.backgroundColor = UIColor.init(white: kSelectedTextColor, alpha: 1.0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        selectedBackgroundView?.frame = bounds
        if let item = item {
            var imageWidth = kStdImageSizeWidth * scale
            var imageHeight = kStdImageSizeHeight * scale
            if imageSize.width > 0 && imageSize.height > 0 {
                imageWidth = imageSize.width * scale
                imageHeight = imageSize.height * scale
            }
            let imageOriginX = (bounds.size.width - imageWidth) / 2
            let imageOriginY = (bounds.size.height - imageHeight) / 3
            iconImageView.frame = CGRect.init(x: imageOriginX, y: imageOriginY, width: imageWidth, height: imageHeight)
            
            let url = item.imageURL
            if url.hasPrefix("http") {
                iconImageView.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: url)!), placeholder: Image.init(named: Bundle.cellDefaultImageName()), options: nil, progressBlock: nil, completionHandler: nil)
            } else {
                if let image = Image.init(named: "url") {
                    iconImageView.image = image
                } else {
                    iconImageView.image = Image.init(named: Bundle.cellDefaultImageName())
                }
            }
            
            var fontSize = 16 * scale
            if fontSize < 12 {
                fontSize = 12
            } else if fontSize > 18 {
                fontSize = 18
            }
            nameLabel.font = UIFont.systemFont(ofSize: fontSize)
            nameLabel.text = item.itemName
            nameLabel.numberOfLines = 2
            let lbMaxWidth = bounds.size.width - 20
            nameLabel.frame = CGRect.init(x: 0, y: 0, width: lbMaxWidth, height: 0)
            nameLabel.sizeToFit()
            
            var lbOriginX:CGFloat = 0.0
            var lbOriginY:CGFloat = 0.0
            let lbWidth = nameLabel.frame.width < lbMaxWidth ? nameLabel.frame.width : lbMaxWidth
            let lbHeight = nameLabel.frame.height
            lbOriginX = (bounds.width - lbWidth) / 2
            lbOriginY = imageOriginY + imageHeight + 4
            nameLabel.frame = CGRect.init(x: lbOriginX, y: lbOriginY, width: lbWidth, height: lbHeight)
            
            var unreadWidth: CGFloat = 0
            var unreadHeight: CGFloat = 0
            var unreadText = ""
            if hotCount>0 {
                if showWay == .dot {
                    unreadWidth = kUnreadWidth - 4
                    unreadHeight = unreadWidth
                } else {
                    unreadHeight = kUnreadWidth
                    if hotCount < 10 {
                        unreadText = "\(hotCount)"
                        unreadWidth = kUnreadWidth;
                    } else if hotCount > 99 {
                        unreadText = "99+"
                        unreadWidth = kUnreadWidth + kUnreadOffset*2
                    } else {
                        unreadText = "\(hotCount)"
                        unreadWidth = kUnreadWidth + kUnreadOffset
                    }
                }
            }
            unreadLabel.text = unreadText
            unreadLabel.frame = CGRect.init(x: iconImageView.frame.maxX-unreadWidth/2, y: iconImageView.frame.minY-unreadHeight/2, width: unreadWidth, height: unreadHeight)
            unreadLabel.layer.cornerRadius = unreadHeight / 2
            unreadLabel.layer.masksToBounds = true
            if (hotCountView != nil) {
                hotCountView?.removeFromSuperview()
            }
        }
        if (hotCountView != nil) {
            addSubview(hotCountView!)
            unreadLabel.removeFromSuperview()
        }
    }
    //MARK: -
    //MARK: lazyload
    lazy var iconImageView: UIImageView = {
        let iv = UIImageView.init(frame: CGRect())
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel.init(frame: CGRect())
        label.textAlignment = .center
        label.textColor = UIColor.init(white: kMainTextColor, alpha: 1.0)
        return label
    }()
    lazy var unreadLabel: UILabel = {
        let label = UILabel.init(frame: CGRect())
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        label.layer.cornerRadius = kUnreadWidth / 2
        label.layer.masksToBounds = true
        return label
    }()
}
