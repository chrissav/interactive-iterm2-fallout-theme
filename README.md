# interactive-iterm2-fallout-theme
Fallout theme when launching an interactive app in iTerm2, such as `claude` or `k9s`.  The theme will launch a startup sequence when the command is run and a shutdown sequence when exiting that will return to your default iterm profile.

## Example

Example launching claude code from iterm2:

![Example](./example/fallout_theme_example.gif)

## Install

### Add profile to iTerm2

1. Create a new iTerm2 Profile
2. Go to Colors -> Color Preset -> Import and import the [fallout.itermcolors](./fallout.itermcolors)
3. Go to Text -> Font -> Monofonto.  If it's not there install it from somewhere like [this](https://fontmeme.com/fonts/monofonto-font/)
4. Go to Window -> Background image and import the [fallout-term.jpg](./fallout-term.jpg)
4. (Optional) Go to Appearance -> Panes and adjust the top and bottom margins to ~200 to avoid text overlap from the background image

### Add bash function to your shell config

Clone the repo and run (replace .bashrc or /usr/local/bin as needed)
```bash
cp fallout_loading.sh /usr/local/bin/fallout_loading.sh
cp fallout_shutdown.sh /usr/local/bin/fallout_shutdown.sh
chmod +x fallout_loading.sh fallout_shutdown.sh
cat bash_function >> ~/.bashrc
source ~/.bashrc
```

Or add the [fallout_loading.sh](./fallout_loading.sh) and [fallout_shutdown.sh](./fallout_shutdown.sh) files to your path, and the function in [bash_function](./bash_function) to your shell configuration file.
