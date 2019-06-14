//
//  MediaDetailViewModel.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 10/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit

class MediaDetailViewModel {
    
    var tableView:UITableView?
    var collectionView:UICollectionView?
    var media:Media?
    
    init() {
        
    }
    
    convenience init(with media:Media) {
        self.init()
        self.media = media
    }
    
    convenience init(with tableView:UITableView) {
        self.init()
        self.tableView = tableView
    }
    
     convenience init(with collectionView:UICollectionView) {
        self.init()
        self.collectionView = collectionView
    }
    
    convenience init(for media:Media, with tableView:UITableView) {
        self.init()
        self.tableView = tableView
        self.media = media
    }
    
    convenience init(for media:Media, with collectionView:UICollectionView) {
        self.init()
        self.collectionView = collectionView
        self.media = media
    }
    
    func posterURL() -> URL? {
        var path:String = ""
        
        if let posterPath = (media as? Movie)?.posterPath {
            path = "\(Environment().imageURL)t/p/original\(posterPath)"
        }
        if let posterPath = (media as? TVShow)?.posterPath {
            path = "\(Environment().imageURL)t/p/original\(posterPath)"
        }
        
        return URL(string: path)
    }
    
    func backdropURL() -> URL? {
        var path:String = ""
        
        if let movieBackdropPath = (media as? Movie)?.backdropPath {
            path = "\(Environment().imageURL)t/p/original\(movieBackdropPath)"
        }
        if let tvshowBackdropPath = (media as? TVShow)?.backdropPath {
            path = "\(Environment().imageURL)t/p/original\(tvshowBackdropPath)"
        }
        
        return URL(string: path)
    }
    
    func title() -> String {
        var title:String = ""
        
        if let movie = media as? Movie {
            title = movie.title
        }
        if let tvshow = media as? TVShow {
            title = tvshow.name
        }
        
        return title
    }
    
    func overview() -> String {
        var overview:String = ""
        
        if let movie = media as? Movie {
            overview = movie.overview!
        }
        if let tvshow = media as? TVShow {
            overview = tvshow.overview!
        }
        
        return overview
    }
    
    func tagline() -> String {
        var tagline:String = ""
        if let movie = media as? Movie {
            if let t = movie.tagline {
                tagline = t
            }
        }
        return tagline
    }
    
    func genres() -> [Genre] {
        var genres:[Genre]? = []
        
        if let moviesGenres = (media as? Movie)?.genres {
            genres!.append(contentsOf: moviesGenres)
        }
        if let tvshowGenres = (media as? TVShow)?.genres {
            genres!.append(contentsOf: tvshowGenres)
        }
        
        return genres!
    }
    
    func summary() -> [String:String] {
        var summary:[String:String]? = Dictionary()
        
        if let rating = self.rating() {
            summary!["Rating:"] = rating
        }
        if let popularity = self.popularity() {
            summary!["Popularity:"] = popularity
        }
        if let runningTime = self.runningTime() {
            summary!["Running time:"] = runningTime
        }
        if let releaseDate = self.releaseDate() {
            summary!["Release date:"] = releaseDate
        }
        if let seasons = self.seasons() {
            summary!["Seasons:"] = seasons
        }
        if let language = self.language() {
            summary!["Language:"] = language
        }
        
        return summary!
    }
    
    func rating() -> String? {
        var rating:String = "⭐️ "
        
        if let movie = media as? Movie {
            rating.append("\(movie.voteAverage!)")
        }
        if let tvshow = media as? TVShow {
            rating.append("\(tvshow.voteAverage!)")
        }
        
        return rating
    }
    
    func popularity() -> String? {
        var popularity:String?
        
        if let movie = media as? Movie {
            popularity = "\(movie.popularity!)"
        }
        if let tvshow = media as? TVShow {
            popularity = "\(tvshow.popularity!)"
        }
        
        return popularity
    }
    
    func runningTime() -> String? {
        var runningTime:String?
        
        if let movieRuntime = (media as? Movie)?.runtime {
            runningTime = ("\(movieRuntime)")
        }
        
        return runningTime
    }
    
