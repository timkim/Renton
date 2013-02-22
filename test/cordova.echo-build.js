var fs = require('fs')
  , path = require('path')
  , Renton = require(path.join(__dirname, '..', 'Renton'))
  , shell = require('shelljs')
  , osenv = require('osenv')
  , test_dir = path.join(osenv.tmpdir(), 'cordovaEchoTest');

var outputName = 'cordovaEchoJNext';
var outputDirectory = path.join(__dirname, 'cordovaEcho');

exports.setUp = function(callback) {
    shell.mkdir('-p', test_dir);
    
    // copy the bb10 test project to a temp directory
    shell.cp('-r', path.join(__dirname, 'plugins', 'cordova.echo', 'src', 'BlackBerry10/*'), test_dir);

    callback();
}

exports.tearDown = function(callback) {
    // remove the temp files
    shell.rm('-rf', test_dir);
    shell.rm('-rf', outputDirectory);
    callback();
}

exports['should be able to build the plugin'] = function (test) {
    Renton.makePlugin(outputName, test_dir, outputDirectory);
    test.ok(fs.existsSync(outputDirectory + '/simulator/'+outputName+'.so'));
    test.ok(fs.existsSync(outputDirectory + '/device/'+outputName+'.so'));
    
    test.done();
}
