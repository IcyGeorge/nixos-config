# Uncomment this to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# Setting default page
# c.url.start_pages  = "/home/x_user/.config/qutebrowser/custom_start_page/index.html"
# c.url.default_page = "/home/x_user/.config/qutebrowser/custom_start_page/index.html"

# Fonts
c.fonts.hints = '12pt "Maple Mono NF"'
c.fonts.keyhint = '12pt "Maple Mono NF"'
c.fonts.prompts = '12pt "Maple Mono NF"'
c.fonts.downloads = '12pt "Maple Mono NF"'
c.fonts.statusbar = '12pt "Maple Mono NF"'
c.fonts.contextmenu = '12pt "Maple Mono NF"'
c.fonts.messages.info = '12pt "Maple Mono NF"'
c.fonts.debug_console = '12pt "Maple Mono NF"'
c.fonts.completion.entry = '12pt "Maple Mono NF"'
c.fonts.completion.category = '12pt "Maple Mono NF"'
c.fonts.default_family   = '12pt "Maple Mono NF"'

# Dark mode
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.policy.images = "smart"

# BINDINGS
# config.bind(";t",       "open -t")                                                        # Open new tab


# WEBSITES PERMISSIONS
## Javascript
config.set("content.javascript.clipboard", "access", "https://github.com/*") # In order to be able to copy code...etc

# Audio capture & desktop capture
config.set("content.desktop_capture", True, "https://discord.com/*")
config.set("content.media.audio_capture", True, "https://discord.com/*")

# UI
c.scrolling.smooth = True    # Smooth scrolling for making eyes feeling better
c.statusbar.show   = "never" # Never show statusbar
config.source("@configDirectory@/dots/qutebrowser/themes/default/base16-gruvbox-material-dark-medium.config.py") # Set the theme.

## Other settings
# config.set("downloads.location.directory", "~/downloads") # Change download location.
