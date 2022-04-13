//
//  OrientationDataView.swift
//  SPM_BubbleLevel
//
//  Created by Luiz Araujo on 13/04/22.
//

import SwiftUI

struct OrientationDataView: View {
    @EnvironmentObject var detector: MotionDetector
    
    var rollString: String {
        detector.roll.describeAsFixedLengthString()
    }
    
    var pitchString: String {
        detector.pitch.describeAsFixedLengthString()
    }
    
    
    
    var body: some View {
        VStack {
            Text("Horizontal: " + rollString)
                .font(.system(.body, design: .monospaced))
            Text("Vertical: " + pitchString)
                .font(.system(.body, design: .monospaced))
        }
    }
}

struct OrientationDataView_Previews: PreviewProvider {
    static var previews: some View {
        OrientationDataView()
    }
}
