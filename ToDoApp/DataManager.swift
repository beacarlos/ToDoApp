//
//  DataManager.swift
//  ToDoApp
//
//  Created by Beatriz Carlos on 14/04/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

public class DataManager {
    // get Document Directory
    static fileprivate func getDocumentDirectory () -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Não foi possivel acessar o documento no diretório.")
        }
    }
    
    // Save any kind of codable objects
    static func save <T:Encodable> (_ object : T, with fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        // Codificar para o formato Json.
        let encoder =  JSONEncoder()
        
        // validação do objeto para que possamos saber se codificou ou não.
        do {
            let data = try encoder.encode(object)
            
            // Caso já exista um arquivo com esse nome, substitui-lo.
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Load any kind of codable objects
    static func load <T: Decodable> (_ fileName: String, with type: T.Type) -> T {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        // verifica se o arquivo existe
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("O arquivo não existe no diretorio \(url.path).")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Dados indisponiveis do diretorio \(url.path).")
        }
    }
    
    // Load data from a file
    static func load (_ fileName: String) -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        // verifica se o arquivo existe
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("O arquivo não existe no diretorio \(url.path).")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
           return data
        } else {
            fatalError("Dados indisponiveis do diretorio \(url.path).")
        }
    }
    
    // Load all files from a directory
    static func loadAll <T:Decodable> (_ type: T.Type) -> [T] {
        do {
            
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            
            var modelObjects = [T]()
            
            for fileName in files {
                modelObjects.append(load(fileName, with: type))
            }
            
            return modelObjects
        } catch {
            fatalError("Não foi possível carregar nenhum arquivo.")
        }
    }
    
    // Delete a file
    static func delete(_ fileName: String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
