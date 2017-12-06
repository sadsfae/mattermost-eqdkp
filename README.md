## Flask-based API for a Mattermost EQDKP2 Webhook

This is a simple, lightweight Flask server used to query the [EQDKP-Plus](https://eqdkp-plus.eu/en/) CMS system and display player DKP (dragon kill points) in a public [Mattermost](https://about.mattermost.com/) channel.

This can probably be repurposed to do other things, in this case it just wraps a scrape shell script into a JSON-friendly API for Mattermost but could be modified to perform other tasks.  I wanted to originally use the custom ```slash commands``` but had trouble with how Mattermost sent requests so this turned into a webhook instead.

### Components

* ```mattermost-dkpbot.py``` Flask app that runs an simple API to query with a
  Mattermost outgoing webhook.

* ```report-dkp-webhook.sh``` Shell script that queries EQDKP2 (tested on 2.2)
  which pulls in character name and matching DKP points.

* ```report-dkp.sh``` Standalong script to query and return EQKDP2 values
   - usage: ```sh report-dkp.sh playername```

### Requirements
* python (tested on 2.7.5)
* python-flask
* Mattermost (tested on 4.3.2+)
- EQDKP-Plus 2.2 (tested on 2.2.15)

### Installation

* Clone the repository
```
git clone https://github.com/sadsfae/mattermost-eqdkp
cd mattermost-eqdkp
```

* Edit your ```dkp_url``` variable in ```report-dkp-webhook.sh```
- Edit your ```botname``` variable in ```report-dkp-webhook.sh``` 
* Run the Python application via ```python mattermost-dkpbot.py```
   - You might want to run this via a systemd service or init script once you're happy with it.
   - You should run this as an unprivileged user, I've included an example ```systemd``` unit file you can use.

### Mattermost Server Settings

* System Console -> Developer Settings -> Allow untrusted internal connections to: ```localhost```
* System Console -> Custom Integrations -> Enable integrations to override usernames: ```true```
* System Console -> Enable integrations to override profile picture icons: ```true```

### Webhook Settings

* Main Menu -> Integrations -> Outgoing Webhook
  - Add Outgoing Webhook
  - Content-type: ```application/json```
  - Trigger When: ```First word matches a trigger word exactly```
  - Callback URLs:  ```http://localhost:8098/getdkp```

### Action Pic

![getdkp](/image/getdkp.png?raw=true)
