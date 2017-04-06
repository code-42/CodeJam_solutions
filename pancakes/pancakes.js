// below code needed for bringing in the input //
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

// end of code for input. create functions for problem //
// here. make sure to include a main function for      //
// clarification of where the code starts.             //

function getStackHeight(stack) {
    if (stack.length < 2) {
        return 1;
    }
    var height = 1;
    for (var pancake = 1, stackHeight = stack.length; pancake < stackHeight; pancake++) {
        if (stack[pancake] != stack[pancake - 1]) {
            height++;
        }
    }
    
    return height;
}

function flippingPancakes(stack) {
    var theStack = stack.split('');
    var height = getStackHeight(theStack);
    
    if (theStack[theStack.length - 1] == "-") {
        return height;
    } else {
        return height - 1;
    }
    
}

function main() {
    
    var tests = parseInt(readLine())
    for (var test = 1; test <= tests; test++) {
        console.log("Case #" + test + ": " + flippingPancakes(readLine()))
    }
    
}