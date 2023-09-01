//
//  AchieveDiaryTable.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/09/02.
//

import UIKit

final class AchieveDiaryTable: UIView {
    
    // MARK: - Properties
    // coreData를 담을 배열 생성
    var diaryData: [Diary] = [] {
        // table_View_Reload
        didSet { self.achieveDiaryTable.reloadData() }
    }
    
    // header View 싱글톤
//    private let headerView: HeaderView = HeaderView.shared
    
    
    
    // Delegate
    var achieveTableMainDelegate: AchieveTableMianDelegate?
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - DiaryTable
    // 테이블 뷰 ( 리스트 뷰 )
    lazy var achieveDiaryTable: UITableView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.frame.width,
                           height: self.frame.height)
        let view = UITableView(frame: frame)
            
            view.dataSource = self
            view.delegate = self
        
            view.separatorStyle = .none
            view.backgroundColor = .clear
        
            view.register(DiaryTableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.diaryTableViewCell)
        return view
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.achieveDiaryTable)
        self.alpha = 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




















// MARK: - UITableView
extension AchieveDiaryTable: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Cell
    // 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.diaryData.count
    }
    
    
    
    // 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    
    // MARK: - Cell_For_Row_At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.diaryTableViewCell, for: indexPath) as! DiaryTableViewCell
        
            
        
        return cell
    }
    
    
    
    // MARK: - Did_select_Row_At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.achieveTableMainDelegate?.achieveTableCellTapped()
                
    }
}
