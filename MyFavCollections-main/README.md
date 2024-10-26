# Favorite Movies Collection iOS App

## Project Description
This iOS application showcases a collection of classic movies in an elegant grid layout. Built using UIKit and featuring a custom UICollectionView implementation, the app demonstrates modern iOS development practices while providing an engaging user interface for browsing movie information.

## Project results
<img width="1430" alt="Screenshot 2024-10-25 at 23 24 49" src="https://github.com/user-attachments/assets/122799ed-0f18-49d9-a089-f484f48de2a8">

## Video
https://github.com/user-attachments/assets/690aef90-f341-41ae-8c6d-ff74e724689d

### Key Features
- Grid-based collection view displaying movie posters
- Custom-designed collection view cells with movie details
- Smooth scrolling and responsive layout
- Movie information display including title, year, and genre
- Interactive cells with tap gesture support
- Shadow and corner radius effects for modern UI appearance
- Adaptive layout that works across different iOS devices
- Support for dark and light mode

## Chosen Theme Explanation
I chose the "Favorite Movies" theme for this project because:
1. Movies provide rich visual content through their posters, making the UI naturally engaging
2. Movie data has multiple interesting attributes (title, year, genre) that work well in a collection view format
3. The content is universally relatable and easy to understand
4. Movie posters naturally lend themselves to a grid layout, similar to popular streaming services

The selected movies represent various genres and decades, showcasing the versatility of the design:
- Classic films (The Godfather, Pulp Fiction)
- Sci-fi blockbusters (Inception, The Matrix)
- Drama masterpieces (The Shawshank Redemption, Forrest Gump)
- Modern epics (Interstellar, The Dark Knight)

## Setup Instructions

### Prerequisites
- Xcode 14.0 or later
- iOS 15.0+ deployment target
- macOS Monterey or later (for development)

### Installation Steps
1. Clone the repository:
   ```bash
   git clone [your-repository-url]
   ```

2. Open the project:
   ```bash
   cd [project-directory]
   open MyFavCollections.xcodeproj
   ```

3. Add movie poster images:
   - Open Assets.xcassets in Xcode
   - Create new image sets for each movie
   - Name them exactly as follows:
     - inception
     - dark_knight
     - pulp_fiction
     - matrix
     - forrest_gump
     - goodfellas
     - shawshank
     - fight_club
     - interstellar
     - godfather
   - Add your movie poster images to each image set

4. Build and run:
   - Select your target device/simulator
   - Press ⌘R or click the Play button

### Troubleshooting
- If images don't appear, verify that the image set names in Assets.xcassets match exactly with the posterName values in the MovieCollectionViewController
- Ensure all movie poster images are added to the correct image sets in Assets.xcassets
- Check that the deployment target matches your device's iOS version

## Code Structure
- `MovieCollectionViewController`: Main view controller managing the collection view
- `MovieCollectionView`: Custom cell for displaying movie information
- `MyFavCollectionsApp`: Structure defining the movie data model

## Future Enhancements
Potential improvements that could be added:
- Movie detail view with additional information
- Search and filter functionality
- Favorite/bookmark feature
- Movie rating display
- Trailer video integration
- Category sorting options

## Credits
Created by Saken Zholbarys for iOS Development Assignment #7
Movie posters sourced from respective movie studios
