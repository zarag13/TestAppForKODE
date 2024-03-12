//
//  BuilderForGetEmployee.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation
import UIKit

class BuilderForGetEmployee {
    
    func get() {
        let url = CreaterURL()
        let request = CreaterRequest(url: url)
        let decoder = JSONCodable()
        let session = CreaterSession()
        let task = CreaterTaskForSession(session: session, request: request, decoder: decoder)
        task.eployeeListGetTask(state: .code200) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    
                    
#warning("доделать данные из запроса")
                    print(" result  ---- \(Thread.current)")
                    let image1 = data.employee[0].avatarUrl
                    print(image1)
                    
                    
                    
#warning("работа с картинкой тоже прошла успешно - придумать как правильнее использовать в проекте")
                    task.employeeDownloadAvatarImageTask(url: image1) { result in
                        switch result {
                            
                        case .success(let imageData):
                            let image = UIImage(data: imageData)
                            print("Размер полученной картинки = \(String(describing: image?.size))")
                        case .failure(let error):
                            print(error)
                        }
                    }
                    
                    
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
