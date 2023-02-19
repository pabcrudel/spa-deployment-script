# Automated Deployment Script for SPA Projects on Github Pages

This script automates the deployment of SPA projects on GitHub Pages. It builds your project, commits the changes, and pushes the changes to the `gh-pages` branch of your GitHub repository.

## Usage

1. Download the script from the [GitHub repository](https://github.com/pabcrudel/spa-project-deployment-script) and save it in the root directory of your SPA project.

2. Make the script executable by running the following command:

```sh
chmod +x deploy.sh
```

3. Run the script by typing the following command in the terminal:

```sh
./deploy.sh
```

## Script Details
### Build
The script builds the project using the `npm run build` command.

### Create New Commit
The script creates a new commit Including if there are no changes to add. It's like this because if a previous commit has been made and you want to publish those changes, Git doesn't allow making a new commit upon resetting the repository in the dist folder. The latest commit hash is saved as a string and used in the commit message.

```sh
# Save the output of the `git log` command in the `git_log` variable.
git_log=$(git log)

# Use the `awk` command to print the second word of the output. The second word is the commit hash.
commit_hash=$(echo $git_log | awk '{print $2}')

# Create a new commit with the message "Deploy (commit: )"
git commit --allow-empty -m "Deploy (commit: $commit_hash)"
```

### Push to gh-pages Branch
The script pushes the new commit to the `gh-pages` branch of your repository.

```sh
# Get your current GitHub Repository URL
repo_url=$(git remote show origin | grep Push | awk '{print $3}')

# Navigate into the build output directory
cd dist

# Get current branch
branch=$(git rev-parse --abbrev-ref $(git symbolic-ref HEAD))

# Push to gh-pages branch
git push -f $repo_url $branch:gh-pages -v
```
The `-f` flag is used to force push changes to the gh-pages branch. The `-v` flag is used to display detailed information about the push operation.

## Author
This script was created by [Pablo Cru (pabcrudel)](https://github.com/pabcrudel).

## Contributing
If you find a bug or have a feature request, please open an issue or submit a pull request.

## License
This script is released under the [MIT License](https://github.com/pabcrudel/spa-project-deployment-script/blob/main/LICENSE.md).
