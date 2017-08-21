var fs = require('fs'),
	data = require('./tests-data.json'),
	l = data.length + 1,
	map = data.map,
	i = 1,
	template_string = fs.readFileSync('./test-template.tpl', 'utf-8'),
	template = function(i) {
		return eval('`' + template_string + '`');
	},
	processed = 0,
	errors = [];

for (let i = 1; i < l; i++) { // note that l is actually equals data.length + 1, thus i = [1,data.length]
	let path = "./test_" + (i < 10 ? '0' + i : i) + ".xml";

	fs.stat(path, function(err, stats) {
		if (err && err.errno === -4058) {
			fs.writeFile(path, (map.indexOf(i) !== -1 ? `<test_pack id="test_${i < 10 ? '0' + i : i}"></test_pack>` : template(i)), { flag: 'wx' }, function(err) {
			    if (err) {
			    	errors.push({ n: i, errobj: err });
			    }
			    check();
			});
		} else {
			errors.push({ n: i, path: path,errobj: 'File exists' });
			check();
		}
	})
}

function check() {
    processed++;
	if (processed === l - 1) {
		console.log((l-1 - errors.length) + ' files created successfully.');
		if (errors.length) {
			console.log('There were some errors during execution:')
			for (i = 0; i < errors.length; i++) {
				console.log( 'Error #' + i + ': ' + (errors[i]['path'] ? '(' + errors[i]['path'] + ')' : 'file #' + errors[i]['n']) + ' writing error: ' + JSON.stringify(errors[i]['errobj']) );
			}
		} 
	}
}