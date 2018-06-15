#!/bin/bash
# REF: https://www.defaults-write.com/speed-up-macos-high-sierra/
undo(){
	# To undo these changes execute a command like the following:
	# defaults delete domain key
	# Example: To undo the adjustment:
	# defaults write NSGlobalDomain KeyRepeat -int 0
	# Type the command:
	defaults delete NSGlobalDomain KeyRepeat
}
# Disable animations when opening and closing windows.
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable animations when opening a Quick Look window.
defaults write -g QLPanelAnimationDuration -float 0

# Accelerated playback when adjusting the window size (Cocoa applications).
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable animation when opening the Info window in Finder (cmd⌘ + i).
defaults write com.apple.finder DisableAllAnimations -bool true

# Disable animations when you open an application from the Dock.
defaults write com.apple.dock launchanim -bool false

# Make all animations faster that are used by Mission Control.
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable the delay when you hide the Dock
defaults write com.apple.Dock autohide-delay -float 0

# Disable the animation when you sending and replying an e-mail
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Disable the standard delay in rendering a Web page.
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

# The keyboard react faster to keystrokes (not equally useful for everyone
defaults write NSGlobalDomain KeyRepeat -int 0

# REF: https://github.com/trishume/dotfiles/blob/master/osx/set-defaults.sh
# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder
chflags nohidden ~/Library
