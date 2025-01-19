import SwiftUI

struct SleepView: View {
    @ObservedObject var catState: CatState
    @State private var showZZZ = false
    
    var body: some View {
        VStack {
            Text(catState.isAsleep ? "Sleeping..." : "Awake")
                .font(.title)
                .padding()
            
            ZStack {
                // Cat
                Image(systemName: catState.isAsleep ? "cat.circle.fill" : "cat.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .foregroundStyle(catState.isAsleep ? .gray : .black)
                    .rotationEffect(catState.isAsleep ? .degrees(-45) : .degrees(0))
                
                // Sleep indicators
                if catState.isAsleep {
                    HStack(spacing: -10) {
                        ForEach(0..<3) { index in
                            Text("Z")
                                .font(.title)
                                .offset(y: showZZZ ? -10 : 0)
                                .animation(
                                    .easeInOut(duration: 1)
                                    .repeatForever()
                                    .delay(Double(index) * 0.3),
                                    value: showZZZ
                                )
                        }
                    }
                    .offset(x: 50, y: -30)
                }
            }
            
            Button(action: toggleSleep) {
                Text(catState.isAsleep ? "Wake Up" : "Go to Sleep")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(catState.isAsleep ? .orange : .blue)
                    )
            }
            .padding()
        }
        .onChange(of: catState.isAsleep) { _ in
            if catState.isAsleep {
                showZZZ = true
            }
        }
    }
    
    private func toggleSleep() {
        withAnimation(.spring(response: 0.5)) {
            catState.isAsleep.toggle()
            if !catState.isAsleep {
                showZZZ = false
            }
        }
    }
} 