    func releaseDate() -> String? {
        var releaseDate:String?
        
        if let movie = media as? Movie {
            releaseDate = movie.releaseDate!
        }
        if let tvshow = media as? TVShow {
            releaseDate = tvshow.firstAirDate!
        }
        
        return releaseDate
    }
    
    func seasons() -> String? {
        var seasons:String?
        
        if let tvshowSeasons = (media as? TVShow)?.seasons {
            seasons = "\(tvshowSeasons.count)"
        }
        
        return seasons
    }
    
    func language() -> String? {
        var language:String?
        
        if let movie = media as? Movie {
            language = ("\(movie.originalLanguage!)")
        }
        if let tvshow = media as? TVShow {
            language = ("\(tvshow.originalLanguage!)")
        }
        
        return language?.uppercased()
    }
    
    func website(button: UIButton) {
        
        var homepage:String?
        
        if let movieHomePage = (media as? Movie)?.homepage {
            homepage = movieHomePage
        }
        if let tvshowHomePage = (media as? TVShow)?.homepage {
            homepage = tvshowHomePage
        }
        
        if let web = homepage {
            button.setTitle(web, for: .normal)
            button.addTarget(self, action:#selector(openWebsite), for: .touchUpInside)
        }else {
            button.removeFromSuperview()
        }
    }
    
    @objc func openWebsite(sender: UIButton) {
        if let url = URL(string: sender.currentTitle!) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    func overviewTableViewCell(for media:Media) -> OverviewTableViewCell {
        let c:OverviewTableViewCell = tableView!.dequeueReusableCell(withIdentifier: "OverviewTableViewCell") as! OverviewTableViewCell
        c.media = media
        return c
    }
    
    func genreCollectionViewCell(for genre:Genre, and indexPath:IndexPath) -> GenreCollectionViewCell {
        let c:GenreCollectionViewCell = collectionView!.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        c.genre = genre
        return c
    }
    
    func summaryTableViewCell(for media:Media) -> SummaryTableViewCell {
        let c:SummaryTableViewCell = tableView!.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
        c.media = media
        return c
    }
    
    func summaryDetailTableViewCell(with title:String, and detail:String) -> SummaryDetailsTableViewCell {
        let c:SummaryDetailsTableViewCell = tableView!.dequeueReusableCell(withIdentifier: "SummaryDetailsTableViewCell") as! SummaryDetailsTableViewCell
        c.titleLabel.text = title
        c.detailLabel.text = detail
        return c
    }
    
    func creditsTableViewCell(for credits:[Any]) -> CreditsTableViewCell {
        let c:CreditsTableViewCell = tableView!.dequeueReusableCell(withIdentifier: "CreditsTableViewCell") as! CreditsTableViewCell
        c.credits = credits
        return c
    }
    
    func relatedVideosTableViewCell(for videos:[Video]) -> RelatedVideosTableViewCell {
        let c:RelatedVideosTableViewCell = tableView!.dequeueReusableCell(withIdentifier: "RelatedVideosTableViewCell") as! RelatedVideosTableViewCell
        c.videos = videos
        return c
    }
    
    func videoCollectionViewCell(for video:Video, and indexPath:IndexPath) -> VideoCollectionViewCell {
        let c:VideoCollectionViewCell = collectionView!.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        c.video = video
        return c
    }
    
    func similarMediaViewCell(with title:String, and list:[Media]) -> DefaultMediaListTableViewCell {
        let c:DefaultMediaListTableViewCell = tableView!.dequeueReusableCell(withIdentifier: "DefaultMediaListTableViewCell") as! DefaultMediaListTableViewCell
        c.dataSource = list
        c.titleLabel.text = title
        return c
    }
    
    func genreTableViewCell(for genre:Genre) -> GenreTableViewCell {
        let c:GenreTableViewCell = tableView!.dequeueReusableCell(withIdentifier: "GenreTableViewCell") as! GenreTableViewCell
        c.genre = genre
        return c
    }
    
}
