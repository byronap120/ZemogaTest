//
//  PostsViewController.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import UIKit

class PostsViewController: UIViewController  {
    
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loaderBackground: UIView!
    @IBOutlet weak var postTableView: UITableView!
    
    private var postList : [Post] = []
    var presenter: ViewToPresenterPostProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        postTableView.register(cellNib, forCellReuseIdentifier: "postCell")
        
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(showOptions(_:)))
        navigationItem.rightBarButtonItem = button
        
        PostsRouter.createModule(postView: self)
        presenter?.fetchPosts()
    }
    
    @objc func showOptions(_ sender: UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let removeUnfavoritePostsAction = UIAlertAction(title: "Remove unfavorite posts", style: .destructive) { _ in
            self.presenter?.deleteUnfavoritePosts()
        }

        let loadAllPostsAction = UIAlertAction(title: "Reload all posts from API", style: .default) { _ in
            self.presenter?.reloadPostsFromAPI()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(removeUnfavoritePostsAction)
        actionSheet.addAction(loadAllPostsAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
    
}

extension PostsViewController: PostUpdateDelegate {
    
    func postWasUpdated(_ post: Post) {
        presenter?.fetchPosts()
    }
}

extension PostsViewController: PresenterToViewPostProtocol {
    
    func onFetchPostsSuccess(postList: Array<Post>) {
        self.postList = postList
        self.postTableView.reloadData()
    }
    
    func onFetchPostsFailure(error: String) {
        showAlertMessage(title: "Error", message: error)
    }
    
    func showLoader() {
        loaderIndicator.startAnimating()
        loaderBackground.isHidden = false
        
    }
    
    func hideLoader() {
        loaderIndicator.stopAnimating()
        loaderBackground.isHidden = true
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postList[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostTableViewCell
        cell.postTitle.text = post.title
        if(post.isFavorite) {
            cell.postImageFavorite.image = UIImage(systemName: "star.fill")
        } else {
            cell.postImageFavorite.image = UIImage(systemName: "star")
        }
        cell.post = post
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.postImageFavorite.addGestureRecognizer(tapGesture)
        cell.postImageFavorite.isUserInteractionEnabled = true
        cell.postImageFavorite.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postList[indexPath.row]
        performSegue(withIdentifier: "showPostDetail", sender: post)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPostDetail" {
            if let postDetailVC = segue.destination as? PostsDetailViewController, let post = sender as? Post {
                postDetailVC.delegate = self
                postDetailVC.post = post
            }
        }
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView  else {
            return
        }
        let post = postList[imageView.tag]
        if(post.isFavorite) {
            imageView.image = UIImage(systemName: "star")
        } else {
            imageView.image = UIImage(systemName: "star.fill")
        }
        post.isFavorite = !post.isFavorite
        presenter?.updatePost(post: post)
        presenter?.fetchPosts()
    }

}
