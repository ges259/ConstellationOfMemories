//
//  HomeSecondCollection.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/29.
//

import UIKit

final class HomeFirstView: UIView {
    
    // MARK: - Properties
    
    // home_Header의 segemet가 바뀌면 이 변수의 값이 바뀜
        // dawn / morning / sunset / night
    var currentTime: CurrentTime = .dawn {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.firstCollection.alpha = 0
                
                
            } completion: { _ in
                self.firstCollection.reloadData()
                
                
                UIView.animate(withDuration: 0.5) {
                    self.firstCollection.alpha = 1
                }
            }
        }
    }
    
    
    // 셀에 background_image를 표시하기 위한 데이터
    var backgroundData: HaveImg?
    
    
    
    // Delegate
    var firstHomeDelegate: FirstHomeDelegate?

    
    
    
    
    
    
    
    
    // MARK: - Layout
    lazy var firstCollection: UICollectionView = {
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
        
            view.register(HomeFirstCell.self, forCellWithReuseIdentifier: ReuseIdentifier.homeFirstCollection)
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
        self.addSubview(self.firstCollection)
    }
    
    private func upCollectionView() {
        // item이 항상 맨위로 가도록 설정
        self.firstCollection.scrollToItem(at: IndexPath(item: 0, section: 0),
                                          at: .top, animated: true)
    }
    
    
    // MARK: - API
    
    
    
    
}











// MARK: - CollectionView
extension HomeFirstView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.currentTime {
        case .dawn:
            return self.backgroundData?.havedawn.count ?? 0
            
        case .morning:
            return self.backgroundData?.haveMorning.count ?? 0
            
        case .sunset:
            return self.backgroundData?.haveSunset.count ?? 0
            
        case .night:
            return self.backgroundData?.haveNight.count ?? 0
        }
    }
    
    // Cell_For_Row_At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.homeFirstCollection, for: indexPath) as! HomeFirstCell
        
        
        if let backgroundData = backgroundData {
            switch self.currentTime {
            case .dawn:
                cell.haveImage.image = UIImage(named: "\(backgroundData.havedawn[indexPath.row])")
                break
                
            case .morning:
                cell.haveImage.image = UIImage(named: "\(backgroundData.haveMorning[indexPath.row])")
                break
                
            case .sunset:
                cell.haveImage.image = UIImage(named: "\(backgroundData.haveSunset[indexPath.row])")
                break
                
            case .night:
                cell.haveImage.image = UIImage(named: "\(backgroundData.haveNight[indexPath.row])")
                break
            }
        }
        return cell
    }


    // Did_Select_Row_At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        guard let backgroundData = self.backgroundData else { return }
        
        self.firstHomeDelegate?.homeFirstTapped(index: indexPath.row,
                                                  backgroundImg: backgroundData)
    }
    
    
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 좌우 패딩 30 = 60
        // spacing = 30
        let width = (self.frame.width - 8 - 40 - 1) / 3
        let height = width / 10 * 16
        return CGSize(width: width, height: height)
    }

    
    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
