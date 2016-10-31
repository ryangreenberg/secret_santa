# secret_santa
Match and notify recipients for a gift exchange 

## Usage

Create a config file using config_example.yml as an example.

```
bin/secret_santa assign config.yml
```

This will output assignments into a file.

## Template Variables
- `giver`: Person who is giving a gift.
- `recipient`: Person who is receiving the gift.

A person has the following properties:

- `email`
- `full_name`
- `first_name`
- `last_name`
