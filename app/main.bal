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
            findRoute(modeVal);
        }}
}

