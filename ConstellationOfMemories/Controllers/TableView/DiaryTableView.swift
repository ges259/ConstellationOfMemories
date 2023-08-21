//
//  DiaryTableView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/18.
//

import UIKit

final class DiaryTableView: UIView {
    
    // MARK: - Properties
    
    
    
    // MARK: - Fix
    // 12시가 지나면 false로 자동으로 바꿔지도록.
    // 방법이...
        // 서버에서?
    static var todayDiaryToggle: Bool = false
    
    
    
    // coreData를 담을 배열 생성
//    var diaryData: [DiaryData] = [] {
//        didSet {
//            self.diaryTableView.reloadData()
//        }
//    }
    // header View 싱글톤
    private let headerView: HeaderView = HeaderView.shared
    
    var diaryVCTableDelegate: DiaryTableDiaryDelegate?
    
    var mainDiaryTableDelegate: DiaryTableMainDelegate?
    
    
    
    // MARK: - DiaryTable
    // 테이블 뷰 ( 리스트 뷰 )
    lazy var diaryTableView: UITableView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.frame.width,
                           height: self.frame.height)
        let view = UITableView(frame: frame)
            view.delegate = self
            view.dataSource = self
        
            view.separatorStyle = .none
            view.backgroundColor = .clear
        
            view.register(DiaryTableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.diaryTableViewCell)
        return view
    }()
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(DiaryTableView.todayDiaryToggle)
        self.addSubview(self.diaryTableView)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Helper Functions
    
    
    
    
    
    
    // MARK: - API
    
    
}





// MARK: - UITableView
extension DiaryTableView: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Cell
    // 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return DiaryTableView.todayDiaryToggle == false
//        ? self.diaryData.count + 1
//        : self.diaryData.count
        
        return 4
    }
    
    
    
    
    
    // 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    
    
    
    // MARK: - Cell_For_Row_At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.diaryTableViewCell, for: indexPath) as! DiaryTableViewCell
        
        // 셀의 StringLabel에 Text표시
        if indexPath.row == 0 {
            cell.diaryDate = DiaryTableView.todayDiaryToggle == true
            ? "오늘 떠올린 추억"
            : "오늘 떠올릴 추억"
            
            
        } else if indexPath.row == 1 { cell.diaryDate = "어제 떠올린 추억"
        } else if indexPath.row == 2 { cell.diaryDate = "그저께 떠올린 추억"
        } else {
            // dateString 옵셔널 바인딩
//            if let diaryData = self.diaryData[indexPath.row - 3].dateString {
                // 일기를 적은 날을 표시 (X월 X일 떠올리 추억)
//                cell.diaryDate = "\(diaryData) 떠올린 추억"
                cell.diaryDate = "떠올린 추억"
            
//            }
        }
        return cell
    }
    
    
    
    
    
    // MARK: - Did_select_Row_At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 첫번째 셀
        if indexPath.row == 0 {
            // 오늘 일기를 적지 않았다면,

            if DiaryTableView.todayDiaryToggle == false {

                self.diaryVCTableDelegate?.todayDiaryFalse()
                // fix모드로 diaryVC진입
                self.headerView.rightButtonConfig = .fixMode


            // 오늘 일기를 적었다면
            } else {
                // save모드로 diaryVC진입
                self.headerView.rightButtonConfig = .saveMode

//                self.diaryVCTableDelegate?.todayDiaryTrue(diaryData: self.diaryData[indexPath.row])
            }

        // 2번째 셀부터 ~~~ 마지막 셀까지
        } else if indexPath.row > 0 {
            // save모드로 diaryVC진입
            self.headerView.rightButtonConfig = .saveMode


            if DiaryTableView.todayDiaryToggle == false {
//                self.diaryVCTableDelegate?.todayDiaryTrue(diaryData: self.diaryData[indexPath.row - 1])
            } else {
//                self.diaryVCTableDelegate?.todayDiaryTrue(diaryData: self.diaryData[indexPath.row])
            }
        }
        
        // 뷰 전환
            // dairy_Table -> DiaryVC
        self.mainDiaryTableDelegate?.handleTableToDiaryVC()
    }
}
