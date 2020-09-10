//
//  FeedView.swift
//  RedditTopFeed
//
//  Created vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

public final class FeedView: UIViewController {
    
    fileprivate let cellIdentifier = "Cell"
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    // MARK: - Instantiate
    
    static func instantiate() -> Self {
        UIStoryboard(name: String(describing: Self.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let presenter = FeedViewPresenter()
        self.presenter = presenter
        presenter.view = self
    }
    
    
    // MARK: - Properties
    
    public var presenter: FeedPresenter?
    
    fileprivate var refreshControl = UIRefreshControl()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.loadData()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Update")
        refreshControl.addTarget(self, action: #selector(self.update(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc fileprivate func update(_ sender: AnyObject) {
        presenter?.loadData()
    }
    
    fileprivate func setTableView(hidden: Bool) {
        if hidden {
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.alpha = 0
            }) { (finished) in
                self.tableView.isHidden = true
            }
        } else {
            self.tableView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.alpha = 1
            }) { (finished) in
            }
        }
    }
}


// MARK: - FeedViewInterface

extension FeedView: FeedViewInterface {
    
    public func update(view state: FeedViewState) {
        switch state {
        case .loaded:
            refreshControl.endRefreshing()
            activityIndicator.stopAnimating()
            setTableView(hidden: false)
            loadingLabel.isHidden = true
            return
        case .empty: return
        case .loading:
            refreshControl.beginRefreshing()
            activityIndicator.startAnimating()
            setTableView(hidden: true)
            loadingLabel.isHidden = false
            return
        }
    }
    
    public func updateData() {
        tableView.reloadData()
    }
    
    public func updateRow(_ row: Int) {
        tableView.reloadRows(at: [IndexPath.init(row: row, section: 0)], with: .none)
    }
    
    public func insertRows(startRow: Int, endRow: Int) {
        var indexPaths = [IndexPath]()
        for i in startRow..<endRow {
            indexPaths.append(IndexPath.init(row: i, section: 0))
        }
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
}

extension FeedView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = presenter?.getDataForRow(indexPath.row) else {
            return UITableViewCell.init()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostCell else {
            return UITableViewCell.init()
        }
        cell.titleLabel.text = item.title
        cell.authorLabel.text = item.author
        cell.dateLabel.text = item.date
        cell.commentsLabel.text = item.comments
        if let imageData = item.previewImage {
            cell.previewImageView.image = UIImage.init(data: imageData)
            cell.previewImageView.isHidden = false
        } else {
            cell.previewImageView.image = nil
            cell.previewImageView.isHidden = true
        }
        return cell
    }
    
}

extension FeedView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.checkReachedBottom(row: indexPath.row)
    }
    
}
