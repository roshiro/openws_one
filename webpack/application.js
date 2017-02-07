require('./es2015/test.js')

console.log("Hello world 2!");

// inject bundled Elm app into div#main
var Elm = require('./elm/Dashboard.elm');
Elm.Main.embed( document.getElementById( 'main' ) );
