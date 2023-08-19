//
//  SecondCollectionView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class SecondCollectionView: UIView {
    
    // MARK: - Properties
    var secondMainDelegate: SecondMainDelegate?

    private var item = [Int]()
    
    
    // 맨 위로 정렬
    var secondCollectionToggle: SegementToggle? {
        didSet {
            // item이 항상 맨위로 가도록 설정
            self.upCollectionView()
            
            self.secondCollection.reloadData()
        }
    }
    
    
    
    
    
    
    // MARK: - Layout
    lazy var secondCollection: UICollectionView = {
        let secondFrame = CGRect(x: 0,
                                 y: 0,
                                 width: self.frame.width,
                                 height: self.frame.height)
        
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
        
        let interval: CGFloat = 20
            layout.sectionInset = UIEdgeInsets.init(top: interval / 2,
                                                    left: interval,
                                                    bottom: 0,
                                                    right: interval)
        var view = UICollectionView(frame: secondFrame,
                                    collectionViewLayout: layout)
            view.delegate = self
            view.dataSource = self
        
            view.alwaysBounceVertical = true
            view.backgroundColor = .clear
        
            view.register(SecondCollectionCell.self,
                      forCellWithReuseIdentifier: ReuseIdentifier.secondCollectionCell)
        return view
    }()
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.ConfigureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Helper Functions
    private func ConfigureUI() {
        // collectionView
        self.addSubview(self.secondCollection)
    }
    
    private func upCollectionView() {
        print("2222222222222222")
        // item이 항상 맨위로 가도록 설정
        let indexPath = IndexPath(item: self.item.count - 1, section: 0)
        self.secondCollection.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    
    
    // MARK: - API
    
    
}









// MARK: - CollectionView
extension SecondCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: - Cell
    // 셀의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.secondCollectionToggle == .achieve
            ? 10
            : 20
    }
    
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if self.secondCollectionToggle == .achieve {
            // 좌우 패딩 30 = 60
            // spacing = 30
            let width = (self.frame.width - 40 - 10) / 2
            let height = width / 10 * 16
            return CGSize(width: width, height: height)
            
        } else {
            // 좌우 패딩 30 = 60
            // spacing = 30
            let width = (self.frame.width - 8 - 40 - 1) / 3
            let height = width / 10 * 16
            return CGSize(width: width, height: height)
        }
    }
    
    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.secondCollectionToggle == .achieve
            ? 10
            : 4
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.secondCollectionToggle == .achieve
            ? 10
            : 4
    }

    
    // MARK: - Cell_For_Row_At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.secondCollectionCell, for: indexPath) as! SecondCollectionCell

        return cell
    }

    // MARK: - Did_Select_Row_At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.secondCollectionToggle == .achieve {
            // shop(second) -> detailView로 진입
            self.secondMainDelegate?.secondTapped()
        } else {
            // MARK: - Fix
            print("home")
        }
    }
}
