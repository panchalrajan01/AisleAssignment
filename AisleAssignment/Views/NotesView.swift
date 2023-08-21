import UIKit

class NotesView: UIView {
    
    private lazy var tabTopLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal messages to you"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var userInfoSectionView: UserInfoSectionView = {
        let myView = UserInfoSectionView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private lazy var upgradeSectionView: UpgradeSectionView = {
        let myView = UpgradeSectionView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    public lazy var moreProfilesSectionView: MoreProfilesSectionView = {
        let myView = MoreProfilesSectionView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
        setupConstraints()
        setupEventHandlers()
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tabTopLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(userInfoSectionView)
        contentView.addSubview(upgradeSectionView)
        contentView.addSubview(moreProfilesSectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                        
            tabTopLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 53),
            tabTopLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            secondaryLabel.topAnchor.constraint(equalTo: tabTopLabel.bottomAnchor, constant: 8),
            secondaryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            userInfoSectionView.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: 15),
            userInfoSectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userInfoSectionView.widthAnchor.constraint(equalToConstant: 344),
            userInfoSectionView.heightAnchor.constraint(equalToConstant: 344),
            
            upgradeSectionView.topAnchor.constraint(equalTo: userInfoSectionView.bottomAnchor, constant: 15),
            upgradeSectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            upgradeSectionView.widthAnchor.constraint(equalToConstant: 344),
            upgradeSectionView.heightAnchor.constraint(equalToConstant: 70),
            
            moreProfilesSectionView.topAnchor.constraint(equalTo: upgradeSectionView.bottomAnchor, constant: 15),
            moreProfilesSectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            moreProfilesSectionView.widthAnchor.constraint(equalToConstant: 344),
            moreProfilesSectionView.heightAnchor.constraint(equalToConstant: 255),
            
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: moreProfilesSectionView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupEventHandlers() {
        
    }
}
