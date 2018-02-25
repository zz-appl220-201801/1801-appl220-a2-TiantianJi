//
//  ViewController.swift
//  9photo
//
//  Created by Tiantian Ji on 2018-02-22.
//  Copyright © 2018 Tiantian Ji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var photo : UIImage!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func pick(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    @IBAction func save(_ sender: Any) {
        
        
        
        var render = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))

        for index in 0...8{
            if (index <= 2){
                render = UIGraphicsImageRenderer(bounds: CGRect(x: index*100, y: 0, width: 100, height: 100))

                let image = render.image { (context) in


                     imageView.layer.render(in: context.cgContext)

                }
                 UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//                print("uuu")
            }
            else if (index > 2 && index <= 5){
                 render = UIGraphicsImageRenderer(bounds: CGRect(x: (index - 3)*100, y: 100, width: 100, height: 100))
                let image = render.image { (context) in


                    imageView.layer.render(in: context.cgContext)

                }
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//                print("nnn")
            }else if(index > 5 && index <= 8){

                 render = UIGraphicsImageRenderer(bounds: CGRect(x: (index - 6)*100, y: 200, width: 100, height: 100))
                let image = render.image { (context) in

                    imageView.layer.render(in: context.cgContext)

                }
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//                print("mmm")

            }



        }
      
        alertGenerator()

        
        }
        
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        

         photo.draw(in: CGRect(x: 0, y: 0, width: 300, height: 300))
       UIGraphicsBeginImageContext(photo.size)
        photo.draw(at: CGPoint.zero)
        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(4)
        context.move(to: CGPoint(x: 0, y: photo.size.height*2/3))
        context.addLine(to: CGPoint(x: photo.size.width, y: photo.size.height*2/3))
        
        context.move(to: CGPoint(x: 0, y: photo.size.height/3))
        context.addLine(to: CGPoint(x: photo.size.width, y: photo.size.height/3))
        
        context.move(to: CGPoint(x: photo.size.width/3, y: 0))
        context.addLine(to: CGPoint(x: photo.size.width/3, y: photo.size.height))
        
        context.move(to: CGPoint(x: photo.size.width*2/3, y: 0))
        context.addLine(to: CGPoint(x: photo.size.width*2/3, y: photo.size.height))
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.strokePath()
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = finalImage
        
        

        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func alertGenerator(){
        let alert = UIAlertController(title: "", message: "Photo saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title:"ok", style: .default, handler: {(UIAlertAction)in self.endThis()})
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func endThis(){
        imageView.image = nil
    }


}

