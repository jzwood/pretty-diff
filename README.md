# Pretty Diff

`pd` is a tiny shell script that (for macOs) previews color-coded git diffs in the browser.

### Usage

```sh
bash pd.sh "$(git diff)"
```

### Future Work
I really would prefer to have it the other way, ie `git diff master | pd.sh` (assuming `pd.sh` is in `/usr/local/bin`) but that doesn’t work and I’m not in the mood to figure it out, right now. PRs welcome!
