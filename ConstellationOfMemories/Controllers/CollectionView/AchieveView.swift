//
//  AchievementView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/12.
//

import UIKit

final class AchieveView: UIView {
    
    // MARK: - Properties
    // Delegate
    var achieveMainDelegate: FirstMainDelegate?
    
    var backgroundData: BackgroundImg? {
        didSet {
            if let backgroundData = backgroundData {
                let array1: [Int] = backgroundData.havedawn
                let array2: [Int] = backgroundData.haveMorning
                let array3: [Int] = backgroundData.haveSunset
                let array4: [Int] = backgroundData.haveNight
                
                self.totalImageInt = (array1 + array2 + array3 + array4).shuffled()
            }
        }
    }
    
    // 가지고 있지 않은 이미지 배열
    private var totalImageInt = [Int]()
    
    // 일기를 쓴 달 배열
    var everyMonth: [String] = [] {
        didSet {
            self.achieveCollection.reloadData()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Layout
    private lazy var achieveCollection: UICollectionView = {
        let firstFrame = CGRect(x: 0,
                                y: 0,
                                width: self.frame.width,
                                height: self.frame.height)
        let Layout = UICollectionViewFlowLayout()
            Layout.scrollDirection = .vertical
        
        let interval : CGFloat = 20
            Layout.sectionInset = UIEdgeInsets.init(top: interval / 2,
                                                    left: interval,
                                                    bottom: 0,
                                                    right: interval)
        var view = UICollectionView(frame: firstFrame,
                                    collectionViewLayout: Layout)
        
            view.delegate = self
            view.dataSource = self
        
            view.alwaysBounceVertical = true
            view.backgroundColor = .clear
        
            view.register(AchieveCell.self, forCellWithReuseIdentifier: ReuseIdentifier.achieveCell)
        return view
    }()
    
    
    
    
    
    
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - Helper Functions
    
    private func configureView() {
        // background Color
        self.backgroundColor = .clear
        // alpha
        self.alpha = 0
        // firstCollection
        self.addSubview(self.achieveCollection)
    }
    
    
    func resetAchieveView() {
        // item이 항상 맨위로 가도록 설정
        self.achieveCollection.scrollToItem(at: IndexPath(item: 0, section: 0),
                                            at: .top, animated: true)
    }
}






























// MARK: - CollectionView
extension AchieveView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // item의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.everyMonth.count
    }

    // Cell_For_Row_At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.achieveCell, for: indexPath) as! AchieveCell
        
            cell.haveImage.image = UIImage(named: "\(self.totalImageInt[indexPath.row])")
        
        cell.monthString.text = "\(self.everyMonth[indexPath.row])월"
        
        return cell
    }
    
    // Did_Select_Row_At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.achieveMainDelegate?.monthDiaryTapped(month: self.everyMonth[indexPath.row])
    }
    
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.width - 40 - 10) / 2
        return CGSize(width: width, height: width)
    }

    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
