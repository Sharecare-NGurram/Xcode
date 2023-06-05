//
//  CircularLabel.swift
//  WHE
//
//  Created by Pratima Pundalik on 17/01/23.
//
import UIKit

class CircleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("pressed")
    }
    override func layoutSubviews() {
      super.layoutSubviews()
        self.frame.size = CGSize(width: 29, height: 29)
      self.layer.cornerRadius = self.frame.size.width/2
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        let size:CGFloat = 35.0
        self.text = "5"
        self.textColor = AnthemColor.enabledDateTextColor
        self.textAlignment = .center
        self.font = UIFont.semiBold(ofSize: 15)
        self.layer.masksToBounds = true
        self.bounds = CGRectMake(0.0, 0.0, size, size)
        self.layer.borderWidth = 4.0
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.borderColor = AnthemColor.circleBorderColor.cgColor
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 29, height: 29)
    }
}
