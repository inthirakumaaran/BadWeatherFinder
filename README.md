# RouteWeatherFinder
The project idea is to predict bad weather conditions between two travel points.
Normally, we easily select the route between two places without taking the weather into consideration. 
However, the weather is an important feature for travelling and transporting.
For business purposes like transportation, delivery or for day to day purpose like walking, driving this project will help them by identifying the bad weather conditions like raining, snowing and windy. This project takes time into account and predicts the weather based on the travel time and the corresponding weather forecast at that moment.

This project makes use of google direction API[1] and Darksky weather API[2]. It will find the route between the to
travel points using google direction api and find the weather condition for that route. 
Then it will  summarise the whole weather prediction and give readable information to users. 

References : 
* [1] Google Direction API: https://developers.google.com/maps/documentation/directions/start
* [2] Darksky weather API: https://darksky.net/dev/docs

**To Run:**
1. Go to API config file in app directory and insert your api keys(optional)
2. Go to the root file
3. Type "ballerina run app" to start the application
4. Enter the start address and destination address
5. Select the mode from given option
6. For available routes weather prediction will be shown
7. If needed journey can be delayed and new weather prediction for that period can be seen




