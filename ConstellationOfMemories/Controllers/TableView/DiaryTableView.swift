//
//  DiaryTableView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/18.
//

import UIKit

final class DiaryTableView: UIView {
    
    // MARK: - Properties
    // header View 싱글톤
    private let headerView: HeaderView = HeaderView.shared
    
    var diaryTableDiaryDelegate: DiaryTableDiaryDelegate?
    
    var mainDiaryTableDelegate: DiaryTableMainDelegate?
    
    
    
    
    
// [Data]
    // coreData를 담을 배열 생성
    var diaryData: [Diary] = [] {
        // table_View_Reload
        didSet { self.diaryTableView.reloadData()
            dump(diaryData)
        }
    }
    
    
    
// [Toggle]
    var diaryTableEnum: DiaryTableEnum = .dirayTable {
        didSet {
            print(diaryTableEnum)
            self.diaryTableView.reloadData()
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
        
        self.addSubview(self.diaryTableView)
        self.alpha = 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




















// MARK: - UITableView
extension DiaryTableView: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Cell
    // 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Diary_Table_View
        if self.diaryTableEnum == .dirayTable {
            return MainVC.todayDiaryToggle == false
            ? self.diaryData.count + 1
            : self.diaryData.count
            
            
            
        // Achieve_Table_View
        } else {
            return self.diaryData.count
        }
    }
    
    
    
    // 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    
    // MARK: - Cell_For_Row_At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.diaryTableViewCell, for: indexPath) as! DiaryTableViewCell
        
        // Diary_Table_View
        if self.diaryTableEnum == .dirayTable {
            // 셀의 StringLabel에 Text표시
            if indexPath.row == 0 {
                cell.diaryString = MainVC.todayDiaryToggle == true
                ? "오늘 떠올린 추억"
                : "오늘 떠올릴 추억"
            } else if indexPath.row == 1 { cell.diaryString = "어제 떠올린 추억"
            } else if indexPath.row == 2 { cell.diaryString = "그저께 떠올린 추억"
            } else {
                let date = MainVC.todayDiaryToggle == false
                ? "\(diaryData[indexPath.row - 1].month)월 \(diaryData[indexPath.row - 1].day)일에 떠올린 추억"
                : "\(diaryData[indexPath.row].month)월 \(diaryData[indexPath.row].day)일에 떠올린 추억"
                cell.diaryString = date
            }
            
            
            
        // Achieve_Table_View
        } else {
            cell.diaryString = "\(diaryData[indexPath.row].month)월 \(diaryData[indexPath.row].day)일에 떠올린 추억"
        }
        
        return cell
    }
    
    
    
    // MARK: - Did_select_Row_At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Diary_Table_View
        if self.diaryTableEnum == .dirayTable {
            // 첫번째 셀
            if indexPath.row == 0 {
                // 오늘 일기를 적지 않았다면,
                if MainVC.todayDiaryToggle == false {

                    self.diaryTableDiaryDelegate?.todayDiaryFalse()
                    // fix모드로 diaryVC진입
                    self.headerView.rightButtonConfig = .fixMode

                // 오늘 일기를 적었다면
                } else {
                    // save모드로 diaryVC진입
                    self.headerView.rightButtonConfig = .saveMode
                    // DiaryVC로 데이터 보내기
                    self.diaryTableDiaryDelegate?.todayDiaryTrue(diaryData: self.diaryData[indexPath.row])
                }
                

            // 2번째 셀부터 ~~~ 마지막 셀까지
            } else if indexPath.row > 0 {
                // 오늘 일기를 적지 않았다면,
                if MainVC.todayDiaryToggle == false {
                    self.diaryTableDiaryDelegate?.todayDiaryTrue(diaryData: self.diaryData[indexPath.row - 1])
                    
                    
                    // 오늘 일기를 적었다면
                } else {
                    self.diaryTableDiaryDelegate?.todayDiaryTrue(diaryData: self.diaryData[indexPath.row])
                }
                
                // save모드로 diaryVC진입
                self.headerView.rightButtonConfig = .cannotBeModified
            }
            // 뷰 전환
                // dairy_Table -> DiaryVC
            self.mainDiaryTableDelegate?.handleTableToDiaryVC()
            
            
        // Achieve_Table_View
        } else {
            // 데이터 보내기
            self.diaryTableDiaryDelegate?.achieveDiary(diaryString: self.diaryData[indexPath.row].diaryText)
            
            // 뷰 전환
            self.mainDiaryTableDelegate?.achieveDiaryView(month: self.diaryData[indexPath.row].month, day: self.diaryData[indexPath.row].day)
        }
    }
}
