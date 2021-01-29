//
//  main.swift
//  fbx
//
//  Created by Hiroaki ENDOH on 2021/01/06.
//

import Foundation
import ArgumentParser
import SwiftyFBX

struct RuntimeError: Error, CustomStringConvertible {
    var description: String
    init(_ description: String) {
        self.description = description
    }
}

struct FBXCommand: ParsableCommand {
    static var _commandName: String {
        return "fbx"
    }
    
    static var configuration = CommandConfiguration(
        abstract: "A utility for the FBX.",
        version: "0.0.1",
        subcommands: [Info.self],
        defaultSubcommand: Info.self)
}

extension FBXCommand {
    struct Info: ParsableCommand {
        static var _commandName: String {
            return "info"
        }

        static var configuration = CommandConfiguration(abstract: "Print values in the FBX file.")

        // filename
        // e.g., "/Applications/Autodesk/FBX SDK/2020.0.1/samples/UVSample/sadface.fbx"
        @Argument(help: "FBX file path")
        var filePath: String?

        mutating func run() throws {
            guard let path = self.filePath else {
                throw(RuntimeError("Required the FBX file path."))
            }

            let fileURL = URL(fileURLWithPath: path)
            guard FileManager.default.fileExists(atPath: fileURL.relativePath) else {
                throw(RuntimeError("Not found the FBX file."))
            }
            
            let fbx = FBXLoader.load(url: fileURL)
            print("Version: " + fbx.format.versionString)
            print("Meshs: \(fbx.meshs.count) (\(fbx.getPolygonCount()) polygons)")
            print("Textures: \(fbx.textures.count)")
            fbx.textures.forEach { (texture) in
                if let url = texture.url {
                    print("\t - " + url.relativePath)
                } else {
                    print("\t - Nothing path in FBX")
                }
            }
            print("Skeletons: \(fbx.skeletons.count)")
            print("Cameras: \(fbx.cameras.count)")
//            fbx.cameras.forEach { (camera) in
//                print("\t - " + camera.name())
//            }
            print("Lights: \(fbx.lights.count)")
//            fbx.lights.forEach { (light) in
//                print("\t - " + light.name())
//            }
        }
    }
}

FBXCommand.main()
