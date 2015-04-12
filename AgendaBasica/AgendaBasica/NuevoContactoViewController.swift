//
//  NuevoContactoViewController.swift
//  AgendaBasica
//
//  Created by Carlos Butron on 30/11/14.
//  Copyright (c) 2014 Carlos Butron.
//
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public 
//  License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
//  version.
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//  You should have received a copy of the GNU General Public License along with this program. If not, see 
//  http:/www.gnu.org/licenses/.
//

import UIKit

protocol NuevoContactoDelegate {
    func nuevoContacto(contacto: Contacto)
}

class NuevoContactoViewController: UIViewController {

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidosTextField: UITextField!
    @IBOutlet weak var telefonoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var delegate: NuevoContactoDelegate?
    
    @IBAction func guardarPushButton(sender: AnyObject) {
        
        var contacto = Contacto()
        
        contacto.nombre = nombreTextField.text
        contacto.apellidos = apellidosTextField.text
        contacto.telefono = telefonoTextField.text
        contacto.email = emailTextField.text
        
        delegate?.nuevoContacto(contacto)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func cancelarPushButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
