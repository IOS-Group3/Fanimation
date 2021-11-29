# Fanimation 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Inspired by MyAnimeList, Fanimation is an anime and manga databasing and social cataloging platform where users can organize and track personalized list of anime/manga titles they are completing, view their current progress, rate titles, and provide reviews for others to view.

### App Evaluation
- **Category:** Anime/Manga Social Cataloging
- **Mobile:**  Fully Mobile to accomadate the target demongraphic
- **Story: N/A**
- **Market:** Manga and Anime enthusiast of any age group
- **Habit:** Anime titles and manga volumes are released every season. This app will serve as a companion app during daily consumption.
- **Scope:** Start with allowing user to add anime and manga titles to personalized collections. Provide a 1-10 rating system which is aggregated across the app.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] Users are able to register an account
- [X] Users are able to login to their accounts
- [X] Users can view a stream of anime/manga titles
- [ ] Selecting an anime/manga title displays a detailed view
- [X] Users can add anime/manga titles to personalized collections
- [X] Users can rate an anime title from 1 - 10

**Optional Nice-to-have Stories**

* Users can search for anime/manga titles
* Users can write reviews to anime/manga titles
* User reviews can be viewed by other users on the app
* User ratings can be viewed by other users on the app
* Users can view other users' collections
* Users can privitize or publicize their collections
* Users can upload profile photos
* User can view trailers and previews of titles

### 2. Screen Archetypes

* Login Screen
   * Users are able to login to their accounts
* Registration Screen
   * Users are able to register an account
* Stream
   * Users can view a stream of anime/manga titles
   * Users can view other users' collections
   * User can view trailers and previews of titles
* Search
   * Users can search for anime/manga titles
   * Users can view other users' collections
* Creation
   * Users can rate an anime title from 1 - 10
   * Users can write reviews to anime/manga titles
* Detail
   * Selecting an anime/manga title displays a detailed view
* Profile
   * Users can add anime/manga titles to personalized collections
   * Users can upload profile photos
   * User reviews can be viewed by other users on the app
   * User ratings can be viewed by other users on the app
* Settings 
   * Users can privitize or publicize their collections

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home
* MyList
* Profile

**Flow Navigation** (Screen to Screen) 

* Register Screen
   * => Home Screen
* Login Screen
   * => Home Screen
* Home Screen
   * => View More Screen (once you select a anime)
* MyList Screen
   * => Rate Screen (once you select a anime)
* View More Screen
   * => Home Screen
* Rate Screen
   * => MyList Screen
* Profile Screen
   * => None

## Wireframes
<img src="https://github.com/IOS-Group3/Fanimation/blob/main/readmeAssets/sketch.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups
Credit to [Hrishikesh Nanda](https://www.behance.net/gallery/128891097/MyAnimeList-Mobile-app-UIUX) for allowing us to use his Mockup UI/UX design as a springing board for our project.

<img src="https://i.imgur.com/46x4zun.png" width=600>
<img src="https://i.imgur.com/lfaqTIt.png" width=600>

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models

**User**
| Property | Type     | Description |
| -------- | -------- | --------    |
| UserId   |String    | Unique string identifier for user        |
| email    | String   | User's email to log in|
|password  | String   | User's password to log in| 
|profileImg| Reference| Reference to user's profile image|

**Pending List**
| Property | Type     | Description |
|----------|----------|-------------|
| ObjectId | String   |Unique string identifier for Ratings|
|UserID    | String   |User who owns the list|
|title     | String   |Title of Anime|


**Watching List**
| Property | Type     | Description |
|----------|----------|-------------|
| ObjectId | String   | Unique string identifier for Ratings|
| title    | String   | Title of Anime|
| startDate| String   | Date user started|
| progress | Int      | How close to finishing |
| score    | Int      | User's rating of anime | 

**Completed List**
| Property | Type     | Description |
|----------|----------|-------------|
| ObjectId | String   | Unique string identifier for Ratings|
| title    | String   | Title of Anime|
| startDate| String   | Date user started|
| endDate  | String   | Date user finished|
| score    | Int      | User's rating of anime |

**Favorites List**
| Property | Type     | Description |
|----------|----------|-------------|
| ObjectId | String   | Unique string identifier for Ratings|
| title    | String   | Title of Anime|
| startDate| String   | Date user started (if applicable)|
| endDate  | String   | Date user finished (if applicable)|
| score    | Int      | User's rating of anime|


### Networking
Network Requests by Screen:
* Home Screen
   * Read/GET - Send a get request to Jikan REST API to get anime/manga titles based on new season, currently airing, and trending endpoints
  
* MyList Screen
    * Watching:
        * Read/Get - Send a get request to the Firebase Database to get a list of all anime titles in Watching collection where the userID (objectID) is equal to the current user
    * Completed:
        * Read/Get - Send a get request to the Firebase Database to get a list of all anime titles in Completed collection where the userID (objectID) is equal to the current user
    * On Hold:
        * Read/Get - Send a get request to the Firebase Database to get a list of all anime titles in Hold collection where the userID (objectID) is equal to the current user
* View More Screen
   * Read/GET - Send a get request to Jikan REST API to get anime/manga details based on the object's ID
* Rate Screen
   * Create/POST - Send an update call to Firebase database and update the score of an anime title in the Score collection
* Profile Screen
    * Read/GET - Send a get request to the Firebase Database to pull the user information based on current user ID.


#### [OPTIONAL:] Existing API Endpoints

- Base URL: [https://api.jikan.moe/v3](https://api.jikan.moe/v3)

|HTTP Verb | Endpoint |Parameters | Description|
|----------|----------|-----------|------------|
|    `GET`    | /season/| [{season, year}]| Get all Anime titles from a specific year and season. Returns the current season if parameters are empty.|
|    `GET`    | /season/archive  | None |Returns all years and their respective seasons that can be parsed.|
|    `GET`    | /season/later| None | Returns all Anime that have been announced for the upcoming season|
|    `GET`    | /anime  | [{id, request, pagnation}] |Returns a single anime object with all its details.|

- Base URL: [https://api.jikan.moe/v3/anime/{id}{request}](https://api.jikan.moe/v3/anime/1)

|HTTP Verb | Request |Parameters | Description|
|----------|----------|-----------|------------|
|    `GET`    | /| None| Anime with all it's details.|
|    `GET`    | /characters_staff | None |List of character and staff members.|
|    `GET`    | /videos| None | List of Promotional Videos & episodes (if any)|
|    `GET`    | /episodes  | [Page Number (int)] |List of episodes.|
|    `GET`    | /pictures  | None |List of related pictures.|

## Build Progress
**Milestone 1**

<img src= 'https://i.imgur.com/kvMuZHk.gif' width= '250' title= 'Milestone 1'/>

\
**Milestone 2** 

<img src= 'https://i.imgur.com/V4D5JZL.gif' width= '250' title= 'Milestone 2'/>

\
**Milestone 3**

<img src= 'https://i.imgur.com/yZTvqg1.gif' width= '250' title= 'Milestone 3'/>
