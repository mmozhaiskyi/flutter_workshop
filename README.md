# Flutter workshop

App: Show nearest restaurants/cafes  Stack
1. foursquare.com API.
2. Google maps https://pub.dev/packages/google_maps_flutter
3. BLoC
4. Dart http
5. Floor


## Steps

# Part 1. Build home screen
1. Short Flutter intro
2. BLoC pattern intro
3. Define map point model
4. Create HomeBloc/Event/State and with mocked data inside bloc
5. Create UI which contains list of map points
6. BlocProvider intro
7. Tie up bloc elements

# Part 2. Fetch data from network
1. Implement API data source
2. Implement PointsRepository
3. Provider intro. Comparing with BlocProvider
4. Build DI multi provider
5. Fetch data from network and remove mock

# Part 3. Details screen (map on details screen)
1. Routing intro
2. Set up Google maps
3. Build details screen
4. Build widget with map
5. Implement map mode in home screen
6. Build details bloc components (useful for next part)

# Part 4. Application cache (Save as favourite feature)
1. Short Floor intro
2. Define model, DAO
3. Code generation intro
4. Generate DB
5. Implement favourites inside PointRepository
6. Add favourites screen (route from home screen). Reuse Points list widget from home screen
