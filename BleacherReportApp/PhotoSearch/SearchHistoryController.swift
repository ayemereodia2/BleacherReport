//
//  SearchHistoryController.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit


  import UIKit

  protocol SearchHistoryViewControllerDelegate: class {
      func userDidSelect(searchText: String) -> Void
  }

  class SearchHistoryController: UIViewController {
      
      @IBOutlet weak var searchTableView: UITableView?
      weak var delegate: SearchHistoryViewControllerDelegate?
  }


  extension SearchHistoryController {
      
      override func viewDidLoad() {
          super.viewDidLoad()
        searchTableView?.tableFooterView = UIView(frame:.zero)
          searchTableView?.keyboardDismissMode = .onDrag
      }
      // CGRect(x: 0, y: 0, width: view.frame.size.width, height: 0)
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
      
      func reloadTableView() -> Void {
          searchTableView?.reloadData()
      }

  }


  extension SearchHistoryController: UITableViewDataSource, UITableViewDelegate {
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return SearchHistoryManager.history.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
          cell.textLabel?.text = SearchHistoryManager.history[indexPath.row]
          return cell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          delegate?.userDidSelect(searchText: SearchHistoryManager.history[indexPath.row])
      }
  }
