# ZemogaTest


## Project Description
This repository contains an iOS project that uses the VIPER architecture pattern to implement two features:

- Post: contains PostViewController, PostPresenter, PostInteractor, and PostRouter.
- PostDetail: contains PostDetailViewController, PostDetailPresenter, PostDetailInteractor, and PostDetailRouter.

Each feature is contained inside the Modules folder: Modules/Posts and Modules/PostsDetails. Inside each folder, there is a Protocol folder that contains all the protocols for every feature.

The project also uses Core Data to save information from https://jsonplaceholder.typicode.com/ and saves it on Postmodel.xcdatamodeld with entities: Author, Comment, and Post.

The project follows the single responsibility principle, so the interactor always returns the information from Core Data. When Core Data is empty, it downloads all the information from the server.

## Advantages of Using VIPER
Using the VIPER architecture provides several benefits for the project:

* Separation of concerns: Each VIPER module is highly cohesive and decoupled, ensuring that each module is responsible for a specific part of the application.
* Testability: With the use of protocols and mock objects, it's easier to test each component of the VIPER architecture independently.
* Scalability: VIPER allows for easy scalability, enabling the addition of new modules as the project grows without affecting the existing modules.

## Unit Tests
The VIPER architecture facilitates unit testing, and this project has implemented unit tests for the PostDetailPresenter, PostDetailInteractor, PostPresenter, and PostsInteractor layers. The tests take an approach of using the protocols and implementing mocks to facilitate the unit testing using XCTest.

## Requirements Met by the Project
This project meets the following requirements:

* Loads the posts from the JSON API and populates the view.
* Implements a post details screen.
* Allows the user to favorite posts, which will be displayed at the top of the list and marked with a star indicator.
* Provides a mechanism to delete a post.
* Provides a mechanism to remove all posts except for the favorite ones.
* Provides a mechanism to reload all posts from the API.

## How to Run
To run this project, it is necessary to have Xcode 14.2 or higher installed. Since the project uses Swift Package Manager, there is no additional configuration required.

To run the project:

1. Clone the repository
2. Open the project in Xcode
3. Select the target and simulator
4. Click the Run button to launch the app on the simulator.
