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
- **Category:** Entertainment | Anime/Manga Social Cataloging
- **Mobile:**  Fully Mobile to accomadate the target demongraphic
- **Story:** Current implementation are mostly web based, and the mobile platforms that are available tend to be web ports with poor UI. This project provides a solution with relevant features for the growing mobile Anime/Manga consumers.
- **Market:** Manga and Anime enthusiast of any age group
- **Habit:** Anime titles and manga volumes are released every season. This app will serve as a companion app in daily consumption.
- **Scope:** Start with allowing user to add anime and manga titles to personalized collections. Provide a 1-10 rating system which is aggregated across the app. We can then scale to allowing group creation or other social interaction/collaboration features.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users are able to register an account
* Users are able to login to their accounts
* Users can view a stream of anime/manga titles
* Selecting an anime/manga title displays a detailed view
* Users can add anime/manga titles to personalized collections
* Users can rate an anime title from 1 - 10

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

**Flow Navigation** (Screen to Screen) (Paola) 

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
[Add table of models]
### Networking
- [Add list of network requests by screen]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
