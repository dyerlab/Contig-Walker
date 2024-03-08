//
//  VolumetricForce.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import Foundation
import ForceSimulation


struct VolumetricForce: ForceField3D {
    
    var force = CompositedForce< SIMD3<Float> , _, _> {
        /*
        Kinetics3D.RadialForce(center: .zero, radius: .constant(0.1), strength: .constant(0.5))
        Kinetics3D.CenterForce(center: .zero, strength: 1)
        Kinetics3D.ManyBodyForce(strength: -4)
        Kinetics3D.LinkForce(stiffness: .constant(0.5))
         */
        Kinetics3D.CenterForce(center: .zero, strength: 1)
        Kinetics3D.ManyBodyForce(strength: -2)
        Kinetics3D.LinkForce(stiffness: .constant(0.5))
    }
    
}

