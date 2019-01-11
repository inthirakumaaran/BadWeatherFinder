import ballerina/io;
import ballerina/http;
import ballerina/log;

// This bal handle the weather forcast with darksky.net

string weatherAddress = "https://api.darksky.net/forecast";
string weatherApiKey = weatherAPIKey;
http:Client weatherClientEndpoint = new(weatherAddress);


public function getWeatherResult(string latitude, string longtitude, string time) returns string {
    var response = weatherClientEndpoint->get("/" + weatherApiKey + "/" + latitude + "," + longtitude + "," + time);
    string result = "not processed";
    if (response is http:Response) {
        var responseLoad = response.getJsonPayload();
        if (responseLoad is json) {
            result = responseLoad.currently.icon.toString();
        }
    }
    return result;
}

public function getWeatherTotalPrediction(string[][] inputArray) returns string[] {
    string[] results = [];
    int arrayLength = inputArray.length();
    int i = 0;
    while (i < arrayLength) {
        results[i] = getWeatherResult(inputArray[i][0], inputArray[i][1], inputArray[i][2]);
        i = i + 1;
    }
    return results;

}

public function getTotalTime(string[][] inputArray) returns int[] {
    int[] resultTime = [];
    int arrayLength = inputArray.length();
    int i = 0;
    while (i < arrayLength) {
        int|error timeVal = int.convert(inputArray[i][3]);
        if (timeVal is int) {
            resultTime[i] = timeVal / 60;
        }
        i = i + 1;
    }
    return resultTime;
}

public function findBadWeather(string[] weather, int[] duration) returns string {
    int weatherLength = weather.length();
    int durationLength = duration.length();
    string finalResult = "enjoy happy journey in nice day.";
    if (weatherLength == durationLength) {
        int i = 1;
        int rainTime = 0;
        int windTime = 0;
        int snowTime = 0;
        while (i < weatherLength) {
            if (weather[i] == "rain") {
                rainTime = rainTime + duration[i];
            } else if (weather[i] == "wind"){
                windTime = windTime + duration[i];
            } else if (weather[i] == "snow"){
                snowTime = snowTime + duration[i];
            }
            i = i + 1;
        }

        if (rainTime > 0) {
            int rainPercentage = (rainTime * 100 / duration[0]);
            if (rainPercentage > 100) {
                rainPercentage = 100;
            }
            finalResult = "In the travel-time " + rainPercentage + "% will be rainny.";
        }
        if (windTime > 0) {
            int windPercentage = (windTime * 100 / duration[0]);
            if (windPercentage > 100) {
                windPercentage = 100;
            }
            finalResult = finalResult + "In the travel-time " + windPercentage + "% will be windy.";
        }
        if (snowTime > 0) {
            int snowPercentage = (snowTime * 100 / duration[0]);
            if (snowPercentage > 100) {
                snowPercentage = 100;
            }
            finalResult = finalResult + "In the travel-time " + snowPercentage + "% will be snowy.";
        }
    }
    finalResult = finalResult + " With expected journey time of " + duration[0] + " mins";
    return finalResult;
}
