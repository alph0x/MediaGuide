//
//  DefaultMediaListRouter.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class DefaultMediaListRouter: NSObject {
    
    
    func genresList(for genres: [Genre], with mode:MediaMode, on viewController: UIViewController) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let genresFilter:GenresFilterViewController = main.instantiateViewController(withIdentifier: "GenresFilterViewController") as! GenresFilterViewController
        genresFilter.mode = mode
        genresFilter.genres = genres
        genresFilter.title = "Genres"
        
        let navigationController = UINavigationController(rootViewController: genresFilter)
        
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.tintColor = UIColor(red:1.00, green:0.84, blue:0.00, alpha:1.0)
        
        
        viewController.present(navigationController, animated: true, completion: nil)
        
    }
    
    func defaultMediaList(for query:String, with mode:MediaMode, on viewController: UIViewController) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let defaultMediaList:DefaultMediaListViewController = main.instantiateViewController(withIdentifier: "DefaultMediaListViewController") as! DefaultMediaListViewController
        defaultMediaList.mode = mode
        defaultMediaList.query = query
        defaultMediaList.title = query
        viewController.navigationController?.pushViewController(defaultMediaList, animated: true)
    }

    func defaultMediaList(for genre:Genre, with mode:MediaMode, on viewController: UIViewController) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let defaultMediaList:DefaultMediaListViewController = main.instantiateViewController(withIdentifier: "DefaultMediaListViewController") as! DefaultMediaListViewController
        defaultMediaList.mode = mode
        defaultMediaList.genre = genre
        defaultMediaList.title = genre.name
        
        viewController.navigationController?.pushViewController(defaultMediaList, animated: true)
    }
}
