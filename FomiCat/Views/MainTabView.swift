import SwiftUI

struct MainTabView: View {
    @StateObject private var catState = CatState()
    
    var body: some View {
        TabView {
            CatView(catState: catState)
                .tabItem {
                    Label("Cat", systemImage: "cat.fill")
                }
            
            FeedView(catState: catState)
                .tabItem {
                    Label("Feed", systemImage: "bowl.fill")
                }
            
            PlayView(catState: catState)
                .tabItem {
                    Label("Play", systemImage: "star.fill")
                }
            
            SleepView(catState: catState)
                .tabItem {
                    Label("Sleep", systemImage: "moon.fill")
                }
        }
    }
} 