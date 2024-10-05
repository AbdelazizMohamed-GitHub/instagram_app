📸 Instagram App
An Instagram-style social media app built using Flutter and Clean Architecture. This app allows users to create an account, share images, like posts, follow users, and more, all while following best practices for maintainable, scalable software design.

🌟 Features
📷 Post Photos: Capture or upload images to share with followers.
👍 Like Posts: Users can like posts and view the total like count.
💬 Comment on Posts: Users can leave comments on posts.
🔍 Explore Posts: Discover and explore posts from other users.
📝 User Profile: Users can update their profile (image, name, bio).
👥 Follow System: Follow and unfollow users, and view their posts in the feed.
💬 Real-Time Chat: Send and receive real-time messages with other users.
🛠️ Firebase Integration: Firebase for Authentication, Firestore for database, and Cloud Storage for images.
📱 Responsive Design: Cross-platform support for Android and iOS.
🛠️ Tech Stack
Flutter: For building the user interface.
Clean Architecture: A layered approach to software development ensuring testability and separation of concerns.
Cubit for State Management: Used to manage the app's state and ensure reactive UI updates.
Firebase:
Firebase Authentication: For user sign-up, login, and security.
Firestore: A NoSQL real-time database for storing app data.
Cloud Storage: For securely storing user-uploaded photos.
Dartz: For functional programming utilities.
GetIt: Dependency injection for managing instances and service location.
Image Picker: For selecting and capturing images.
🏗️ Clean Architecture
This project follows the Clean Architecture principles to ensure separation of concerns and scalability:

Domain Layer: Contains business logic, entities, and use cases.
Data Layer: Handles API calls and data sources like Firebase (Firestore and Cloud Storage).
Presentation Layer: Manages the UI and interacts with the domain layer via state management (Cubit).
Dependency Injection: Managed using GetIt to decouple components.
