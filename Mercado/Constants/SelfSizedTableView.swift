//
//  SelfSizedTableView.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/9/21.
//

import Foundation
import UIKit

class SelfSizedTableView : UITableView{
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
      super.reloadData()
      self.invalidateIntrinsicContentSize()
      self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
      let height = min(contentSize.height, maxHeight)
      return CGSize(width: contentSize.width, height: height)
    }
}
