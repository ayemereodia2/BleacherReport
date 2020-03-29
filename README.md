# BleacherReport
This app was a 24 hr take home assigment was written in Swift. This project searches for images using Flickr API and displays images and image titles. The data is paginated and service takes care of fetching data from Flickr service. The application uses MVVM architecture.


# Getting Started

- Clone the repo and run BleacherReportApp.xcodeproj
- You may Create a Flickr API key and replace placeholder with key in FlickrConfig.swift.
- Project Loads with a default images of geese.
- Run the project and search for any keyword like "kittens".
- The application doesn't uses any third party library.


# [Flickr API]

Images are retrieved by hitting the Flickr API.

- Search Path: https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key={fickr_api_key}&format=json&nojsoncallback=1&safe_search=1&per_page={page_size}&text={search_text}&page={page_num}
- Example: https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a4f28588b57387edc18282228da39744&format=json&nojsoncallback=1&safe_search=1&per_page=60&text=kittens&page=1
- Response includes an array of photo objects, each represented as:

```
{
"id": "43213681030",
"owner": "164058447@N08",
"secret": "a4bf8df905",
"server": "1937",
"farm": 2,
"title": "Puss under the boot",
"ispublic": 1,
"isfriend": 0,
"isfamily": 0
}
```


We use the farm, server, id, and secret to build the image path. [Flickr Photo Source URLs] (https://www.flickr.com/services/api/misc.urls.html)

- Image Path: http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
- Example: https://farm8.staticflickr.com/7564/15981410640_a0d5006167_m.jpg
- Response object is the image file.


# Class Details

  ## PhotoSearch
    This module consists of all files related to Flickr search and presenting on UI. A single view that contains a      UICollectionView to display the retrieved images in a single layout, a detail view to show Image details when Thumbnail or Image titles are clicked.It also contains a searchbar History controller, that stores previous search query string.
    


## ViewContollers

-ViewControllers: This module consists of primary class FlickrCollectionViewController which consists of collection view and search text field. It also encapsulates functionality like fetching, refreshing and searching. On fetching data it binds this data with viewmodel and hence render it.

## Views
-PhotoCell2: This is the view which is reused for displaying images fetched from service. It also renders image by downloading it asyncronously using FlickrAPI and also handles some important usecase like cancelling downloading while recycling.

## ViewModels
PhotoSearchViewModel: This class represents data to be rendered in FlickrCollectionViewController via bindings.
PhotoDetailsViewModel: This class represents data to be rendered in FlickrCollectionViewController via bindings.
ImageModel: ImageModel represents data to be rendered in collection view cells, this is been generated while views are recycled.

## Models
- FlickerPhoto: This class represents the structure of response of request from flicker service for the searched text. This class uses codable protocal and used for parsing.

- Photos: This class represents the structure of pagination details and array of images from FlickrSearchResults. This class uses codable protocal and used for parsing.

- Flickr: This model represents data structure for images details. It encapsultes all related info and hence generates url for fetching images. This class uses codable protocal and used for parsing.
Services

FlickrSearchService: This service class is responsible for preparing the request, fetching and parsing response for consecutive pages. It internally uses NetworkManager to perform the request.

# HELPER

This module consists of classes related to network used to fetch the stream of data, careate request and check reachability of internet.
It 

-FlickrAPI: This class is basically used to fetch data from server. It is used to fetch data using URLSession singleton. It takes a URL and retrieve a stream of data contained at this URL no matter what kind of data it is. The advantage of this abstraction is that many other modules in the app can use the same module to retrieve different kinds of data such as images, json ... etc

- UIKIT extention: This class is responsible for caching, queuing and fetching images from server. It is uses a dictionary key-value pair to Cache Images.

- Reachability class to test for Network Reachability, before making any Network request.

# Constanst
This class contains Constansts such as APIScheme, APIHost, APIPath which do not change throught the life of the Application

# UnitTests
This module consists XCTTest classes for testing.

BleacherReportTest: This class tests the network interactions for fetching image and data, and validating its consistency. 

# NOTE
UI testing is not done due to time constraints.

  
