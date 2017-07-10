//
//  PhotoListViewController.swift
//  PhotoViewer_sample
//
//  Created by 鳥居隆弘 on 2017/07/04.
//  Copyright © 2017年 鳥居隆弘. All rights reserved.
//

import Foundation
import UIKit

class PhotoListViewController: UIViewController {
    

    var photos: [FlickrPhoto] = []
    var centerCell: PhotoListTableViewCell = PhotoListTableViewCell()
    
    @IBOutlet weak var photoListTableView: UITableView!
    //photoListTableView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == Constants.Segue.PhotoListViewToImgView {
            
             let vc = segue.destination as! ImgViewController
             vc.flickrPhoto = sender as! FlickrPhoto
            
        }
        
    }
    
    func prepare(){
        
        prepareTableView()
        performSearchWithText(searchText: "Dish")
    }
    
    
}

// MARK: - Table View
extension PhotoListViewController:UITableViewDelegate, UITableViewDataSource{
    
    
    func prepareTableView(){
        
        //style
        self.photoListTableView.separatorStyle = .none
        
        //delegate
        self.photoListTableView.delegate = self
        self.photoListTableView.dataSource = self
        
        //Read XibFile
        let nibDefault: UINib = UINib(nibName: Constants.Xib.PhotoListTableViewCell , bundle: nil)
        self.photoListTableView.register(nibDefault, forCellReuseIdentifier: Constants.Xib.PhotoListTableViewCell )
        self.photoListTableView.reloadData()
        
    }
    
    //section数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Xib.PhotoListTableViewCell ) as! PhotoListTableViewCell
        
        cell.setupWithPhoto(flickrPhoto: photos[indexPath.row ])
        cell.animateHide()
        
        if indexPath.row == 0{
            centerCell = cell
            centerCell.animateApp()
        }
        
        return cell
    }
    
    
    //セルの選択時の操作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constants.Segue.PhotoListViewToImgView , sender: photos[ indexPath.row ] )
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let center = self.view.convert(self.photoListTableView.center, to: self.photoListTableView)
        guard let index = self.photoListTableView.indexPathForRow(at: center) else { return }
        
        let cell = self.photoListTableView.cellForRow(at: index ) as! PhotoListTableViewCell
        
        if centerCell == cell{
        
        }else{
            centerCell = cell
            centerCell.animateApp()
        }
    }
    
    //削除を有効
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}


extension PhotoListViewController{
    // MARK: - Private
    
    func performSearchWithText(searchText: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        FlickrProvider.fetchPhotosForSearchText(searchText: searchText, onCompletion: { (error: NSError?, flickrPhotos: [FlickrPhoto]?) -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error == nil {
                self.photos = flickrPhotos!
            } else {
                self.photos = []
                if (error!.code == FlickrProvider.Errors.invalidAccessErrorCode) {
                    DispatchQueue.main.async(execute: { () -> Void in
                    })
                }
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.title = searchText
                self.photoListTableView.reloadData()
            })
        })
    }
}
