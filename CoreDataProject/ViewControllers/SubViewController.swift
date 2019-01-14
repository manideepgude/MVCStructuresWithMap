//
//  SubViewController.swift
//  CoreDataProject
//
//  Created by Cykul Cykul on 12/01/19.
//  Copyright © 2019 MAC BOOK. All rights reserved.
//

import UIKit

class SubViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{

    @IBOutlet weak var collectioinview: UICollectionView!
    
    var departmentID:String!
    var imagesArray = [String]()
    var categoryArray = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.collectioinview.delegate = self
        self.collectioinview.dataSource = self
        self.getcategoriesData()
    }
    
    // service call
    
    func getcategoriesData() {
        ConstantTools.sharedConstantTool.showsMRIndicatorView(self.view)
        let urlString: String = ("\(BASE_CRL)\(SubDepartmentsData)")
        let body: String = "departmentID=\(departmentID!)"
        (RestAPI.sharedInstance.restAPIMtd(urlString: urlString, methodName: HTTPPOST, params: body) {
            (succeeded: Bool, dictData: NSDictionary) in
            DispatchQueue.main.async {
                ConstantTools.sharedConstantTool.hideMRIndicatorView()
                let jsq = dictData
                let response = jsq["response"] as! Array<Any>
                DispatchQueue.main.async {
                    for i in 0..<response.count
                    {
                        let bannerImages = response[i] as! [String:AnyObject]
                        let Images = bannerImages["image"] as! String
                        let category = bannerImages["category"] as! String
                        self.imagesArray.append(Images)
                        self.categoryArray.append(category)
                        self.collectioinview.reloadData()
                    }
                    
                }
                
            }
        })
        
    }
    
    // CollectionviewDelegates...
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectioinview.dequeueReusableCell(withReuseIdentifier: "SubDeptCollectionViewCell", for: indexPath) as! SubDeptCollectionViewCell
         cell.bannerImages.sd_setImage(with: URL(string:imagesArray[indexPath.row]), placeholderImage: UIImage(named: "loadingIcon"), options: .highPriority)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.size.width-15) / 2, height: view.frame.size.height/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recordVC = self.storyboard?.instantiateViewController(withIdentifier: "RecordpathViewController") as! RecordpathViewController
        self.navigationController?.pushViewController(recordVC, animated: true)
    }
}




