import UIKit

class CapsuleButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setupView()
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        if let buttonColor = UIColor(named: "ButtonColor") {
            backgroundColor = buttonColor
        }
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
