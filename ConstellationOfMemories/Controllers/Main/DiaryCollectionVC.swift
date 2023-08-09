//
////  DiaryCollectionVC.swift
////  ConstellationOfMemories
////
////  Created by 계은성 on 2023/08/08.
////
//
//import UIKit
//
//final class DiaryCollectionVC: UITableViewController {
//    
//    // MARK: - Properties
//    
//    
//    private lazy var tableViewHeader: HeaderView = {
//        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
//        
//        let view = HeaderView(frame: frame)
//        
//        return view
//    }()
//    
//
//    
//    
//    
//    
//    
//    // MARK: - LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // configure
//            // register Cell
//        self.configureDiaryCollectionVC()
//    }
//    
//    
//    
//    // MARK: - HelperFunctions
//    private func configureDiaryCollectionVC() {
//        // background Color
//        self.view.backgroundColor = .red
//        
//        // 구분선 없애기
//        self.tableView.separatorStyle = .none
//        
//        
//        // register Cell
//        self.tableView.register(DiaryCollectionCell.self,
//                                forCellReuseIdentifier: ReuseIdentifier.DiaryCollectionCell)
//        // register Header
////        self.tableView.register(DiaryCollectionHeaderView.self,
////                                forHeaderFooterViewReuseIdentifier: ReuseIdentifier.DiaryCollectionHeaderView)
//        
//        
//        self.tableView.tableHeaderView = tableViewHeader
//        
//        // DiaryCollectionHeaderView
////        self.tableViewHeader.delegate = self
//    }
//    
//    
//    
//    // MARK: - Selectors
//
//    
//    
//    
//    // MARK: - TableView
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.DiaryCollectionCell,
//                                                 for: indexPath) as! DiaryCollectionCell
//        
//        
//        
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
//    
//    
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//    
//    
//    // MARK: - Header
//    
//    
//    
//    
//    
//    
//    // MARK: - API
//    
//    
//    
//}
//
//
//
//// MARK: - DiaryCollectionVCDelegate
//// DiaryCollectionHeaderView
////extension DiaryCollectionVC: DiaryCollectionVCDelegate {
////    func handleDismiss() {
////        self.dismiss(animated: true)
////    }
////}
