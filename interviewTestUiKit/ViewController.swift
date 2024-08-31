//
//  ViewController.swift
//  interviewTestUiKit
//
//  Created by Nandhu Selvan on 31/08/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiPgCont: UIPageControl!
    @IBOutlet weak var uiCollView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var uiTableView: UITableView!
    
    
    
    private let fabButton: UIButton = {
           let button = UIButton(type: .system)
           button.setImage(UIImage(systemName: "plus"), for: .normal)
           button.backgroundColor = .systemBlue
           button.tintColor = .white
           button.layer.cornerRadius = 25
           button.layer.masksToBounds = true
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
    var nameList = ["lamboHini", "GTR","Nission","Mustang","Inova","Badmini","Toyotta","Hundai","Maruthi","Suzuki","Honda"]
    
    var ContList = ["$ 400", "$ 500","$ 300","$2000","$ 2300","$ 3400","$ 300","$ 900","$ 866","$ 500","$ 600"]
    
    var filteredNameList: [String] = []
       var filteredContList: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        uiTableView.separatorStyle = .none
        uiCollView.dataSource = self
        uiCollView.dataSource = self
        uiTableView.dataSource = self
        uiTableView.delegate = self
        searchBar.delegate = self
        uiCollView.register(uiListCollectionViewCell.nib(), forCellWithReuseIdentifier: uiListCollectionViewCell.identifier)
        uiTableView.register(uiListTableViewCell.nib(), forCellReuseIdentifier: uiListTableViewCell.identifier)
    
        // Do any additional setup after loading the view.
        
        
        uiPgCont.numberOfPages = 5 // Update this based on your data
        uiPgCont.currentPage = 0
        uiPgCont.pageIndicatorTintColor = .lightGray
        uiPgCont.currentPageIndicatorTintColor = .black
        uiPgCont.translatesAutoresizingMaskIntoConstraints = false
        
        filteredNameList = nameList
        filteredContList = ContList
        
        
        
        
        view.addSubview(fabButton)
                NSLayoutConstraint.activate([
                    fabButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    fabButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
                    fabButton.widthAnchor.constraint(equalToConstant: 50),
                    fabButton.heightAnchor.constraint(equalToConstant: 50)
                ])
                
                fabButton.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
           
    }
    @objc private func showBottomSheet() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.filteredNameList = filteredNameList // Pass the data
        bottomSheetVC.modalPresentationStyle = .pageSheet
        bottomSheetVC.modalTransitionStyle = .coverVertical
        present(bottomSheetVC, animated: true, completion: nil)
    }

}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vc = collectionView.dequeueReusableCell(withReuseIdentifier:uiListCollectionViewCell.identifier, for: indexPath)as! uiListCollectionViewCell
        vc.configure(with: UIImage(named: "uiCollection")!)
        return vc
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let pageWidth = scrollView.frame.size.width
           let page = Int(scrollView.contentOffset.x / pageWidth)
        uiPgCont.currentPage = page
       }
    
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNameList.isEmpty == true ? filteredContList.count : filteredNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Vc = tableView.dequeueReusableCell(withIdentifier: uiListTableViewCell.identifier, for: indexPath) as! uiListTableViewCell
        
        Vc.configure(with: UIImage(named: "uiCollection")!)
        Vc.hLb.text = filteredNameList[indexPath.row]
               Vc.contLb.text = filteredContList[indexPath.row]
        
        
        return Vc
    }
    
    
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // Show all items if search text is empty
            filteredNameList = nameList
            filteredContList = ContList
        } else {
            // Filter items based on search text
            let lowercasedSearchText = searchText.lowercased()
            let filteredIndices = nameList.indices.filter { nameList[$0].lowercased().contains(lowercasedSearchText) }
            
            filteredNameList = filteredIndices.map { nameList[$0] }
            filteredContList = filteredIndices.map { ContList[$0] }
        }
        uiTableView.reloadData()
    }
}


