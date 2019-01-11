import ballerina/test;


@test:Config
function testFindBadWeather() {

    string actualAnswer = findBadWeather(["rain", "rain", "snow", "wind", "snow"], [50, 10, 10, 10, 20]);
    string expectedAnswer =
        "In the travel-time 20% will be rainny.In the travel-time 20% will be windy.In the travel-time 60% will be snowy."
        + " With expected journey time of 50 mins";
    test:assertEquals(actualAnswer, expectedAnswer, msg = "predictions are not equal");
}

@test:Config
function testFindBadWeatherFalse() {

    string actualAnswer = findBadWeather(["rain", "rain", "snow", "wind", "snow"], [50, 10, 10, 10, 20]);
    string expectedAnswer =
        "In the travel-time 30% will be rainny.In the travel-time 30% will be windy.In the travel-time 60% will be snowy."
        + " With expected journey time of 50 mins";
    test:assertNotEquals(actualAnswer, expectedAnswer, msg = "predictions are equal");
}

@test:Config
function testgetTotalTime() {
    string[][] inputt = [["6.8301108", "79.88002929999999", "1547035899", "1620"], ["6.8320621", "79.879769",
    "1547035959", "60"], ["6.8317496", "79.87285659999999", "1547036079", "120"]];

    int[] actualAnswer = getTotalTime(inputt);
    int[] expectedAnswer = [27, 1, 2];
    test:assertEquals(actualAnswer, expectedAnswer, msg = "total time are not equal");
}

@test:Config
function testgetTotalTimeFalse() {
    string[][] inputt = [["6.8301108", "79.88002929999999", "1547035899", "1620"], ["6.8320621", "79.879769",
    "1547035959",
    "60"], ["6.8317496", "79.87285659999999", "1547036079", "120"]];

    int[] actualAnswer = getTotalTime(inputt);
    int[] expectedAnswer = [27, 1, 4];
    test:assertNotEquals(actualAnswer, expectedAnswer, msg = "total time are equal");
}



