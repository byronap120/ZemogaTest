//
//  PostDetailViewController.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import UIKit

class PostsDetailViewController: UIViewController {
    
    @IBOutlet weak var deletePost: UIImageView!
    @IBOutlet weak var favoritePost: UIImageView!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var authorEmail: UILabel!
    @IBOutlet weak var authorUserName: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postContent: UILabel!
    
    private var comments: [Comment] = []
    weak var delegate: PostUpdateDelegate?
    var post: Post?
    var presenter: ViewToPresenterPostDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "CommentsTableViewCell", bundle: nil)
        commentsTableView.register(cellNib, forCellReuseIdentifier: "commentCell")
        
        postTitle.text = post?.title
        postContent.text = post?.body
        
        if(post?.isFavorite == true) {
            favoritePost.image = UIImage(systemName: "star.fill")
        } else {
            favoritePost.image = UIImage(systemName: "star")
        }
        
        let favoriteGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped(_:)))
        favoritePost.addGestureRecognizer(favoriteGesture)
        favoritePost.isUserInteractionEnabled = true
        
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(deleteTapped(_:)))
        deletePost.addGestureRecognizer(deleteGesture)
        deletePost.isUserInteractionEnabled = true
        
        PostDetailRouter.createModule(detailView: self)
        presenter?.fetchDetails(postId: post!.id, userId: post!.userId)
    }
    
    @objc func favoriteTapped(_ sender: UITapGestureRecognizer) {
        if(post?.isFavorite == true) {
            favoritePost.image = UIImage(systemName: "star")
        } else {
            favoritePost.image = UIImage(systemName: "star.fill")
        }
        post?.isFavorite = !post!.isFavorite
        delegate?.postWasUpdated(post!)
        presenter?.updatePost(post: post!)
    }
    
    @objc func deleteTapped(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "Delete Post", message: "Are you sure you want to delete this post?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (action) in
            guard let self = self else { return }
            self.presenter?.deletePost(post: self.post!)
            self.navigationController?.popViewController(animated: true)
            self.delegate?.postWasUpdated(self.post!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension PostsDetailViewController: PresenterToViewPostDetailProtocol {
    func onFetchDetailSuccess(author: Author?, comments: [Comment]) {
        authorEmail.text = author?.email
        authorUserName.text = "@\(author?.username ?? "")"
        authorName.text = author?.name
        
        self.comments = comments
        self.commentsTableView.reloadData()
    }
    
    func onFetchDetailFailure(error: String) {
        showAlertMessage(title: "Error", message: error)
    }
}

extension PostsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentsTableViewCell
        cell.userName.text = comment.name
        cell.comment.text = comment.body
        return cell
    }
}
