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
