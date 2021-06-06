//
//  Home.swift
//  UI-228
//
//  Created by にゃんにゃん丸 on 2021/06/06.
//

import SwiftUI
extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}

struct Home: View {
    @State var wish = false
    @State var endWish = false
    var body: some View {
        ZStack{
            
            VStack{
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRect().width / 1.8,height: getRect().height / 2.5)
                    .cornerRadius(10)
                
                
                Text("Happy Birthday\nBear")
                    .font(.custom("Limelight-Regular", size: 30))
                    .foregroundColor(.green)
                    .lineSpacing(15)
                    .multilineTextAlignment(.center)
                
              
                
                Button(action: doAnimation, label: {
                    Text("WISH")
                        .font(.title2)
                        .fontWeight(.light)
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .foregroundColor(.white)
                        .background(Color.primary)
                        .clipShape(Capsule())
                })
                .disabled(wish)
                    
                    
                
                
                
            }
            
            EmitterView()
                .scaleEffect(wish ? 1 : 0 ,anchor: .top)
                .opacity(wish && !endWish ? 1 : 0)
                .offset(y: wish ? 0 : getRect().height / 2)
                .ignoresSafeArea()
                
                
        }
    }
    func doAnimation(){
        
         
        withAnimation(.spring()){
            
            wish = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation{
                
                
                endWish = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                
                withAnimation(.spring()){
                    
                    
                    wish = false
                    endWish = false
                }
                
                
            }
            
        }
        
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct EmitterView :UIViewRepresentable  {
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let emmiterLayer = CAEmitterLayer()
        emmiterLayer.emitterShape = .line
        emmiterLayer.emitterCells = createEmmitercells()
        emmiterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        
        emmiterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(emmiterLayer)
        
    
        
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    func createEmmitercells() -> [CAEmitterCell]{
        
        var emmitercells : [CAEmitterCell] = []
        
        
        for index in 1...12{
            
            let cell = CAEmitterCell()
            
            cell.contents = UIImage(named: getImageIndex(index: index))?.cgImage
          
            
            cell.color = getColor().cgColor
            
            cell.birthRate = 10
            cell.lifetime = 10
            cell.velocity = 160
            cell.scale = 1
            cell.emissionLatitude = .pi
            cell.emissionRange = 0.3
            cell.spin = 200
            cell.spinRange = 1
            cell.yAcceleration = 30
            
            emmitercells.append(cell)
        }
        
        return emmitercells
        
        
        
        
        
    
        
    }
    
    func getImageIndex(index : Int) ->String{
        
        
        if index < 4{
            
            return "rectangle"
        }
        
        if index > 5 && index <= 8{
            
            return "circle"
        }
        
        else{
            
            return "triangle"
        }
        
    }
    
    func getColor()->UIColor{
        
        
        let colors : [UIColor] = [.systemBlue,.systemRed,.systemGreen,.systemGray5]
        
        return colors.randomElement()!
    }
    
    
    
     

    
}


