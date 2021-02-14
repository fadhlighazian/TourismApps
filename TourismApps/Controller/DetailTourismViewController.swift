//
//  DetailTourismViewController.swift
//  TourismApps
//
//  Created by Ghazian Fadhli Fakhrusy on 30/11/20.
//

import UIKit
import MapKit

class DetailTourismViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailAddress: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailLikes: UILabel!
    
    @IBOutlet weak var iconMap: UIImageView!
    @IBOutlet weak var mapKit: MKMapView!
    
    var place: PlaceData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Detail"
        
        if let result = place{
            detailName.text = result.name
            detailAddress.text = result.address
            detailDescription.text = result.description
            detailLikes.text = "\(result.like) Likes"
            
            let urlImg = result.image
            let img = URL(string: urlImg)
            detailImage.downloaded(from: img!)
            detailImage.contentMode = UIView.ContentMode.scaleAspectFill
            
            let lat = result.latitude
            let long = result.longitude
            
            let anotation = MKPointAnnotation()
            anotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            anotation.title = detailName.text
            mapKit.addAnnotation(anotation)
            
            let region = MKCoordinateRegion(center: anotation.coordinate, latitudinalMeters: 250000, longitudinalMeters: 250000)
            mapKit.setRegion(region, animated: true)

        }
        
    }
    

}
