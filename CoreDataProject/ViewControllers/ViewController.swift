//
//  ViewController.swift
//  CoreDataProject
//
//  Created by MAC BOOK on 11/01/19.
//  Copyright © 2019 MAC BOOK. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
import IQKeyboardManagerSwift

class ViewController: UIViewController
{
   
    var bannerImagesDataMemoryAllocation = bannerImages.ImagesArray()
    var imagesDisplayData = [bannerImages.ImagesArray]()
    var challngeObj:bannerImages.ImagesArray! = nil
    var bannerArray = [String]()
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.getcategoriesData()
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
    }

    
    func getcategoriesData() {
        ConstantTools.sharedConstantTool.showsMRIndicatorView(self.view)
        let urlString: String = ("\(BASE_CRL)\(CollectedData)")
        let body: String = "country=INDIA"
        (RestAPI.sharedInstance.restAPIMtd(urlString: urlString, methodName: HTTPPOST, params: body) {
            (succeeded: Bool, dictData: NSDictionary) in
            DispatchQueue.main.async {
                ConstantTools.sharedConstantTool.hideMRIndicatorView()
              let jsq = dictData
             let banner = jsq["banner"] as! Array<Any>
                for i in 0..<banner.count
             {
                let bannerImages = banner[i] as! [String:AnyObject]
                let Images = bannerImages["image"] as! String
                self.bannerArray.append(Images)
                self.CollectionView.reloadData()
            }
            }
        })
        
    }
}

// MARK:- UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerArray.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.ImageView.sd_setImage(with: URL(string:bannerArray[indexPath.row]), placeholderImage: UIImage(named: "loadingIcon"), options: .highPriority)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if ( UIDevice.current.model.range(of: "iPad") != nil){
            let width = (self.view.frame.size.width - 12 * 3) / 3 //some width
            //let height = width * 1.3 //ratio
            return CGSize(width: width, height: 200);
        }
        let width = (self.view.frame.size.width - 12 * 2) / 2 //some width
        //let height = width * 1.5 //ratio
        return CGSize(width: width, height: 200);
    }

}

