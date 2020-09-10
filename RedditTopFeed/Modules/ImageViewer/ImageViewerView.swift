//
//  ImageViewerView.swift
//  RedditTopFeed
//
//  Created vladislav on 10.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

public final class ImageViewerView: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Instantiate
    
    static func instantiate() -> Self {
        UIStoryboard(name: String(describing: Self.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
    
    
    // MARK: - Properties
    
    public var presenter: ImageViewerPresenter?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.loadData()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        presenter?.share()
    }
}


// MARK: - ImageViewerViewInterface

extension ImageViewerView: ImageViewerViewInterface {
    
    public func update(view state: ImageViewerViewState) {
        switch state {
        case let .loaded(data: data):
            activityIndicator.stopAnimating()
            imageView.image = UIImage.init(data: data.data)
        case .empty: return
        case .loading:
            activityIndicator.startAnimating()
        }
    }
    
    public func share(imageData: Data) {
        let vc = UIActivityViewController.init(activityItems: [imageData], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = view
        present(vc, animated: true, completion: nil)
    }
}
