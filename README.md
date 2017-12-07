## Flask-based API for a Mattermost EQDKP2 Slash Command

This is a simple, lightweight Flask server used to query the [EQDKP-Plus](https://eqdkp-plus.eu/en/) CMS system and display player DKP (dragon kill points) in a  [Mattermost](https://about.mattermost.com/) channel.

This can probably be repurposed to do other things, in this case it just wraps a scrape shell script into a JSON-friendly API for Mattermost.  Future improvement should probably include using the [EQKDP-Plus API](https://eqdkp-plus.eu/wiki/Plus_Exchange).

### Components

* ```mattermost-dkpbot.py``` Flask app that runs an simple API to query with a
  Mattermost custom slash command.

* ```report-dkp-slashcommand.sh``` Shell script that queries EQDKP2 (tested on 2.2)
   - This can also be run stand-alone via ```sh report-dkp-slashcommand.sh playername```

### Requirements
* python (tested on 2.7.5)
* python-flask
* Mattermost (tested on 4.3.2+) 
* EQDKP-Plus 2.2 (tested on 2.2.15)

### Installation

* Clone the repository
```
git clone https://github.com/sadsfae/mattermost-eqdkp
cd mattermost-eqdkp
```

* Edit your ```dkp_url``` variable in ```report-dkp-slashcommand.sh```
* Run the Python application via ```python mattermost-dkpbot.py```
   - You might want to run this via a systemd service or init script once you're happy with it.
   - You should run this as an unprivileged user, I've included an example ```systemd``` unit file you can use.

### Mattermost Server Settings

* System Console -> Developer Settings -> Allow untrusted internal connections to: ```localhost```
* System Console -> Custom Integrations -> Enable integrations to override usernames: ```true```
* System Console -> Enable integrations to override profile picture icons: ```true```

### Slash Command Settings

* Main Menu -> Integrations -> Slash Command 
  - Add Slash Command
  - Description: /getdkp playername
  - Command Trigger Word: getdkp
  - Request URL: http://localhost:8098/getdkp
  - Request Method: POST

### Action Pic

![getdkp](/image/getdkp.png?raw=true)
