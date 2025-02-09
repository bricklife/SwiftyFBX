//
//  ContentView.swift
//  iOS Sample
//
//  Created by Shinichiro Oba on 2023/04/18.
//

import SwiftUI
import SwiftyFBX

struct ContentView: View {
    var body: some View {
        VStack {
            Text("FBX File Loading")
        }
        .padding()
        .task {
            let url = Bundle.main.url(forResource: "humanoid", withExtension: "fbx")!
            let fbx = FBXLoader.load(url: url)
            parse(fbx: fbx)
        }
    }
    
    func parse(fbx: FBX) {
        print("Version: " + fbx.format.versionString)
        
        print("File header info:")
        print("\t - Creator: " + (fbx.fileHeaderInfo?.creator ?? ""))
        
        var axisStr: String = ""
        switch fbx.axis.up {
        case FBXUpVector.X:
            axisStr = "X Up"
        case FBXUpVector.Y:
            axisStr = "Y Up"
        case FBXUpVector.Z:
            axisStr = "Z Up"
        default:
            axisStr = "Unknown"
        }
        switch fbx.axis.front {
        case FBXFrontVector.parityEven:
            axisStr += ", Parity even"
        case FBXFrontVector.parityOdd:
            axisStr += ", Parity odd"
        default:
            axisStr += ", Unknown"
        }
        print("Axis: \(axisStr)")
        
        print("Scene document info:")
        print("\t - FileName: \(fbx.info.fileName)")
        print("\t - Title: \(fbx.info.title)")
        print("\t - Author: \(fbx.info.author)")
        print("\t - Application: \(fbx.info.applicationVender) \(fbx.info.applicationName) \(fbx.info.applicationVersion)")
        
        print("Meshs: \(fbx.meshs.count) (\(fbx.getPolygonCount()) polygons)")
        fbx.meshs.forEach { (mesh) in
            print("\t - Name: " + (mesh.name == "" ? "Unknown" : mesh.name))
            print("\t\t - Polygon Count: \(mesh.polygonCount)")
            
            print("\t\t - Polygon Vertex: \(mesh.polygonVertexCount) counts")
            let vertices = mesh.getPolygonVertices()
            for (i, vertex) in zip(vertices.indices, vertices){
                print("\t\t\t - \(i+1): \(vertex.x), \(vertex.y), \(vertex.z)")
            }
            
            print("\t\t - Control Points: \(mesh.controlPointsCount) counts")
            for (i, position) in zip(mesh.controlPoints.indices, mesh.controlPoints){
                print("\t\t\t - \(i+1): \(position.x), \(position.y), \(position.z)")
            }
            
            let normals = mesh.getPolygonVertexNormals()
            print("\t\t - Polygon Vertex Normal: \(normals.count) counts")
            for (i, normal) in zip(normals.indices, normals){
                print("\t\t\t - \(i+1): \(normal.x), \(normal.y), \(normal.z)")
            }
            
            print("\t\t - Element Normal: \(mesh.elementNormalCount) counts")
            
            print("\t\t - Local translation (x,y,z): \(mesh.translation.x) \(mesh.translation.y) \(mesh.translation.z)")
            print("\t\t - Local rotation (x,y,z): \(mesh.rotation.x) \(mesh.rotation.y) \(mesh.rotation.z)")
            print("\t\t - Local scale (x,y,z): \(mesh.scale.x) \(mesh.scale.y) \(mesh.scale.z)")
        }
        print("Textures: \(fbx.textures.count)")
        fbx.textures.forEach { (texture) in
            if let url = texture.url {
                print("\t - " + url.relativePath)
            } else {
                print("\t - Nothing path in FBX")
            }
        }
        print("Materials: \(fbx.materials.count)")
        fbx.materials.forEach { (material) in
            print("\t - Name: " + (material.name == "" ? "Unknown" : material.name))
            print("\t\t - UUID: " + "\(material.uuid)")
            print("\t\t - Initial Name: " + "\(material.initialName)")
            print("\t\t - Shading Model: " + "\(material.shadingModel)")
            print("\t\t - Is Phong: " + "\(material.isPhong)")
            print("\t\t - Is Lambert: " + "\(material.isLambert)")
            print("\t\t - Ambient: " +
                  "R: \(material.ambient.red), " +
                  "G: \(material.ambient.green), " +
                  "B: \(material.ambient.blue)" )
            print("\t\t - Diffuse: " +
                  "R: \(material.diffuse.red), " +
                  "G: \(material.diffuse.green), " +
                  "B: \(material.diffuse.blue)" )
            print("\t\t - Specular: " +
                  "R: \(material.specular.red), " +
                  "G: \(material.specular.green), " +
                  "B: \(material.specular.blue)" )
            print("\t\t - Specular Factor: " + "\(material.specularFactor)")
            print("\t\t - Emissive: " +
                  "R: \(material.emissive.red), " +
                  "G: \(material.emissive.green), " +
                  "B: \(material.emissive.blue)" )
            print("\t\t - Shininess: " + "\(material.shininess)")
            print("\t\t - Transparency Color: " +
                  "R: \(material.transparencyColor.red), " +
                  "G: \(material.transparencyColor.green), " +
                  "B: \(material.transparencyColor.blue)" )
            print("\t\t - Transparency Factor: " + "\(material.transparencyFactor)")
            print("\t\t - Reflection Color: " +
                  "R: \(material.reflectionColor.red), " +
                  "G: \(material.reflectionColor.green), " +
                  "B: \(material.reflectionColor.blue)" )
            print("\t\t - Reflection Factor: " + "\(material.reflectionFactor)" )
        }
        print("Skeletons: \(fbx.skeletons.count)")
        print("Cameras: \(fbx.cameras.count)")
        fbx.cameras.forEach { (camera) in
            print("\t - Name: " + (camera.name == "" ? "Unknown" : camera.name))
            print("\t\t - Format code: " + "\(camera.format.rawValue)")
            print("\t\t - Postion (x, y, z): " + "\(camera.position.x), " + "\(camera.position.y), " + "\(camera.position.z)")
        }
        print("Lights: \(fbx.lights.count)")
        fbx.lights.forEach { (light) in
            print("\t - Name: " + (light.name == "" ? "Unknown" : light.name))
            print("\t\t - LightType: " + "\(light.lightTypeName)")
            print("\t\t - Local translation (x,y,z): \(light.translation.x) \(light.translation.y) \(light.translation.z)")
        }
        //            print("Poses: \(fbx.poses.count)")
        //            fbx.poses.forEach { (pose) in
        //                print("\t - Name: " + (pose.name == "" ? "Unknown" : pose.name))
        //            }
        print("Animations: \(fbx.animationStacks.count)")
        fbx.animationStacks.forEach { (animationStack) in
            print("\t - Name: " + (animationStack.name == "" ? "Unknown" : animationStack.name))
            print("\t\t - Frames: \(animationStack.frameCount)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
