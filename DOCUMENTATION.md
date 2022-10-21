# Documentation
## SCSS/SASS
Netlify does not seem to be running the extended version of Hugo, which is required for compiling SCSS/SASS.
Hugo keeps cached SCSS output in `resources/_gen/assets`.
So in order to make SCSS changes visible you have to run Hugo locally (`hugo`) and than commit that directory (`git commit resources/_gen/assets`).

## Netlify Large Media
We use git-lfs and Netlify Large Media to store images.

### Setup
You will have to set it up first as is shown [here](https://docs.netlify.com/large-media/setup/):
1. Install dependencies (see below)
2. Link local repository to netlify (`netlify link`)

### Usage

* Track file with git-lfs:
```
git lfs track <file_or_directory>
```
* Add/commit files as usual
* Push as usual

In order for NLM credentials to work on push you might need to install the Netlify credential helper (`netlify install`) and source it before pushing:
```
source /home/jzbor/.config/netlify/helper/path.zsh.inc
```

### Dependencies
* Arch Linux and derivatives: `netlify git-lfs`

