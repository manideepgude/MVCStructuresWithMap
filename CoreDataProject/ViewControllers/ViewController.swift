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
import Auk
import moa

class ViewController: UIViewController
{
    
    @IBOutlet weak var scrollview: UIScrollView!
    var bannerImagesDataMemoryAllocation = bannerImages.ImagesArray()
    var imagesDisplayData = [bannerImages.ImagesArray]()
    var challngeObj:bannerImages.ImagesArray! = nil
    var bannerArray = [String]()
    var responseImageArray = [String]()
    var departmentIDArray = [String]()
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.getcategoriesData()
        self.scrollview.delegate = self
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        self.imageslider()
    }
    
    // save data with coredata in swift 4.
    
    func saveData() {
        
        let offlineCoreData = Offlinedata(context: CoreDataStack.context)
        offlineCoreData.challengeInfoFr = activityAboutArr
        offlineCoreData.eventTypeFr = activityEventType
        offlineCoreData.headerFr = activityHeaderArr
        offlineCoreData.inviteTextFr = activityInviteText
        offlineCoreData.menuItemsFr = menuItemsActivity
        offlineCoreData.rewardsFr = activityRewards
        offlineCoreData.rideBannerFr = activityBannerArr
        offlineCoreData.rideLogoFr = rideLogoActivity
        offlineCoreData.rideNameFr = rideNameActivity
        offlineCoreData.statusFr = statusActivity
        offlineCoreData.challengeIDFr = ActivityID
        offlineCoreData.tabHeaderFr = activityTabBarArr

        CoreDataStack.saveContext()
        self.freeChalengesCoreData = offlineCoreData
    }
    

    func imageslider()
    {
        scrollview.auk.settings.placeholderImage = UIImage(named: "great_auk_placeholder.png")
        scrollview.auk.settings.errorImage = UIImage(named: "error_image.png")
        // Preload the next and previous images
        scrollview.auk.settings.preloadRemoteImagesAround = 1
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
              let response = jsq["response"] as! Array<Any>
                DispatchQueue.main.async {
                    for i in 0..<banner.count
                    {
                        let bannerImages = banner[i] as! [String:AnyObject]
                        let Images = bannerImages["image"] as! String
                        self.bannerArray.append(Images)
                        self.scrollview.auk.show(url: Images)
                        self.scrollview.auk.startAutoScroll(delaySeconds: 3)
                        self.CollectionView.reloadData()
                    }
                    for i in 0..<response.count
                    {
                        let imageData = response[i] as! [String:AnyObject]
                        let responseImages = imageData["image"] as! String
                        let departmentID = imageData["departmentID"] as! String
                        self.departmentIDArray.append(departmentID)
                        self.responseImageArray.append(responseImages)
                        self.CollectionView.reloadData()
                    }
                    
                }
            
            }
        })
        
    }
}

// MARK:- UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responseImageArray.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.layer.masksToBounds = false
        cell.layer.shadowRadius = 5
        cell.layer.shadowOffset = CGSize(width:0.0,height:3.0)
        cell.layer.shadowOpacity = 0.2
        cell.ImageView.sd_setImage(with: URL(string:responseImageArray[indexPath.row]), placeholderImage: UIImage(named: "loadingIcon"), options: .highPriority)
        return cell
    }
    
   internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.size.width-15) / 2, height: view.frame.size.height/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let subDept = self.storyboard?.instantiateViewController(withIdentifier: "SubViewController") as! SubViewController
        subDept.departmentID = departmentIDArray[indexPath.row]
        self.navigationController?.pushViewController(subDept, animated: true)
    }
}

extension ViewController: UIScrollViewDelegate
{
    
}
