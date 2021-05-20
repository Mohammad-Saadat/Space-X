//
//  DetailViewController.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailDisplayLogic: class {
    func showLoading()
    func hideLoading()
    func displayError(viewModel: Detail.ErrorModel.ViewModel)
    func displayData(viewModel: Detail.Info.ViewModel)
}

class DetailViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("DetailViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: DetailFactory) {
        super.init(nibName: DetailViewController.nibName, bundle: nil)
        self.factory = factory
        factory.setup(viewController: self)
        DetailLogger.logInit(owner: String(describing: DetailViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        DetailLogger.logDeinit(owner: String(describing: DetailViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private var factory: DetailFactory!
    
    // MARK: Public
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    
    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var launchDateLabel: UILabel!
    @IBOutlet private weak var failuresLabel: UILabel!
    @IBOutlet private weak var articleLabel: UILabel! {
        didSet {
            articleLabel.isUserInteractionEnabled = true
            articleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnArticleLabel)))
        }
    }
    @IBOutlet private weak var patchImageView: UIImageView!
}

// MARK: - View Controller

// MARK: Life Cycle
extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        factory.setup(viewController: self)
        title = "Detail"
        interactor?.fetchLaunchInfo()
    }
}

// MARK: - Methods

// MARK: Private
private extension DetailViewController {
    func setPathcImage(with stringUrl: String?) {
        if let stringUrl = stringUrl, let url = URL(string: stringUrl) {
            patchImageView.setImage(with: url)
        }
    }
}

// MARK: Public
extension DetailViewController {}

// MARK: - Display Logic
extension DetailViewController: DetailDisplayLogic {
    func showLoading() {
        view.showLoading()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    
    func displayError(viewModel: Detail.ErrorModel.ViewModel) {
        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        presentMessege(title: "Error",
                       message: viewModel.error.localizedDescription,
                       additionalActions: action,
                       preferredStyle: .alert) { [weak self] _ in
            self?.interactor?.fetchLaunchInfo()
            
        }
    }
    
    func displayData(viewModel: Detail.Info.ViewModel) {
        nameLabel.text = viewModel.name
        detailsLabel.text = viewModel.detail
        failuresLabel.text = viewModel.failures
        launchDateLabel.text = viewModel.launchDate
        articleLabel.text = "Article about \(viewModel.name ?? "")"
        setPathcImage(with: viewModel.rocketImage)
    }
}

// MARK: - Actions
extension DetailViewController {
    @objc func tapOnArticleLabel(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let text = self.articleLabel.text else { return }
        //
        let hereRange = (text as NSString).range(of: text)
        //
        if gestureRecognizer.didTapAttributedTextInLabel(inRange: hereRange) {
            guard let urlString = router?.dataStore?.articleLink,
                  let url = URL(string: urlString) else { return }
        }
    }
}
