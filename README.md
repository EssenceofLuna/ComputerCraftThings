# ComputerCraftThings

Things I have programmed in ComputerCraft, including branches for turtles and (soon) PDA's. All of the scripts here are designed for [CC: Tweaked](https://www.curseforge.com/minecraft/mc-mods/cc-tweaked) and may not work on the original ComputerCraft. Also, these have been designed in [FTB Revelation](https://www.curseforge.com/minecraft/modpacks/ftb-revelation) and you may run into problems when running other modpacks. If this is the case, please create an issue post (see Contributing/troubleshooting below).

# Install Instructions

The update script relies heavily on [Github by Eric Wieser](https://github.com/eric-wieser/computercraft-github). This is automatically installed in the update process, so simply run ```wget run https://raw.githubusercontent.com/Alstro20/ComputerCraftThings/master/update.lua``` on any in-game computer.

This may pop up a few prompts, especially in first time installation.

This will download this repository (the branch associated with your machine, that is) to the directory `ComputerCraftThings/`.

To update, simply run `update.lua` at any time.

# Contributing/troubleshooting

This repo is still very early in development. If you would like to contribute, feel free. If you find an issue or recommendation, feel free to post an issue, but please check to see if it's been posted yet. And if you want to contribute directly, feel free to make a pull request.

When creating an issue post, please follow [this template](https://github.com/Alstro20/ComputerCraftThings/wiki/Issues-Template) when making a post.

# FAQ

**Q)** Why are there no releases? How do I download *x* script? How do I update?

**A)** All installation and updating is currently handled in game. Refer to the *install instructions* section above for more info. In the future, I may create releases for different versions/scripts. If you only want to download/run a single script, follow these instructions: 1) Navigate to the script you want to run/download. 2) Above the code, click `raw` to see the raw code. 3) Copy the URL you are taken to. 4) In game, run `wget [run] <link you just coppied>`. Include `run` if you only want to run it once instead of downloading. If you're
