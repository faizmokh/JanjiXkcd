//
//  MainController.swift
//  JanjiXkcd
//
//  Created by Faiz Mokhtar on 19/03/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
import UIKit
import PromiseKit

class MainController: UIViewController {

    let worker: APIWorkable

    init(worker: APIWorkable = APIWorker()) {
        self.worker = worker
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        worker
        .fetchCurrentComic()
        .done(on: .main) { info in
                print(info)
        }.catch { error in
            print(error)
        }
    }
}
