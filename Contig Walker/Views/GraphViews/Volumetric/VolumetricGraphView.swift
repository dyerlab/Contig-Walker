//
//  VolumetricGraphView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import simd
import Grape
import SwiftUI
import RealityKit
import ForceSimulation

#if os(visionOS)

struct VolumetricGraphView: View {
    @State private var isRunning = true
    @State private var modelTransform: ViewportTransform = .identity.scale(by: 2.0)
    
    var sim: Simulation3D<VolumetricForce>? = nil
    
    let scaleRatio: Float = 0.0027
    var graph: Graph {
        didSet {
            self.sim = initSimulation()
        }
    }
    
    init(graph: Graph ) {
        self.graph = graph
        self.sim = initSimulation()
    }
    
    
    var body: some View {
        VStack {
            
            RealityView { content in
                
                var material = PhysicallyBasedMaterial()
                material.baseColor = PhysicallyBasedMaterial.BaseColor(tint: UIColor(white: 1.0, alpha: 0.2))
                material.roughness = PhysicallyBasedMaterial.Roughness(floatLiteral: 0.8)
                material.metallic = PhysicallyBasedMaterial.Metallic(floatLiteral: 0.2)
                
                let nodeMaterials = GroupColors.map { c in
                    var material = PhysicallyBasedMaterial()
                    material.baseColor = PhysicallyBasedMaterial.BaseColor(tint: UIColor(c) )
                    material.roughness = PhysicallyBasedMaterial.Roughness(floatLiteral: 1.0)
                    material.metallic = PhysicallyBasedMaterial.Metallic(floatLiteral: 0.01)
                    
                    material.emissiveColor = PhysicallyBasedMaterial.EmissiveColor(color: UIColor(c) )
                    material.emissiveIntensity = 0.4
                    return material
                }
                
                if let theSim = sim {
                    let positions = theSim.kinetics.position.asArray().map { pos in  simd_float3(
                        (pos[1]) * scaleRatio,
                        -(pos[0]) * scaleRatio,
                        (pos[2]) * scaleRatio + 0.15
                    )}
                    
                    let linkIDs = graph.getLinkIndices()
                    
                    /// Draw the nodes
                    for i in positions.indices {
                        let gid = graph.nodes[i].group
                        let nodeSize = graph.nodes[i].size / 1000
                        
                        let sphere = MeshResource.generateSphere(radius: Float(nodeSize) )
                        
                        let sphereEntity = ModelEntity(mesh: sphere, materials: [
                            nodeMaterials[ 0 ]
                        ])
                        
                        sphereEntity.position = positions[i]
                        
                        let label = graph.nodes[i].id
                        let labelEntity = TextEntityGenerator(theText: label )
                        labelEntity.position = simd_float3(x: 3.0*Float(nodeSize), y: Float(nodeSize), z: 0.0)
                        
                        
                        sphereEntity.addChild( labelEntity )
                        content.add(sphereEntity)
                        print( "\(gid)")
                    }
                    
                    /// Draw the links
                    for (f, t) in linkIDs {
                        content.add(
                            withCylinder(
                                from: positions[f],
                                to: positions[t],
                                material: material
                            )
                        )
                    }

                }

                
                
            } update: { content in
                    guard let animationResource = try? AnimationResource.generate(with: OrbitAnimation(trimDuration: 1)) else {return}
                    content.entities.forEach { e in
                        e.playAnimation(animationResource, transitionDuration: 1)
                    }
            }
            .frame( depth: 15.0 )
            
        }.ornament(attachmentAnchor: .scene(.bottom)) {
            Button {
                
            } label: {
                Text("PopGraphs in Space!!!!")
            }
        }
    }
    
    
    func initSimulation() -> Simulation3D< VolumetricForce > {
        
        let links = graph.edges.map { l in
            let fromID = graph.nodes.firstIndex { mn in
                mn.id == l.source
            }!
            let toID = graph.nodes.firstIndex { mn in
                mn.id == l.target
            }!
            return EdgeID(source: fromID, target: toID)
        }
        
        let sim = Simulation(
            nodeCount: graph.nodes.count,
            links: links,
            forceField: VolumetricForce()
        )
        
        for _ in 0..<720 {
            sim.tick()
        }
        return sim
        
    }
    
    
    
    func TextEntityGenerator( theText: String ) -> ModelEntity {
        let materialVar = SimpleMaterial(color: .white, roughness: 0, isMetallic: false)
        let depthVar: Float = 0.001
        
        /// TODO: Check on iOS and VisionOS if this makes it portable
        let fontVar = MeshResource.Font.systemFont(ofSize: 0.01)
        // let fontVar = UIFont.systemFont(ofSize: 0.01)
        
        
        let containerFrameVar = CGRect(x: -0.05, y: -0.1, width: 0.1, height: 0.1)
        let alignmentVar: CTTextAlignment = .center
        let lineBreakModeVar : CTLineBreakMode = .byWordWrapping
        let textMeshResource : MeshResource = .generateText( theText,
                                                             extrusionDepth: depthVar,
                                                             font: fontVar,
                                                             containerFrame: containerFrameVar,
                                                             alignment: alignmentVar,
                                                             lineBreakMode: lineBreakModeVar)
        
        let textEntity = ModelEntity(mesh: textMeshResource, materials: [materialVar])
        
        return textEntity
    }


    
    private func withCylinder(
        from fromPosition: simd_float3,
        to toPosition: simd_float3,
        material: PhysicallyBasedMaterial
    ) -> ModelEntity {
        
        
        
        
        let cylinderVector = toPosition - fromPosition
        
        // calculate the height of the cylinder as the distance between the two points
        let height = simd_length(cylinderVector)
        let direction = simd_normalize(cylinderVector)
        
        // calculate the midpoint position
        let midpoint = SIMD3<Float>((fromPosition.x + toPosition.x) / 2,
                                    (fromPosition.y + toPosition.y) / 2,
                                    (fromPosition.z + toPosition.z) / 2)
        
        // create the cylinder
        let cylinder = MeshResource.generateCylinder(height: height, radius: 0.0005)
        let cylinderEntity = ModelEntity(mesh: cylinder, materials: [material])
        
        // The default cylinder is aligned along the y-axis. Assuming the 'direction' is not parallel to the y-axis,
        // calculate the quaternion to rotate from the y-axis to the desired direction.
        let yAxis = SIMD3<Float>(0, 1, 0) // default cylinder orientation
        let dotProduct = simd_dot(yAxis, direction)
        let crossProduct = simd_cross(yAxis, direction)
        
        // Using the dot product (cosine of angle) and the cross product (axis of rotation)
        // to create a quaternion representing the rotation
        let quaternion = simd_quatf(ix: crossProduct.x, iy: crossProduct.y, iz: crossProduct.z, r: 1 + dotProduct)
        
        // Normalize the quaternion to ensure valid rotation
        let rotation = simd_normalize(quaternion)
        
        // Apply the transformations
        cylinderEntity.transform = Transform(scale: SIMD3<Float>(1, 1, 1),
                                             rotation: rotation,
                                             translation: midpoint)
        
        return cylinderEntity
    }
    
    
    
}

#Preview {
    VolumetricGraphView(graph: Graph.DefaultGraph )
        .frame(minHeight: 800)
}

#else

struct VolumetricGraphView: View {
    var body: some View {
        Text("Volumetric view not available on this platform.")
    }
}

#endif
