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

function isJamcoinPrime(num){
    var max = 100;
    if (num < max) {
        max = Math.sqrt(num);
    }
    for (var divisor = 2; divisor < max; divisor++) {
        if (num % divisor == 0) {
            return divisor;
        }
    }
    return true
}

function main() {
    var tests = readLine();
    var inputs = readLine();
    inputs = inputs.split(" ");
    var jamcoinLength = parseInt(inputs[0]), jamcoinsRequired = parseInt(inputs[1]);
    
    var foundJamcoins = 0;
    var jamcoins = [], divisors = [];
    
    var currentCoin = [];
    for (var count = 0; count < jamcoinLength; count++) {
        if (count == 0 || count == jamcoinLength - 1) {
            currentCoin.push("1");
        } else {
            currentCoin.push("0");
        }
    }
    
    // we now have the string for the initial jam coin we will need the jamcoin
    // in base 10 to ensure we can add 2 to it each loop. This causes the jamcoin
    // to retain the "1" in the final position
    var jamcoinBase10 = parseInt(currentCoin.join(''), 2)
    // console.log(jamcoinBase10);
    var primeFlag = false
    
    while (foundJamcoins < jamcoinsRequired) {
        // to find the jam coin we will need to test each coins value under each
        // base binary, ternary, quaternary, quinary, senary, septenary, octonary
        // nonary and decimal to ensure the value is not a prime number
        // ensure the current divisors array contains an empty arry
        divisors[foundJamcoins] = [];
        jamcoins[foundJamcoins] = currentCoin.join('')
        for (var base = 2; base <= 10 && !primeFlag; base++) {
            var coinValue = parseInt(currentCoin.join(''), base);
            var result = isJamcoinPrime(coinValue);
            // console.log("coinValue: " + coinValue + " | result: " + result);
            if (result === true) {
                // this coin value is prime. stop checking this coin.
                primeFlag = true;
                jamcoins[foundJamcoins] = "";
                divisors[foundJamcoins] = [];
            } else {
                // coinValue not prime. jamcoin still viable add the divisor returned by
                // isJamcoinPrime to the divisors array
                divisors[foundJamcoins][base - 2] = result;
            }
        }
        // all bases checked verify the prime flag
        if (!primeFlag) {
            foundJamcoins++;
        }
        // increment the jamcoin string by 2
        jamcoinBase10 += 2;
        // console.log(jamcoinBase10)
        currentCoin = jamcoinBase10.toString(2).split('');
        // console.log(currentCoin.join(''))
        primeFlag = false;
    }
    
    console.log("Case #1:");
    for (var coin = 0; coin < jamcoinsRequired; coin++) {
        var output = "";
        output += jamcoins[coin];
        for (var base = 2; base <= 10; base++) {
            output += " " + divisors[coin][base - 2]
        }
        console.log(output);
    }
}
