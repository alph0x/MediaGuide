//
//  MediaDetailRouter.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class MediaDetailRouter {
    
    func push(media: Media) {
        push(media: media, on: UIApplication.topViewController()!)
    }
    
    func push(media: Media, on viewController:UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mediaDetailViewController = storyboard.instantiateViewController(withIdentifier: "MediaDetailViewController") as! MediaDetailViewController
        mediaDetailViewController.media = media
        viewController.navigationController?.pushViewController(mediaDetailViewController, animated: true)
    }
    
}
