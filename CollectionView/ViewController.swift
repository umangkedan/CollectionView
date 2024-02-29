//
//  ViewController.swift
//  CollectionView
//
//  Created by Umang Kedan on 11/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView1: UICollectionView!
//        let userList : [String : Any] = [
//        [
//            "name":"Isha",
//            "age" : 22,
//            "city": "Ahemdabad",
//            "image" : "city",
//            "phone no" : 77887788878
//    ],
//        [
//            "name":"Riya",
//            "age" : 23,
//            "city": "Delhi",
//            "image" : "school",
//            "phone no" : 89898900776
//        ],[
//            "name":"Roshni",
//            "age" : 20,
//            "city": "Surat",
//            "image" : "city",
//            "phone no" : 77887788878
//        ],[
//            "name":"Dina",
//            "age" : 29,
//            "city": "Goa",
//            "image" : "ina",
//            "phone no" : 7878799091
//        ],[
//            "name":"Sooraj",
//            "age" : 40,
//            "city": "Mumbai",
//            "image" : "sooraj",
//            "phone no" : 7878799095
//        ]]
        
    let userArray : [UIImage?] = [UIImage(named: "bird") , UIImage(named: "tom") , UIImage(named: "boy") , UIImage(named: "snorlex") ,
    UIImage(named: "tiger") , UIImage(named: "charlizard") , UIImage(named: "pikachu"),UIImage(named: "pokemon"),UIImage(named: "bulbasor")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageController()
        setCollectionView()
    }
    
    func setCollectionView() {
        collectionView1.dataSource = self
        collectionView1.delegate = self
        collectionView1.register(UINib(nibName: "CustomCell", bundle: .main), forCellWithReuseIdentifier: "custom")
        
        let customFlowLayout = UICollectionViewFlowLayout()
        customFlowLayout.minimumLineSpacing = 0.01
        customFlowLayout.estimatedItemSize = .zero
        customFlowLayout.minimumInteritemSpacing = 0.01
        customFlowLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
        //customFlowLayout.headerReferenceSize = CGSize(width: collectionView1.frame.width, height: 30)
    //    customFlowLayout.footerReferenceSize = CGSize(width: collectionView1.frame.width, height: 30)
        customFlowLayout.scrollDirection = .horizontal
        
        collectionView1.collectionViewLayout = customFlowLayout
        
        collectionView1.register(UINib(nibName: "HeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView1.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil),forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,  withReuseIdentifier: "footer")
    }
    
    func setPageController() {
        pageControl.numberOfPages = userArray.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(self.pageValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func pageValueChanged(sender:UIPageControl) {
        let itemIndex = sender.currentPage
        collectionView1.scrollToItem(at: IndexPath(item: itemIndex, section: 0), at: .left, animated: true)
    }
    
}
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "custom", for: indexPath) as? CustomCell else{
            return UICollectionViewCell()
        }
        
        if let image = userArray[indexPath.item] {
            cell.setCellData(image: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        print(width)
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? HeaderReusableView else {
                return UICollectionReusableView()
            }
            return header

        case UICollectionView.elementKindSectionFooter :
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as? FooterCollectionReusableView else {
                return UICollectionReusableView()
            }
            return footer
            
        default:
            return UICollectionReusableView()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.x
        let index = Int(contentOffset / collectionView1.frame.width)
        print(contentOffset)
        print(collectionView1.frame.width)
        print(index)
        pageControl.currentPage = index
    }
    
    
}
