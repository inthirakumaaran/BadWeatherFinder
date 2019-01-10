import ballerina/http;
import ballerina/log;
import ballerina/io;
import ballerina/time;

string address = "https://maps.googleapis.com/maps/api/directions";

http:Client clientEndpoint = new(address);
string key = googleDirectionAPIKey;

string startAddress = "";
string destination = "";
string modeValue = "";

public function setAddress(string startPoint, string endPoint) {
    startAddress = startPoint;
    destination = endPoint;
}

public function setMode(string mode) {
    modeValue = mode;
}

function getAddress() {
    string startpoint = io:readln("Enter startAddress: ");
    string endpoint = io:readln("Enter destination: ");
    boolean falseValue = true;
    while (falseValue) {
        if (startpoint != " ") {
            falseValue = false;
            startpoint = startpoint.replaceAll(" ", "+");
            endpoint = endpoint.replaceAll(" ", "+");
            setAddress(startpoint, endpoint);
            findMode();

        }
        else
        {
            io:println("Enter proper value for start address and destination \n");
            startpoint = io:readln("Enter startAddress: ");
            endpoint = io:readln("Enter destination: ");

        }}

}

public function findMode() {
    // Send a GET request to the Hello World service endpoint.
    //io:println(startAddress + " to " + destination);
    //setAddress("Wellawatte,Colombo,SriLanka", "Bambalpittiya,colombo,SriLanka");
    var response = clientEndpoint->get("/json?origin=" + startAddress + "&destination=" + destination +
            "&mode=transit&key="
            + key);
    if (response is http:Response) {
        //io:println(response.getJsonPayload());
        var responseLoad = response.getJsonPayload();
        if (responseLoad is json) {
            io:println(" ");
            io:println("Select the mode from");
            io:println(responseLoad.available_travel_modes.toString());
        }

    } else if (response is error) {
        log:printError("Get request failed", err = response);
    }

}



public function findRoute(string modeVal, int delay) returns @untainted string[][][] {

    setMode(modeVal);
    string[][][] geoRoutes = [];
    var response = clientEndpoint->get("/json?origin=" + startAddress + "&destination=" + destination +
            "&mode=" + modeValue + "&key=" + key);
    if (response is http:Response) {
        //io:println(response.getJsonPayload());
        var responseLoad = response.getJsonPayload();
        if (responseLoad is json) {
            //io:println(responseLoad.available_travel_modes.toString());
            json route = responseLoad.routes;
            int l = route.length();
            int i = 0;
            while (i < l) {
                json leg = route[i].legs;
                int legLength = leg.length();
                int j = 0;
                io:println("--------------------------------------------------------------------");
                io:println("For route " + (i + 1) + " through " + responseLoad.routes[i].summary.toString());
                io:println(" ");
                string[][] geoPoints = [];
                while (j < legLength) {
                    geoPoints = [];
                    time:Time time = time:currentTime();
                    int currentTimeMills = (time.time / 1000);
                    if (delay > 0) {
                        currentTimeMills = currentTimeMills + delay;
                    }
                    //io:println(calculateCurrentTime(leg[j].duration.text.toString(), currentTimeMills));
                    string[] startpoint = [leg[j].start_location.lat.toString(), leg[j].start_location.lng.toString(),
                    string.convert(currentTimeMills), string.convert(calculateTime(leg[j].duration.text.toString()))];

                    geoPoints[0] = startpoint;
                    //geoPoints[1] = endpoint;
                    json step = leg[j].steps;
                    int stepLength = step.length();
                    int k = 0;
                    //io:println(geoPoints);
                    while (k < stepLength) {
                        //

                        currentTimeMills = calculateCurrentTime(step[k].duration.text.toString(), currentTimeMills);
                        string[] endpoint1 = [step[k].end_location.lat.toString(), step[k].end_location.lng.toString(),
                        string.convert(currentTimeMills), string.convert(calculateTime(step[k].duration.text.toString())
                        )];

                        geoPoints[k + 1] = endpoint1;
                        k = k + 1;

                    }

                    //io:println();
                    //io:println(geoPoints);
                    //io:println(geoPoints.length());
                    geoRoutes[i] = geoPoints;
                    j = j + 1;
                }
                //io:println(responseLoad.routes[i].summary.toString());
                i = i + 1;
            }
            return geoRoutes;
        }


    } else if (response is error) {
        log:printError("Get request failed", err = response);
    }
    return geoRoutes;
}

public function calculateTime(string time) returns int {
    string[] values = time.split(" ");
    int finalAns = 0;
    if (time.contains("days") || time.contains("day")) {
        int|error day = int.convert(values[0]);
        int|error hour = int.convert(values[2]);
        int|error min = int.convert(values[4]);
        if (day is int && hour is int && min is int) {
            finalAns = day * 24 * 60 * 60 + hour * 60 * 60 + min * 60;
        }
    } else if (time.contains("hours") || time.contains("hour") || time.contains("hrs") || time.contains("hr")) {
        int|error hour = int.convert(values[0]);
        int|error min = int.convert(values[2]);
        if (hour is int && min is int) {
            finalAns = (hour * 60 * 60 + min * 60);
        }
    } else if (time.contains("mins") || time.contains("min")) {
        int|error min = int.convert(values[0]);
        if (min is int) {
            finalAns = (min * 60);
        }
    }
    return finalAns;
}

public function calculateCurrentTime(string time, int currentTime) returns int {
    int finalValue = currentTime;
    int timevalue = calculateTime(time);
    finalValue = currentTime + calculateTime(time);
    //io:println("given time is: " + time + " calculated time is: " + timevalue + " final value is: " + finalValue);
    return finalValue;

}

//public function main() {
//    getAddress();
//    //findMode();
//    string val = io:readln("Enter Mode: ");
//    var modeVal = string.convert(val);
//    findRoute(modeVal);
//    //if (modeVal is string) {
//    //    findRoute(modeVal);
//    //} else {
//    //    io:println("Invalid choice \n");
//    //}
//}

