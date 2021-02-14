//
//  ViewController.swift
//  TourismApps
//
//  Created by Ghazian Fadhli Fakhrusy on 29/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tourismTableView: UITableView!
    @IBOutlet weak var profileButton: UIButton!
    var place = [PlaceData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.title = "Home"
        navigationController?.navigationBar.shadowImage = UIImage()
        
        loadJSON{
            data in self.place = data
            self.tourismTableView.reloadData()
        }
        
        tourismTableView.dataSource = self
        tourismTableView.delegate = self
        tourismTableView.register(UINib(nibName: "TourismTableViewCell", bundle: nil), forCellReuseIdentifier: "TourismCell")
        
        addTapped(parameter: profileButton)
    }

    
    func addTapped(parameter: UIButton){
        parameter.isUserInteractionEnabled = true
        parameter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.objectTapped)))
    }
    @objc func objectTapped(gesture: UIGestureRecognizer){
        let controller = ProfileTourismViewController(nibName: "ProfileTourismViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

    func loadJSON(completionHandler: @escaping ([PlaceData]) -> Void ){
        let urlAPI = URL(string: "https://tourism-api.dicoding.dev/list")
        
        let task = URLSession.shared.dataTask(with: urlAPI!) { (data, response, error) in
        
            guard let data = data else{ return }
            do{
                let result = try JSONDecoder().decode(RootPlace.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(result.places)
                }
            }
            catch{
                print(error)
                
            }
        }
        task.resume()
    }
}



extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tourismTableView.dequeueReusableCell(withIdentifier: "TourismCell", for: indexPath) as? TourismTableViewCell{
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            let newPlace = place[indexPath.row]
            cell.tourismName.text = newPlace.name
            cell.tourismAddress.text = newPlace.address
            
            let urlImg = newPlace.image
            let img = URL(string: urlImg)
            cell.tourismImage.downloaded(from: img!)
            cell.tourismImage.contentMode = UIView.ContentMode.scaleAspectFill
            cell.tourismImage.layer.cornerRadius = 20

            return cell
        }else{
            return UITableViewCell()
        }
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detail = DetailTourismViewController(nibName: "DetailTourismViewController", bundle: nil)
        detail.place = place[indexPath.row]

        self.navigationController?.pushViewController(detail, animated: true)
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

