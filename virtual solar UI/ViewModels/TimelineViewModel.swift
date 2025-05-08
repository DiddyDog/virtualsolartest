import FirebaseFirestore
import Combine

class TimelineViewModel: ObservableObject {
    @Published var events: [TimelineEvent] = []
    private var db = Firestore.firestore()
    private var userId: String
    private var listener: ListenerRegistration?
    
    init(userId: String) {
        self.userId = userId
        fetchEvents()
    }
    
    func fetchEvents() {
        // Firebase implementation
    }
    
    deinit {
        listener?.remove()
    }
}
