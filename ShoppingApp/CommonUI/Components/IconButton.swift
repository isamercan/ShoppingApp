//
//  IconButton.swift
//  ShoppingApp
//
//  Created by isa on 26.02.2023.
//
import UIKit

enum IconSizes {
    case small, medium, large
}

final class IconButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialUI()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialUI()
    }
    
    override internal func awakeFromNib() {
        super.awakeFromNib()
        initialUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initialUI()
    }

    func initialUI(){
        setupInterface()
    }
    
    func iconButton (icon: String,
                     iconColor: UIColor = .black,
                     setBackgroundColor: UIColor = UIColor.white,
                     size: IconSizes = .medium) {
        setImage(UIImage(named: icon)?.withRenderingMode(.alwaysTemplate), for: .normal)
        tintColor = iconColor
        backgroundColor = setBackgroundColor
        setTitle(String(), for: .normal)
        titleLabel?.isHidden = true
        
        switch size {
        case .small:
            imageView?.widthAnchor.constraint(equalToConstant: StyleConstants.Size.medium).isActive = true
            imageView?.heightAnchor.constraint(equalToConstant: StyleConstants.Size.medium).isActive = true
        case . medium:
            imageView?.widthAnchor.constraint(equalToConstant: StyleConstants.Size.large).isActive = true
            imageView?.heightAnchor.constraint(equalToConstant: StyleConstants.Size.large).isActive = true
        case .large:
            imageView?.widthAnchor.constraint(equalToConstant: StyleConstants.Size.xLarge).isActive = true
            imageView?.heightAnchor.constraint(equalToConstant: StyleConstants.Size.xLarge).isActive = true
        }
    }
    
    private func setupInterface() {
        clipsToBounds = true
        layer.cornerRadius = layer.frame.height/2
        layer.masksToBounds = true
        imageView?.contentMode = .scaleAspectFit
        
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        imageView?.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        imageView?.widthAnchor.constraint(equalToConstant: StyleConstants.Size.large).isActive = true
        imageView?.heightAnchor.constraint(equalToConstant: StyleConstants.Size.large).isActive = true
        setShadowLayer()
    }
    
    private func setShadowLayer() {
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 3.0
        layer.masksToBounds = false
    }
}
