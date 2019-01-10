//
//  SPCommentsViewController.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import UIKit
import Moya

/// View Controller which load and display comments.
class SPCommentsViewController: SPBaseViewController {

    // MARK: Parameters
    
    /// Used for make lower range value in load comments request.
    var lowerId: Int?
    /// Used for make upper range value in load comments request.
    var upperId: Int?
    
    /// Comments loading request task
    var requestTask: Cancellable?
    /// How many comments should be loaded by request.
    let limit = 10
    /// Page for comments loading request.
    var page = 1
    /// Is all comments loaded.
    var isLoadedAll = false
    /// Loaded comments.
    var comments: [SPComment] = []
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100.0
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: Initialization
    
    /**
     The comments view controller's designated initializer.
    
     - Returns: A new comments view controller instance.
     */
    class func create() -> SPCommentsViewController {
        return SPLayoutManager.create(controller: SPCommentsViewController.self, from: .main)
    }
    
    /**
     The comments view controller's designated initializer.
     
     - Parameter lowerId: id lower boundary.
     - Parameter upperId: id upper boundary.
     
     - Returns: A new comments view controller instance.
     */
    class func createWith(lowerId: Int?, upperId: Int?) -> SPCommentsViewController {
        let controller = SPCommentsViewController.create()
        controller.lowerId = lowerId
        controller.upperId = upperId
        return controller
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigurations()
        
        if comments.isEmpty {
            loadComments()
        }
    }
    
    // MARK: Configurations
    
    /// Configuration of controller's UI elements.
    fileprivate func defaultConfigurations() {
        navigationItem.title = "Comments"
    }

    fileprivate func showLoadingActivity(_ show: Bool) {
        if show {
            let view: SPActivityView = SPActivityView.create()
            tableView.tableFooterView = view
        } else {
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: Network
    
    fileprivate func loadComments(isLoadMore: Bool = false) {
        if isLoadMore {
            if isLoadedAll {
                return
            }
        }
        
        hideActivityIndicator()
        showLoadingActivity(false)
        
        if isLoadMore {
            showLoadingActivity(true)
        } else {
            showActivityIndicator()
        }
        
        loadComments(isLoadMore: isLoadMore, successHandler: {
            if isLoadMore {
                self.showLoadingActivity(false)
            } else {
                self.hideActivityIndicator()
            }
            self.tableView.reloadData()
        }) { (error) in
            if isLoadMore {
                self.showLoadingActivity(false)
            } else {
                self.hideActivityIndicator()
            }
            self.showError(error)
        }
    }
    
    /**
     Load comments.
 
     - Parameter isLoadMore: if false load comments from start, if true continue load comments.
     - Parameter successHandler: Handler which will be called after comments was loaded.
     - Parameter errorHandler: Handler which will be called if occurred error.
     
     */
    public func loadComments(isLoadMore: Bool = false, successHandler: (() -> Swift.Void)?, errorHandler: ((Error) -> Swift.Void)?) {
        requestTask?.cancel()
        requestTask = nil
        
        if isLoadMore {
            if isLoadedAll {
                return
            }
        } else {
            self.page = 1
            isLoadedAll = false
        }
        
        let task = SPNetworkManager.comments(idGte: self.lowerId, idLte: self.upperId, page: self.page, limit: self.limit, successHandler: { [weak self] (comments) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.requestTask = nil
                
                self.page += 1
                if comments.count < self.limit {
                    self.isLoadedAll = true
                }
                
                if isLoadMore {
                    self.comments += comments
                } else {
                    self.comments = comments
                }
                
                successHandler?()
            }
        }) { [weak self] (error) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.requestTask = nil
                errorHandler?(error)
            }
        }
        requestTask = task
    }
    
    public func cancelCommentsLoading() {
        requestTask?.cancel()
        requestTask = nil
        self.hideActivityIndicator()
    }
}

// MARK: - TableView -

extension SPCommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView --> SPCommentTableViewCell.self
        
        let comment = comments[indexPath.row]
        
        cell.nameLabel.text = comment.name
        cell.emailLabel.text = comment.email
        cell.bodyLabel.text = comment.body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard requestTask == nil else {return}
        let lastElement = comments.count - 1
        if indexPath.row == lastElement {
            loadComments(isLoadMore: true)
            print("load more \(Date())")
        }
    }
}
