import ballerina/io;


public function main() {
    getAddress();
    //findMode();
    string val = io:readln("Enter Mode: ");
    var modeVal = string.convert(val);
    boolean falseValue = true;
    while (falseValue) {
        if (modeVal == " ") {
            io:println("Enter proper value for modeVal \n");
            val = io:readln("Enter Mode: ");
        }
        else
        {
            falseValue = false;
            string[][][] routes = findRoute(modeVal, 0);
            int routeLength = routes.length();
            if (routeLength > 0) {
                int i = 0;
                while (i < routeLength) {
                    string[] weatherForcast = getWeatherTotalPrediction(routes[i]);
                    int[] timeArray = getTotalTime(routes[i]);
                    findBadWeather(weatherForcast, timeArray);
                    io:println();
                    i = i + 1;
                }
                io:println("--------------------------------------------------------------------");

                boolean delayBoolean = true;
                while (delayBoolean) {
                    string valContinue = io:readln("Do you want to delay the travel?(yes or no): ");
                    if (valContinue.equalsIgnoreCase("yes") || val.equalsIgnoreCase("y")) {
                        int|error delayMins = int.convert(io:readln("Enter delay mins :  "));
                        int|error delayHours = int.convert(io:readln("Enter delay hours :  "));
                        int|error delayDays = int.convert(io:readln("Enter delay days :  "));

                        if (delayDays is int && delayHours is int && delayMins is int) {
                            int delay = delayDays * 24 * 60 * 60 + delayHours * 60 * 60 + delayMins * 60;
                            string[][][] newroutes = findRoute(modeVal, delay);
                            int newrouteLength = newroutes.length();
                            if (newrouteLength > 0) {
                                i = 0;
                                while (i < newrouteLength) {
                                    string[] weatherForcast = getWeatherTotalPrediction(newroutes[i]);
                                    int[] timeArray = getTotalTime(newroutes[i]);
                                    findBadWeather(weatherForcast, timeArray);
                                    io:println();
                                    i = i + 1;
                                }
                            }
                            io:println("--------------------------------------------------------------------");

                        } else {
                            io:println("enter time properly");
                        }
                    }
                    else if (valContinue.equalsIgnoreCase("no") || val.equalsIgnoreCase("n")) {
                        delayBoolean = false;
                    } else {
                        io:println("enter yes or no properly");
                    }
                }
            } else {
                io:println("NO routes is selected. Please enter more specific address");
                getAddress();
                val = io:readln("Enter Mode: ");
                falseValue = true;
            }
        }

    }
    io:println(" ");
    io:println("End of Weather Prediction");
}

