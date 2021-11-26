var Twit = require('twit');
var config = require('./config');
var twitter = new Twit(config);

//require child process for triggering script for processing
var exec = require('child_process').exec;

//file system
var fs = require('fs');

// number of posts  already done by the bot
var postCount = 0;

// post on start
postTweet();
// then post every half-hour
setInterval(postTweet, 1000 * 60 * 30);

function postTweet() {
	// run processing sketch in "headless" mode
	var generateScript = exec('./generate.sh');
	// or run normally
	// var generateScript = exec('application.linux64/Ossacip');

	generateScript.stdout.on('data', function(data) {
    console.log(data);
	});

	generateScript.on('close', function(code) {
    processing();
	});
}

function processing() {
	var filename = 'app/export.gif';
	var params = {
		encoding: 'base64'
	};
	var b64content = fs.readFileSync(filename, params);
	console.log('finished generating/reading file');
	var media = {
		media_data: b64content
	};

	twitter.post('media/upload', media, uploaded);

	function uploaded(err, data, response) {
		//we'll actually tweet in this callback instead of just reporting errors or whatever
		var mediaID = data.media_id_string;
		postCount += 1;
		var txt = 'Composition ' + postCount + ' by Ossacip';
		var tweetParams = {
			// not reliable to post the count if the server keeps on crashing :(
			// status: txt,
			media_ids: [mediaID]
		};
		twitter.post('statuses/update', tweetParams, tweeted);
		if (err) {
			console.log("Error: ");
			console.log(err);
		} else {
			console.log("Post Success");
		}
	}

	function tweeted(err, data, response) {
		if (err) {
			console.log("Something went wrong!", err);
		} else {
			console.log("Tweet Worked!");
		}

		var removeOldImage = exec('rm app/export.gif');
		removeOldImage.on('close', function(code) {
	    console.log("Old image removed");
		});
	}
}
