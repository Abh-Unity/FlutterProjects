# GPS Tracker

A GPS tracking app built with Flutter and a Go backend. It reads the device's location (including in the background), stores it locally with Hive, sends it to a Go server backed by Postgres on Supabase, and shows both the current reading and the location history.

<p align="center">
  <img src="../gps_clean_architecture_Screenshots/Picsart_26-11-09_14-23-01-834.jpg" width="250">
  <img src="../gps_clean_architecture_Screenshots/Picsart_26-11-09_14-23-50-753.jpg" width="250">
  <img src="../gps_clean_architecture_Screenshots/Screenshot_2026-11-09-14-19-56-848_com.miui.gallery.jpg" width="250">
  <img src="../gps_clean_architecture_Screenshots/Screenshot_2026-11-09-14-20-01-030_com.miui.gallery.jpg" width="250">
  <img src="../gps_clean_architecture_Screenshots/Screenshot_2026-11-09-14-20-03-728_com.miui.gallery.jpg" width="250">
  <img src="../gps_clean_architecture_Screenshots/Screenshot_2026-11-09-14-20-13-692_com.miui.gallery.jpg" width="250">
</p>

This README has two parts:

1. [Frontend](#1-frontend)
2. [Backend](#2-backend)

---

## 1. Frontend

### Layers

UI, State Management, User Repository, Data Class, Service Class

### Flow of data

```
Service (DI through GetIt)
  -> User Repository (calls Data Class)
  -> Data Class (filters data and converts it into user-defined data types)
  -> State Management (gets data through User Repository)
  -> UI (data is displayed)
```

### Services used

**Frontend**
- **Flutter** - framework for Android/iOS support (I haven't accounted for iOS because I focused heavily on Android while learning)
- **Hive** - persistent data
- **GetIt** - service locator for dependency injection
- **BLoC** - state management
- **Figma** - simple, minimalistic UI design
- **Dio** - talks to the server to post and get data

**Backend**
- **Golang** - fast, light backend server
- **PostgreSQL** - used for local testing
- **Supabase** - hosts the PostgreSQL database and handles the data
- **Render** - deploys the backend

### What I learned (Android and OS behaviour)

I released the prototype of this project a few weeks ago. While building it I learnt how the operating system behaves, and why I needed `WAKE_LOCK` in the Android manifest, foreground services, and foreground location services.

- **Foreground services** let the app run in the background. They show a visible, persistent notification, because of which the OS doesn't kill the app when it is minimized.
- **Wake lock** prevents the CPU from sleeping, which stops the OS from killing the app completely. My app doesn't use it right now, but I haven't removed it from the Android manifest, so it's already there if I decide to provide an update that needs it.

### Permissions

I used `permission_handler` to handle permissions. The permissions requested are:

- **Location when in use** - for when the app is open
- **Location always** - for when the app is in the background
- **Notification** - for foreground services to show the persistent notification

### Roles of each layer

The app is divided into several layers according to their roles.

#### UI

Files: `go_router.dart`, `homepage.dart`, `locationhistory.dart`, `longitudecontainer.dart`, `main.dart`, `recordcontainer.dart`

This is where the UI buttons, list view builder, etc. sit. It consists of the things the user can interact with.

- **`go_router.dart`** - consists of GoRouter with routes. It handles navigation within the app in a clean, self-contained way so that debugging is easier.
- **`homepage.dart`** - consists of the UI elements and a BlocBuilder with a floating button. It is responsible for displaying the provided data and sending triggers (activating events) to build the UI. This file knows nothing about where the data comes from; its main job is just to display the incoming data.
- **`locationhistory.dart`** - very similar to `homepage.dart`, but instead of showing the current reading it shows the history of data given to it.
- **`longitudecontainer.dart`** - the extension to `homepage.dart`. It consists of the container widget where all the incoming data is placed in its respective position. The UI is separated this way to make debugging easier, so that the homepage, where the actual data arrives from the pipeline, stays clean. Since I have `longitudecontainer`, if I need to change something in the container I only edit it once and all instances of the container are altered.
- **`main.dart`** - the starting point of the program, where Hive and dependencies are initialized. `BlocProvider` is also initialized here.
- **`recordcontainer.dart`** - same as `longitudecontainer.dart`, but for `locationhistory.dart`.

#### Services / dependencies

Files: `hivesetup.dart`, `locator.dart`, `statemanagement.dart`, `talktoserver.dart`

Services are the files that consist of the things that need to be accessed throughout the app's lifetime. They perform some action and provide output. They do not change with the data they process; they are the non-changing entities and are unaffected by the data they process.

- **`hivesetup.dart`** - initializes and opens Hive boxes to store the data.
- **`hive_registrar.g.dart`** - a type adapter file. Hive only knows how to store primitive data types. If the user wants to store a user-defined data type, a type adapter must be created so that Hive knows how to store it and how to provide it back when needed.
- **`locator.dart`** - where the singleton instances of the services are created. Since the app needs them to function, singleton / lazy singleton instances are defined so that allocation/deallocation and memory leaks can be prevented. The global single instances are kept so that the app can request a service whenever and from wherever it needs it.
- **`statemanagement.dart`** - the true brain of the frontend. This is where the dormant services are awakened/triggered. It dictates which services run at a given time according to the events triggered, and it acts on the triggers provided by the UI to initiate the respective events.
- **`geolocator_setup.dart`** - used to find out the currently allowed permissions and to request permissions from the user with `.request()`. It returns `true` if location always is granted, `false` if location always is denied but location when in use is allowed, and `null` when location when in use is denied.

#### Data

Files: `hold_data.dart`, `dataRepository.dart`, `deviceinfo.dart`, `geolocator_Readings.dart`, `hold_Data.g.dart`, `retrieveddataclass.dart`

This is the layer concerned with data and nothing else.

- **`hold_data.dart`** - converts the raw, unstructured data (or collection of data) into structured data consisting of fields such as longitude, latitude, altitude, etc. This helps with type safety and also filters the incoming data by keeping only the data returned by its factory function.
- **`dataRepository.dart`** - where all the logic related to data happens. The factory function of the `hold_data` class is called here, and the function that stores the incoming data from Geolocator is defined here. This file decides where the data is fetched from and where it goes. It is responsible for caching the data into the Hive box, sending it to the backend, and retrieving that data.
- **`deviceinfo.dart`** - where a unique ID for the device is created. It helps uniquely identify the data when we need to retrieve it from the backend. It is created only once.
- **`geolocator_Readings.dart`** - where `LocationSettings` is created. It is used to create a stream getter provided by Geolocator, which runs only when invoked. This getter is sent to the user repository for further operation. I could send it to the BLoC too, but that would violate clean architecture: if anything were to be deprecated or change, my whole BLoC would have to be debugged and potentially the UI too. In clean architecture, services are always injected rather than passed, and services related to data are always injected into the user repository.
- **`hold_Data.g.dart`** - defines how to store the incoming `Position` object as distinct fields like longitude, altitude, latitude, etc., and return them when needed.
- **`retrieveddataclass.dart`** - same as `hold_data.dart`, but rather than reading the `Position` object from GPS, it reads the data from the backend and converts it into a user-defined data type called `retrieved_data`.

---

## 2. Backend

### Services used

- **Golang** - to design the backend server
- **PostgreSQL** - to test the backend server locally
- **Supabase** - to host the PostgreSQL database
- **Render** - to deploy the backend server

### Why Go

Go is a very fast language that compiles into a binary. Since everything is converted into machine code at once, it is very fast compared to interpreted languages like Python. It has built-in libraries like `os`, `net/http` and `encoding/json`, so I felt it was a great starting point for me to learn backend.

### Backend server design

- I created a struct consisting of the fields, with JSON tags, that saves the incoming data from Dio (sent using the `toJson` function in the app).
- **`main()`**: I retrieve the environment variable `DATABASE_URL` set on Render. If the environment variable is absent, I made a provision to connect to my local Postgres as a last option.
- I parse that string, and Go returns a config with the fields broken down from the database URL into a Go-readable struct (password, database name, etc.).
- With that config, I create a connection pool to the database and ping the database to check whether it is online.
- `defer` runs a function when its parent function is about to end. I make sure to close the connection between the database and the backend whenever an error occurs before reaching `ListenAndServe`. (Not having `defer dbpool.Close()` wouldn't matter here, because no function abruptly closes the backend after the pool has been opened.)
- The backend checks that the incoming request for each path matches the one defined in the backend; if not, it returns an error.
- **Saving data:** it saves the incoming coordinates from the frontend and inserts them into the database. `r.Context()` is used so that the transaction of data is atomic.
- **Retrieving data:** the backend reads the `deviceid` from the query parameter sent by Dio, and matches the rows to it. There can be multiple records, so I map them into the struct, create a slice of type `LocationData`, and send it for a GET request.

### Known limitations

The device ID is stored on the device itself and no server-side validation is done. Although a match is highly unlikely because I use UUIDs (universally unique identifiers, v4), sophisticated users could access other people's data by changing their device ID (UUID) to another person's UUID.

---

## Running the project

<!-- Fill in the exact steps that work on your machine. -->

**Backend**
1. Set the `DATABASE_URL` environment variable to your Postgres connection string.
2. Run the server with `go run .` from the backend folder.

**App**
1. `flutter pub get`
2. Set the backend URL used by Dio.
3. `flutter run`

## Earlier prototype

You can find the throwaway prototype I created to learn about the operating system and Geolocator here:
[gps prototype](https://github.com/Abh-Unity/FlutterProjects/tree/main/gps)
