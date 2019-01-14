//
//  SubDepartmentsViewController.swift
//  CoreDataProject
//
//  Created by Cykul Cykul on 12/01/19.
//  Copyright © 2019 MAC BOOK. All rights reserved.
//

import UIKit

class SubDepartmentsViewController: UIViewController {

    @IBOutlet weak var CollectionView: UICollectionView!
    var loadimages = [String]()
    var departmentID:String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        self.getcategoriesData()
    }
    
    // json parsing...
    
    func getcategoriesData() {
        ConstantTools.sharedConstantTool.showsMRIndicatorView(self.view)
        let urlString: String = ("\(BASE_CRL)\(SubDepartmentsData)")
        let body: String = "departmentID=\(departmentID!)"
        (RestAPI.sharedInstance.restAPIMtd(urlString: urlString, methodName: HTTPPOST, params: body) {
            (succeeded: Bool, dictData: NSDictionary) in
                ConstantTools.sharedConstantTool.hideMRIndicatorView()
                let jsq = dictData
                let banner = jsq["response"] as! Array<Any>
                DispatchQueue.main.async {
                    for i in 0..<banner.count
                    {
                        let bannerImages = banner[i] as! [String:AnyObject]
                        let Images = bannerImages["image"] as! String
                        self.loadimages.append(Images)
                        self.CollectionView.reloadData()
                    }
                    
                }
        })
        
    }
    
    
    
}

// MARK:- UICollectionViewDataSource

extension SubDepartmentsViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadimages.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubDepartmentsCollectionViewCell", for: indexPath) as! SubDepartmentsCollectionViewCell
        cell.layer.masksToBounds = false
        cell.layer.shadowRadius = 5
        cell.layer.shadowOffset = CGSize(width:0.0,height:3.0)
        cell.layer.shadowOpacity = 0.2
        cell.ImageViews.sd_setImage(with: URL(string:loadimages[indexPath.row]), placeholderImage: UIImage(named: "loadingIcon"), options: .highPriority)
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.size.width-15) / 2, height: view.frame.size.height/5)
    }
    
}
