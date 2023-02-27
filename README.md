# HABalert

# Instructions for First-Time Setup

1. Clone the repository
2. cd into the repository: `cd HABalert`
3. Create an `env.sh` file in the repo directory with the following format. (This includes any environment variables needed, see "Environment Vars" below for a list of required variables.)

```
export VAR_NAME_1=VAR_VALUE_1
...
export VAR_NAME_n=VAR_VALUE_n
```
4. Run `source setup.sh`

# Running Code After Setup

### Each time you want to run code from this repo, run: 
  `source setup.sh`
### This does 3 things:
- Activates the Virtual Environment
- Updates/Builds All Requirements (ie. packages like numpy and the TwoTwoTwo library)
- Sets Environment Variables

### Each of these things can be done independently as well:

#### To activate the virtual environment:
`source env/bin/activate`

#### To update/build requirements:
`pip3 install -r requirements.txt`
##### (Might have to use pip3, pip3.8, etc.)

#### To reset environment variables:
`source env.sh`

# Environment Vars
#### This is a list of all environment variables in the format `VARIABLE_NAME: PURPOSE`. Set these in `env.sh` with the format described in "Instructions for First-Time Setup"
#### Contact arman@222.place or keyan@222.place to get set up with API keys, etc.
##### Twilio
- `TWILIO_PHONE_NUMBER`: The phone number used to send texts by code that calls twilio. Format: +19495554321
- `TWILIO_ACCOUNT_SID`: Used in calls to Twilio for authentication
- `TWILIO_AUTH_TOKEN`: Used in calls to Twilio for authentication
##### Airtable
- `AIRTABLE_APP_ID`: The app ID of the Airtable database. This is not a table ID, but rather the ID for the database to be used.
- `AIRTABLE_KEY`: API key from Airtable used for authentication.
##### Stripe
- `STRIPE_KEY`: API key from Stripe used for authentication.
##### Slack
- `SLACK_BOT_TOKEN`: Used in calls to Slack for authentication
- `CHANNEL_ID`: The channel which the slackbot sends messages to (we may split this into multiple keys for different channels)
