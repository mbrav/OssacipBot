# OssacipBot

_I love art. I like math. Random is my type of order._

[@OssacipBot](https://twitter.com/OssacipBot) - A Twitter bot that generates procedural artwork.

![output](http://i.giphy.com/26BoEscVHpDa5XYre.gif)

## Example Gallery

<div id="ossacip" style="width: 100%; overflow-x: auto;">
    <img style="display: inline-block; width: 32%; height: 100%;"
        src="https://mbrav.github.io/images/ossacip_1.jpg" alt="OssacipBot Image" />
    <img style="display: inline-block; width: 32%; height: 100%;"
        src="https://mbrav.github.io/images/ossacip_2.jpg" alt="OssacipBot Images" />
    <img style="display: inline-block; width: 32%; height: 100%;"
        src="https://mbrav.github.io/images/ossacip_3.jpg" alt="OssacipBot Image" />
    <img style="display: inline-block; width: 32%; height: 100%;"
        src="https://mbrav.github.io/images/ossacip_4.jpg" alt="OssacipBot Image" />
    <img style="display: inline-block; width: 32%; height: 100%;"
        src="https://mbrav.github.io/images/ossacip_5.jpg" alt="OssacipBot Images" />
    <img style="display: inline-block; width: 32%; height: 100%;"
        src="https://mbrav.github.io/images/ossacip_6.jpg" alt="OssacipBot Image" />
    <img style="display: inline-block; width: 32%; height: 100%;"
        src="https://mbrav.github.io/images/ossacip_7.jpg" alt="OssacipBot Image" />
    <img style="display: inline-block; width: 32%; height: 100%;"
        src="https://mbrav.github.io/images/ossacip_8.jpg" alt="OssacipBot Images" />
    <img style="display: inline-block; width: 32%; height: 100%;"
        src="https://mbrav.github.io/images/ossacip_9.jpg" alt="OssacipBot Image" />
</div>

## Fractal Formula

The formula is bases on the notion of mathematical [Dynamical Systems](https://en.wikipedia.org/wiki/Dynamical_system). The bot randomizes 6 different variables called _a_, _b_, _c_, _d_, _e_, and _f_. One of these variables is randomly chosen to have its value dynamically manipulated allowing the formula to produce "movement" to the exported GIF. Then 0.5 million points are drawn per frame with the following coordinates where _n_ is the current point:

![Math Formula Image](https://i.imgur.com/Kk5R18t.png)

## Installation

This is the installation procedure that was followed on a Ubuntu server setup. The procedure however is different on systems like mac OS and Windows.

Clone the repository using git

```
$ git clone https://github.com/mbrav/OssacipBot.git
```

Enter into the repository

```
$ cd OssacipBot
```

Allow the server setup script to be executable, then run it

```
$ sudo chmod +x server-setup.sh && ./server-setup.sh
```

### Node.js Installation (depreciated)

**NOTE:** Add your own twitter API keys to the `bot/config.js` file. If you have a Twitter account, you can get your [Twitter API here](https://apps.twitter.com/).

Now its time to test the bot.
Enter into the `bot` folder and install dependencies like so:

```
$ cd bot && npm install
```

Run the server!

```
$ node bot.js
```

### Processing 3 Requirements

If the script fails to install the dependencies automatically, the following Processing 3 libraries can be installed manually:

-   [VideoExport](https://github.com/hamoid/video_export_processing/)

### Notes

-   [Running Processing in headless mode](https://github.com/processing/processing/wiki/Running-without-a-Display)

### Troubleshooting

If there are problems with running the bot, [leave an issue](https://github.com/mbrav/OssacipBot/issues)!

## Credits

[Bryan Ma](https://twitter.com/whoisbma) - A significant portion of this code was inspired from his bot called [greyLandscapeBot](https://github.com/whoisbma/greyLandscapeBot-EC2) which posts on twitter [every now and then](https://twitter.com/greyLandscapes).

[Vincent D. Warmerdam](https://twitter.com/fishnets88) - for providing and inspiring this project with [his formula](https://www.youtube.com/watch?v=h1qGfvi8Ueg).

```
a: 0.6267815
b: 1.7023143
c: 0.4992913
d: 3.0277352
e: 1.5243566
f: 1.0872754
morphing: 4  increment: 0.013384947
```
