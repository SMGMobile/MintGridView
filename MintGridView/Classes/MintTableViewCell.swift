//
//  MintTableViewCell.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/8.
//

import UIKit
import Kingfisher



public class MintTableViewCell: MintTableViewBaseCell {
    //MARK: -
    //MARK: lifeCycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        if let iv = imageView {
            var imageViewRect = iv.frame
            imageViewRect.size.height = frame.size.height - 14
            imageViewRect.size.width = imageViewRect.size.height
            imageViewRect.origin.y = 7
            iv.frame = imageViewRect
            
            textLabel?.frame = CGRect.init(x: iv.frame.origin.x+iv.frame.size.width+10, y: iv.frame.origin.y, width: (textLabel?.frame.size.width)!, height: (textLabel?.frame.size.height)!)
        }
        textLabel?.font = UIFont.systemFont(ofSize: 16*AdaptRate)
        if let item = item {
            let url = item.imageURL
            if url.hasPrefix("http") {
                imageView?.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: url)!), placeholder: Image.init(named: Bundle.cellDefaultImageName()), options: nil, progressBlock: nil, completionHandler: nil)
            } else {
                if let image = Image.init(named: "url") {
                    imageView?.image = image
                } else {
                    imageView?.image = Image.init(named: Bundle.cellDefaultImageName())
                }
            }
            textLabel?.text = item.itemName
            
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
            unreadLabel.frame = CGRect.init(x: (imageView?.frame.origin.x)! + (imageView?.frame.size.width)! - unreadWidth, y: 1, width: unreadWidth, height: unreadHeight)
            unreadLabel.layer.cornerRadius = unreadHeight / 2
            if let view = hotCountView {
                view.removeFromSuperview()
            }
        }
        contentView.addSubview(lineLabel)
        if let view = hotCountView {
            addSubview(view)
            unreadLabel.removeFromSuperview()
        }
    }
    public override func setSelected(_ selected: Bool, animated: Bool) {
        let unreadLabelBGColor = unreadLabel.backgroundColor
        let hotCountViewBGColor = hotCountView?.backgroundColor
        super.setSelected(selected, animated: animated)
        unreadLabel.backgroundColor = unreadLabelBGColor
        hotCountView?.backgroundColor = hotCountViewBGColor
    }
    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let unreadLabelBGColor = unreadLabel.backgroundColor
        let hotCountViewBGColor = hotCountView?.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        unreadLabel.backgroundColor = unreadLabelBGColor
        hotCountView?.backgroundColor = hotCountViewBGColor
    }
    //MARK: -
    //MARK: private
    func setup() {
        addSubview(unreadLabel)
        bringSubview(toFront: unreadLabel)
        accessoryType = .disclosureIndicator
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        textLabel?.textColor = UIColor.init(white: 51/256.0, alpha: 1.0)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        detailTextLabel?.textColor = UIColor.gray
    }
    //MARK: -
    //MARK: lazyload
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
    lazy var lineLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: bounds.size.height-0.5, width: UIScreen.main.bounds.size.width, height: 0.5))
        label.backgroundColor = UIColor.init(white: 214.0/256.0, alpha: 1.0)
        return label
    }()
}
