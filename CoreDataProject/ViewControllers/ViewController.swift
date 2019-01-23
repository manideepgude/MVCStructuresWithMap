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
import CoreData

class ViewController: UIViewController
{
    
    @IBOutlet weak var scrollview: UIScrollView!
    var bannerImagesDataMemoryAllocation = bannerImages.ImagesArray()
    var imagesDisplayData = [bannerImages.ImagesArray]()
    var challngeObj:bannerImages.ImagesArray! = nil
    var bannerArray = [String]()
    var responseImageArray = [String]()
    private var sliderImagesCoreData : SliderImages?
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
        let offlineCoreData = SliderImages(context: CoreDataStack.context)
        offlineCoreData.bannerImagesSlider = responseImageArray as NSObject
        CoreDataStack.saveContext()
        self.sliderImagesCoreData = offlineCoreData
    }
    
    // fetch coredata in swift 4.
    
    func fetchImages()
    {
        let request : NSFetchRequest<SliderImages> = SliderImages.fetchRequest()
        let context = CoreDataStack.persistentContainer.viewContext
        let p = try? context.fetch(request)
        for i in p!{
            print(i.bannerImagesSlider ?? [""])
            responseImageArray = i.bannerImagesSlider! as! [String]
            self.CollectionView.reloadData()
        }
    }

    //delete coredata in swift 4.
    
    func deleteAllRecords() {
        
        let context = CoreDataStack.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SliderImages")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
        }
    }
    
    func imageslider()
    {
        scrollview.auk.settings.placeholderImage = UIImage(named: "great_auk_placeholder.png")
        scrollview.auk.settings.errorImage = UIImage(named: "error_image.png")
        // Preload the next and previous images
        scrollview.auk.settings.preloadRemoteImagesAround = 1
    }
    
    func getcategoriesData() {
        if currentReachabilityStatus == .reachableViaWiFi || currentReachabilityStatus == .reachableViaWWAN
        {
        self.deleteAllRecords()
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
                    }
                    for i in 0..<response.count
                    {
                        let imageData = response[i] as! [String:AnyObject]
                        let responseImages = imageData["image"] as! String
                        let departmentID = imageData["departmentID"] as! String
                        self.departmentIDArray.append(departmentID)
                        self.responseImageArray.append(responseImages)
                          self.saveData()
                        self.CollectionView.reloadData()
                    }
                    
                }
            
            }
        })
        
    }
        else
        {
            self.fetchImages()
            print("sumanth")
        }
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
