//
//  TreasureDetailVC.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/22.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class TreasureDetailVC: UIViewController {

    @IBOutlet weak var mainScorllView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var buyTimeLbl: UILabel!
    @IBOutlet weak var buyPriceLbl: UILabel!
    @IBOutlet weak var salePriceLbl: UILabel!
    @IBOutlet weak var saleStatusLbl: UILabel!
    @IBOutlet weak var remarkLbl: UILabel!
    @IBOutlet weak var keywordView: UIView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageContentView: UIView!
    var treasure = EditTreasureForm()
    var tId: Int?
    var page = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        // Do any additional setup after loading the view.
    }

    func initData() {
        if let treasureId = self.tId {
            let treasure = TreasureRepository().findTreasureDetailWith(id: treasureId)
            self.treasure = EditTreasureForm.init(with: treasure)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadView()
    }

    @IBAction func shareBtnClicked() {
        let shareView = ShareView.loadXib()
        shareView.reloadView(treasure: treasure)
        self.view.addSubview(shareView)
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadView() {
        let images = self.treasure.images
        if images.count == 0 {
            self.imageHeight.constant = 0
            self.imageContentView.isHidden = true
        }else {
            self.imageScrollView.delegate = self
            self.imageScrollView.contentSize = CGSize(width: UISizeConstants.screenWidth*CGFloat(images.count), height: self.imageScrollView.height)
            for i in 0..<images.count {
                let img = UIImageView(image: images[i])
                img.frame = CGRect(x: UISizeConstants.screenWidth*CGFloat(i), y: 0, width: UISizeConstants.screenWidth, height: self.imageScrollView.height)
                img.tag = i
                img.isUserInteractionEnabled = true
                img.contentMode = .scaleAspectFit
                img.backgroundColor = UIColor.black
                let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(self.imageTap(ges:)))
                img.addGestureRecognizer(tapGes)
                self.imageScrollView.addSubview(img)
                self.pageControll.numberOfPages = images.count
            }
        }
        self.titleLbl.text = treasure.name
        self.desLbl.text = treasure.descrpiton
        self.sizeLbl.text = treasure.size.isEmpty ? "--" : treasure.size
        self.yearLbl.text = treasure.year.isEmpty ? "--" : treasure.year
        if let purchasedYear = treasure.purchasedYear {
            self.buyTimeLbl.text = purchasedYear.description
        }else {
            self.buyTimeLbl.text = "--"
        }
        if let purchasedPrice = treasure.purchasedPrice {
            self.buyPriceLbl.text = purchasedPrice.description
        }else {
            self.buyPriceLbl.text = "--"
        }
        if let sellingPrice = treasure.sellingPrice {
            self.salePriceLbl.text = sellingPrice.description
        }else {
            self.salePriceLbl.text = "--"
        }
        switch treasure.sellStatus {
        case .unavaliable:
            self.saleStatusLbl.text = "不可售"
        case .avaliable:
            self.saleStatusLbl.text = "可售"
        default:
            self.saleStatusLbl.text = "已售"
        }
//        let keywordsView = KeywordsScrollView.init(frame: CGRect(x: 0, y: 0, width: UISizeConstants.screenWidth-40, height: 44))
//        keywordsView.reloadWidth(keys: treasure.keywords)
//        self.keywordView.addSubview(keywordsView)
        self.remarkLbl.text = treasure.note
    }
    
    
    @objc func imageTap(ges:UITapGestureRecognizer) {
        let tag = ges.view?.tag ?? 0
        let imageVc = FJPreImageView.init()
        imageVc.showPreView(self.view, urls: self.treasure.imageUrls, index: tag)
        
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        let x:CGFloat = CGFloat(self.pageControll.currentPage) * UISizeConstants.screenWidth
        let point = CGPoint(x: x, y: 0)
        self.imageScrollView.contentOffset = point
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TreasureDetailVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let page = self.imageScrollView.contentOffset.x / self.view.frame.size.width
           self.pageControll.currentPage = Int(page)
       }
       

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.page = self.pageControll.currentPage
        return scrollView.subviews.first
    }
          
}
