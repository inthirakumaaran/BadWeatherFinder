import ballerina/io;
import ballerina/http;
import ballerina/log;


string weatherAddress = "https://api.darksky.net/forecast";
string weatherApiKey = "b5ac752055fa6b6d05ef7c2a698b276f";
http:Client weatherClientEndpoint = new(weatherAddress);

string[][] inputt = [["6.8301108", "79.88002929999999", "1547035899", "1620"], ["6.8320621", "79.879769", "1547035959",
"60"], ["6.8317496", "79.87285659999999", "1547036079", "120"]];

//public function main() {
//    //var response = weatherClientEndpoint->get("/b5ac752055fa6b6d05ef7c2a698b276f/37.8267,-122.4233");
//    //if (response is http:Response) {
//    //   io:print( response.getJsonPayload());
//    //}
//
//    getWeatherResult("6.8301108", "79.88002929999999", "1547032927");
//
//}

//public function main() {
//    //string ans = getWeatherResult("6.8301108", "79.88002929999999", "1547032927");
//    //getWeatherTotalPrediction([["6.8301108", "79.88002929999999", "1547032927"], ["6.8320621", "79.879769", "1547032987"], ["6.8317496", "79.87285659999999", "1547033107"]]);
//    //getWeatherTotalPrediction(inputt);
//    //getTotalTime(inputt);
//    string[] weatherForcast = getWeatherTotalPrediction(inputt);
//    int[] timeArray = getTotalTime(inputt);
//    findBadWeather(weatherForcast,timeArray);
//}


public function getWeatherResult(string latitude, string longtitude, string time) returns string {
    var response = weatherClientEndpoint->get("/" + weatherApiKey + "/" + latitude + "," + longtitude + "," + time);
    string result = "not processed";
    if (response is http:Response) {
        var responseLoad = response.getJsonPayload();
        if (responseLoad is json) {
            result = responseLoad.currently.icon.toString();
            //io:println(result);
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
    //io:println(results);
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
    //io:println(resultTime);
    return resultTime;
}

public function findBadWeather(string[] weather, int[] duration) {
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
            finalResult = "In the travel-time " + rainPercentage + "% will be rainny.";
        }
        if (windTime > 0) {
            int windPercentage = (windTime * 100 / duration[0]);
            finalResult = finalResult + "In the travel-time " + windPercentage + "% will be windy.";
        }
        if (snowTime > 0) {
            int snowPercentage = (snowTime * 100 / duration[0]);
            finalResult = finalResult + "In the travel-time " + snowPercentage + "% will be snowy.";
        }
    }
    finalResult = finalResult + " With expected journey time of " + duration[0] +" mins";
    io:println(finalResult);
}
