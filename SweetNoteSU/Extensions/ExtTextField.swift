import SwiftUI


extension View {
    func customTextField(color: Color, opacity: Double, corner1: UIRectCorner, corner2: UIRectCorner) -> some View {
        
            self.frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.gray.opacity(0.2))
            .roundedCorner(20, corners: [corner1, corner2])
            .shadow(color: color.opacity(opacity), radius: 2, x: 0, y: 2)
            .multilineTextAlignment(.center)
         
    }
}
