//
//  ExploreTabBarController.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/18/21.
//

import UIKit

class ExploreTabBarController: UIViewController{

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var subCategoriesTableView: UITableView!
    
    var categoriesArray : [Categories] = [Categories]()
    var subCatgeoryArray : [SubCategory] = [SubCategory]()
    var categoriesViewModel : CategoriesViewModel!
    var categoryName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        
        subCategoriesTableView.dataSource = self
        subCategoriesTableView.delegate = self
        
        categoriesViewModel = CategoriesViewModel()
        
        categoriesViewModel.bindCategoriesViewModelToView = {
                    
            self.onSuccessUpdateView()
            
        }
        
        categoriesViewModel.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
            
        }
        
    }
    
    func onSuccessUpdateView(){
        
        categoriesArray = categoriesViewModel.categoryData
        self.categoriesCollectionView.reloadData()
        
    }
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: categoriesViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

