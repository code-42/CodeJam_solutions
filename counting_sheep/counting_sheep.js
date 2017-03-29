process.stdin.resume();
process.stdin.setEncoding('ascii');

var input_stdin = "";
var input_stdin_array = "";
var input_currentline = 0;

process.stdin.on('data', function (data) {
    input_stdin += data;
});

process.stdin.on('end', function () {
    input_stdin_array = input_stdin.split("\n");
    main();    
});

function readLine() {
    return input_stdin_array[input_currentline++];
}

/////////////// Above this line is used load the input into ////////////////////
/////////////// memory. Using readline() will read the next ////////////////////
/////////////// line and return it.                         ////////////////////

// function used to see in an array contains a specific element
// if element exists in array it will return true. if elment is not
// in array it will return false.
function contains(array, element) {
    for (var i = 0, length = array.length; i < length; i++) {
        if (array[i] == element) {
            return true
        }
    }
    return false
}

//beging the counting_sheep function.
function counting_sheep(number) {
    // first if the number is 0 there is no way to get to sleep.
    if (number == 0) {
        return "INSOMNIA";
    }
    
    // create an array to store the digits.
    var digitArray = [];
    for (var i = 0; i < 10; i++) {
        digitArray.push(false);
    }
    // array technically now: [false, false, false, false, false, false, false, false, false, false]
    // however by using digitArray[digit] you can see if that digit has been seen before.
    
    //counter variable to multiply the number by
    var counter = 1; 
    //keep running until all digits found. i.e. the digit array no longer has any false
    while (contains(digitArray, false)) {
        // get the current version of the number
        var temp = number * counter;
        // now we need to cycle through to get each digit.
        // this can be done by using modulo 10 to get the 1s digit by itself
        // after we then tell the digit array we have this digit divide by 10 and
        // floor it in order to get the next digit. Once the number hits 0 we have all
        // the digits in the number
        while (temp > 0) {
            var digit = temp % 10;
            digitArray[digit] = true;
            temp = Math.floor(temp / 10)
        }
        //increase counter for next loop.
        counter++;
    }
    // we arrive here only once all digits have been see. we now need to return the number
    // that gave us our final digit(s) since we increase counter at the end we would need
    // to remove the most recent addition to it to get the right number.
    return number * (counter - 1);
}

function main() {
    
    // get the number of test cases.
    var tests = parseInt(readLine());
    for (var i = 1; i <= tests; i++) {
        var input = parseInt(readLine());
        console.log("Case #" + i + ": " + counting_sheep(input));
    }
}

//create check array function


// get the tests