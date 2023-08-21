import UIKit

class NotesViewController: UIViewController {

    private var token: String = ""
    private let notesView = NotesView()

    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        fetchDataAndUpdateView()
    }

    private func setupView() {
        view.addSubview(notesView)
    }
    
    private func setupConstraints() {
        notesView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            notesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            notesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            notesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func fetchDataAndUpdateView() {
        let notesDataResource = NotesDataResource()
        notesDataResource.getNotesData(token: token) { [weak self] results in
            guard let self = self, let results = results else {
                DispatchQueue.main.async {
                    AlertManager.shared.showAlert(title: "Server Error", message: "No response from Server")
                }
                return
            }
            DispatchQueue.main.async {
                self.updateView(with: results)
            }
        }
    }

    private func updateView(with data: NotesAPIResponse) {
        updateUserInfoView(with: data.invites.profiles[0])
        updateProfileView(notesView.moreProfilesSectionView.firstProfileView, with: data.likes.profiles[0])
        updateProfileView(notesView.moreProfilesSectionView.secondProfileView, with: data.likes.profiles[1])
    }

    private func updateUserInfoView(with profile: InvitesProfile) {
        notesView.userInfoSectionView.nameAndAgeLabel.text = profile.generalInformation.firstName
        ImageManager.shared.getImageFromURL(urlString: profile.photos[0].photo) { [weak self] image in
            guard let self = self, let image = image else { return }
            DispatchQueue.main.async {
                self.notesView.userInfoSectionView.squareImageView.image = image
            }
        }
    }

    private func updateProfileView(_ profileView: ProfileView, with profile: LikesProfile) {
        profileView.nameLabel.text = profile.firstName
        ImageManager.shared.getImageFromURL(urlString: profile.avatar) { image in

            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                profileView.profileImageView.image = image
                let blurEffect = UIBlurEffect(style: .regular)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = profileView.profileImageView.bounds
                profileView.profileImageView.addSubview(blurEffectView)
            }
        }
    }
}
