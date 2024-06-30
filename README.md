I've developed a Flutter app with separate modules for user and admin ends.

Admin End:

Admins can select audio files from their device and upload them to Firebase Storage.
Created a Firestore collection schema: audioSongs (collection) → categoryName (document) with fields: songs (array), songName, songThumbnail, categoryName, etc.
User End:

Users sign up and log in with email/password authentication. Additional user data is stored in Firestore upon signup.
Upon login, user data is fetched and displayed.
Users can view all song categories, tap on a category to see its songs, and tap on a song to play it.
The app uses MVVM architecture with GetX, separating services and widgets. It supports both users and admins, allowing users to fetch and play songs and admins to upload them.
