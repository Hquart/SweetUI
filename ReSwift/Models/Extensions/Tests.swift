import SwiftUI

struct AlertView: View {
    @State var isShowingAlert = false
    var body: some View {
        Button("Show alert") {
            isShowingAlert.toggle()
        }
        .alert("This is an alert", isPresented: $isShowingAlert) {
            Button("Cancel", role: .cancel) { }
            Button("OK", role: .none) { }
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
