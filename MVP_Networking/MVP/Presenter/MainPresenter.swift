//
//  MainPresenter.swift
//  MVP_Networking
//
//  Created by Kirill Drozdov on 26.06.2022.
//

import Foundation
import UIKit

protocol MainPresentDelegate {
    func presentUser(user: [UserModel])
    func presentetAlert(titile:String, message: String)
}

typealias PresentDelegate = MainPresentDelegate & UIViewController

class UserPresenter {

    weak var delegate: PresentDelegate?

   public func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data, error == nil else {return}

            do{
                let users = try JSONDecoder().decode([UserModel].self, from: data)
                delegate?.presentUser(user: users)
            } catch {
                let users = [UserModel(name: "Kirill", email: "kirilldrozd12@gmail.com", username: "Kikos")]
                delegate?.presentUser(user: users)
            }
        }.resume()
    }

    func presentAlert(indexItem: Int, userArray: [UserModel]) {
        delegate?.presentetAlert(titile: userArray[indexItem].name, message: "Вы выбрали")
    }

}
