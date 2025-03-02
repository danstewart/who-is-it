# Who is it?

A simple person guessing game for 2-players using data from https://randomuser.me/.

https://who.danstewart.xyz

## Developing

```bash
# Generate a new board
./scripts/create-board.sh

# Start site
cd site
python3 -m http.server
```

## Deploying

```bash
scp -r site/* web:/var/www/who.danstewart.xyz
```

## TODO

1. Improve duplicate image check, it's wasteful to throw away the full set due to one duplicate. Maybe fetch larger batches and then grab a unique set within it.
2. Auto update board list.
3. Remove unused fields from result JSON.
4. Add Cloudflare.
5. Improve design of crossed off results.
6. Automatically copy board link on page load.
