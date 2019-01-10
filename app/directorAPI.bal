import ballerina/http;
import ballerina/log;
import ballerina/io;

string address = "https://maps.googleapis.com/maps/api/directions";

http:Client clientEndpoint = new(address);
string key = "AIzaSyATIXv5bZtzJXf_T9ee9IdU1QsKHFtDbXA";

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
    io:println(startAddress + " to " + destination);
    //setAddress("Wellawatte,Colombo,SriLanka", "Bambalpittiya,colombo,SriLanka");
    var response = clientEndpoint->get("/json?origin=" + startAddress + "&destination=" + destination +
            "&mode=transit&key="
            + key);
    if (response is http:Response) {
        //io:println(response.getJsonPayload());
        var responseLoad = response.getJsonPayload();
        if (responseLoad is json) {
            io:println(responseLoad.available_travel_modes.toString());
        }

    } else if (response is error) {
        log:printError("Get request failed", err = response);
    }

}



public function findRoute(string modeVal) {
    //setAddress("Wellawatte,Colombo,SriLanka", "Bambalpittiya,colombo,SriLanka");
    setMode(modeVal);
    var response = clientEndpoint->get("/json?origin=" + startAddress + "&destination=" + destination +
            "&mode=" + modeValue + "&key=" + key);
    if (response is http:Response) {
        //io:println(response.getJsonPayload());
        var responseLoad = response.getJsonPayload();
        if (responseLoad is json) {
            json route = responseLoad.routes;
            int l = route.length();
            //io:println("length of array: " + l);

            int i = 0;
            while (i < l) {
                io:println(responseLoad.routes[i].summary.toString());
                i = i + 1;
            }
        }

    } else if (response is error) {
        log:printError("Get request failed", err = response);
    }
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

