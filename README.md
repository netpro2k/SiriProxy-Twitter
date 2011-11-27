This is a simple tweet plugin for SiriProxy. It currently only supports being tied to a single username, and has no built in authentication.

# Setup

1. Copy the contents of `config-info.yml` into your `~/.siriproxy/config.yml`
2. Fill in the required auth info (See below)
3. restart SiriProxy

# Usage
**Say:** Tweet *(message)*

Will post a tweet with "message" after confirming

# Obtaining auth info

The plugin does not currently do its own authentication. You must set up a twitter "app" yourself and use the tokens from that for now.

1. Go to [twitter.com/apps](http://twitter.com/apps)
2. Click "Create a new application"
3. Fill in the required fields (None of these matter)
4. On the next screen, click the settings tab
5. Change the "Access" option to "Read and Write" and click "Update this twitter application settings"
6. Go back to the details tab, scroll down, and click "create your access token"
7. You should now have all the info required. Copy to the matching fields in `~/.siriproxy/config.yml`