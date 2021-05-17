//
//  RecommendHeadBackView.swift
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

import Foundation
import UIKit

@objc class RecommendHeadBackView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    @objc lazy var dataSource = { () -> NSMutableArray in
        let dataSource = NSMutableArray()
        return dataSource
    }()
    
    private lazy var headTitleLab = { () -> UILabel in
        let headTitleLab = UILabel.init(frame: CGRect.init(x: 12, y: 0, width: screenWidth-24, height: 30))
        headTitleLab.backgroundColor = UIColor.white
        headTitleLab.text = "Recommend App"
        headTitleLab.font = UIFont.boldSystemFont(ofSize:20)
        return headTitleLab
    }()
    
    private lazy var backCollectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 120, height: 170)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing=1
        layout.minimumInteritemSpacing=1
        let backCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 30, width: screenWidth, height: 170), collectionViewLayout: layout)
        backCollectionView.backgroundColor = UIColor.white
        backCollectionView.delegate = self
        backCollectionView.dataSource = self
        backCollectionView.showsVerticalScrollIndicator = false;
        backCollectionView.register(AppRecommendCell.self, forCellWithReuseIdentifier: "AppRecommendCell")
        return backCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addSubview(self.headTitleLab)
        self.addSubview(self.backCollectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func updateReloadCollectionView(dataAry:NSArray){
        self.dataSource.removeAllObjects();
        self.dataSource .addObjects(from: dataAry as! [Any])
        DispatchQueue.main.async {
            self.backCollectionView .reloadData()
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("dataSource =\(dataSource.count)")
        return dataSource.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdenString = "AppRecommendCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdenString, for: indexPath) as! AppRecommendCell
        cell.backgroundColor = UIColor.gray
        let model : AppListDataModel = self.dataSource[indexPath.row] as! AppListDataModel
        cell .updateUIDataWithModel(listModel: model)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader  {
//            let headerView:SwiftHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SwiftHeaderCollectionReusableView", for: indexPath) as! SwiftHeaderCollectionReusableView
//
//            return headerView
//        }
//        else
//        {
//            let footerView:SwiftFooterCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SwiftFooterCollectionReusableView", for: indexPath) as! SwiftFooterCollectionReusableView
//      return footerView
//        }
//
//    }
    
}
