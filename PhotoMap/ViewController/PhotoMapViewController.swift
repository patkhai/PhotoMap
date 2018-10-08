//
//  PhotoMapViewController.swift
//  PhotoMap
//
//  Created by Pat Khai on 10/4/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import MapKit

fileprivate let tagSegueIden = "location"
fileprivate let fullImageSegueIden = "showImage"

class PhotoMapViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationViewControllerDelegate, MKMapViewDelegate {
    

    @IBOutlet weak var camera: UIButton!
    var selectimage: UIImage?
    var annotations: [PhotoAnnotation] = []
    
    
    @IBOutlet weak var mapViews: MKMapView!
    
    
    func locationsPickedLocation(controller: LocationViewController, latitude: NSNumber, longitude: NSNumber) {
       
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: Double(truncating: latitude), longitude: Double(truncating: longitude))
//        let image = controller.userInfo as! UIImage
        //        let annotation = MKPointAnnotation()
        //        annotation.coordinate = locationCoordinate
        //        annotation.title = "Picture!"
        //        mapViews.addAnnotation(annotation)
        

        let annotation = PhotoAnnotation()
        annotation.coordinate = locationCoordinate
        mapViews.addAnnotation(annotation)
        
         self.navigationController?.popToViewController(self, animated: true)
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotationView"
        
        var annotationView = mapViews.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView!.canShowCallout = true
            
            let detailsButton = UIButton(type: UIButtonType.detailDisclosure)
            annotationView?.rightCalloutAccessoryView = detailsButton
        }
        
        let thumbnail = self.resize(image: self.selectimage, newSize: CGSize(width: 45, height: 45))
        
        let resizeRenderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        resizeRenderImageView.layer.borderColor = UIColor.white.cgColor
        resizeRenderImageView.layer.borderWidth = 3.0
        resizeRenderImageView.contentMode =  .scaleAspectFill
        resizeRenderImageView.image = (annotation as? PhotoAnnotation)?.photo
        annotationView?.leftCalloutAccessoryView = resizeRenderImageView

        
//        UIGraphicsBeginImageContext(resizeRenderImageView.frame.size)
//        resizeRenderImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
      
        resizeRenderImageView.image = thumbnail
        annotationView?.image = thumbnail
        
        return annotationView
    }
    
    func resize(image: UIImage?, newSize: CGSize) -> UIImage? {
        if let image = image{
            let resizeImageView = UIImageView(frame: CGRect(x: 0, y:0, width: newSize.width, height: newSize.height))
            resizeImageView.contentMode = .scaleAspectFill
            resizeImageView.image = image

            UIGraphicsBeginImageContext(resizeImageView.frame.size)
            resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let imageView = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return imageView
        }
        return nil
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegue(withIdentifier: "showImage", sender: self)
    }
    
  
    
    @IBAction func cameraAccess(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        selectimage = editedImage

        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "location", sender: editedImage)

//        selectimage.contentMode = .scaleToFill
//        selectImage.image = editedImage
        camera.isEnabled = true
        
//        shareButton.isEnabled = true
        
    }

    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location: centerLocation)
//
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locationManager.distanceFilter = 200
//        locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view.
        mapViews.delegate = self
        
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), span)
        mapViews.setRegion(sfRegion, animated: false)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let iden = segue.identifier{
            switch iden{
            case tagSegueIden:
                if let locationVC = segue.destination as? LocationViewController{
                    locationVC.delegate = self
                }
            case fullImageSegueIden:
                if let fullImageVC = segue.destination as? ImageViewController{
                    
                        fullImageVC.images = selectimage
                    
                }
            default:
                break
            }
        }
    }
    
    
}
