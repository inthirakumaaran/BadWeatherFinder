import ballerina/test;


@test:Config
function testCalculateTimeDays() {

    int actualAnswer = calculateTime("1 day 4 hours 30 mins");
    int expectedAnswer = (1 * 24 * 60 * 60 + 4 * 60 * 60 + 30 * 60);
    test:assertEquals(actualAnswer, expectedAnswer, msg = "calculations are not equal");
}

@test:Config
function testCalculateTimeHours() {

    int actualAnswer = calculateTime("8 hours 30 mins");
    int expectedAnswer = (8 * 60 * 60 + 30 * 60);
    test:assertEquals(actualAnswer, expectedAnswer, msg = "calculations are not equal");
}

@test:Config
function testCalculateTimeMins() {

    int actualAnswer = calculateTime("30 mins");
    int expectedAnswer = (30 * 60);
    test:assertEquals(actualAnswer, expectedAnswer, msg = "calculations are not equal");
}

@test:Config
function testCalculateTimeUndefined() {

    int actualAnswer = calculateTime("30 calories");
    int expectedAnswer = 0;
    test:assertEquals(actualAnswer, expectedAnswer, msg = "calculations are not equal");
}

@test:Config
function testCalculateTimeError() {

    int actualAnswer = calculateTime("1 day 4 hours 30 mins");
    int expectedAnswer = 0;
    test:assertNotEquals(actualAnswer, expectedAnswer, msg = "error calculations are equal");
}

@test:Config
function testCalculateCurrentTime() {

    int actualAnswer = calculateCurrentTime("1 day 4 hours 30 mins", 30000);
    int expectedAnswer = (1 * 24 * 60 * 60 + 4 * 60 * 60 + 30 * 60) + 30000;
    test:assertEquals(actualAnswer, expectedAnswer, msg = "calculations are not equal");
}

@test:Config
function testCalculateCurrentTimeError() {

    int actualAnswer = calculateCurrentTime("1 day 4 hours 30 mins", 30000);
    int expectedAnswer = (1 * 24 * 60 * 60 + 4 * 60 * 60 + 30 * 60) - 30000;
    test:assertNotEquals(actualAnswer, expectedAnswer, msg = "calculations are not equal");
}


