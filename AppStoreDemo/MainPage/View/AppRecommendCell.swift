//
//  AppRecommendCell.swift
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

import Foundation
import UIKit

class AppRecommendCell: UICollectionViewCell {
    
    var model : AppListDataModel!
        
    private lazy var iconImg = { () -> UIImageView in
        let iconImg = UIImageView()
        iconImg.backgroundColor = UIColor.white
        iconImg.clipsToBounds = true
        iconImg.layer.cornerRadius = 24;
        return iconImg
    }()
    
    
    private lazy var appNameLab = { () -> UILabel in
        let appNameLab = UILabel()
        appNameLab.backgroundColor = UIColor.white
        appNameLab.text = "Recommend"
        appNameLab.textAlignment = .center
        appNameLab.font = UIFont.boldSystemFont(ofSize:16)
        return appNameLab
    }()
    
    private lazy var appType = { () -> UILabel in
        let appType = UILabel()
        appType.backgroundColor = UIColor.white
        appType.font = UIFont.systemFont(ofSize: 14)
        appType.textAlignment = .center
        return appType
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.createCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createCellUI()  {
        self.iconImg.frame = CGRect.init(x: 12, y: 8, width: self.contentView.frame.size.width - 24, height: self.contentView.frame.size.width - 24)
        self.contentView.addSubview(self.iconImg)
        
        self.appNameLab.frame = CGRect.init(x: 12, y: self.contentView.frame.size.width - 12, width: self.contentView.frame.size.width - 24, height: 24);
        self.contentView.addSubview(self.appNameLab)
        
        self.appType.frame = CGRect.init(x: 12, y: self.contentView.frame.size.width+15, width: self.contentView.frame.size.width - 24, height: 16);
        self.contentView.addSubview(self.appType)

        
    }
    
    @objc func updateUIDataWithModel(listModel:AppListDataModel ){
        self.model = listModel;
        
        self.appNameLab.text = listModel.appName;
        self.appType.text = listModel.appType;
        if (listModel.appIcon.count > 0){
            self.iconImg.sd_setImage(with: URL.init(string: listModel.appIcon),placeholderImage: UIImage.init(named: "zhanweitu"))
        }else{
            if listModel.imageAry.count > 0 {
                let urlModel : AppIconUrlModel = listModel.imageAry.last as! AppIconUrlModel
                self.iconImg.sd_setImage(with: URL.init(string: urlModel.label),placeholderImage: UIImage.init(named: "zhanweitu"))
            }else{
                self.iconImg.image = UIImage.init(named: "zhanweitu")
            }
            
        }
        
    }
    
    

    
    
}
