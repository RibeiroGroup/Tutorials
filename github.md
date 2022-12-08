# GitHub

## What is it?

GitHub is a hosting platform for software development and version control (*via* git). 

For us, GitHub serves as place where all useful code is stored. Well, why not just use Google Drive or the likes? GitHub provides us with version control (git), which allow us to keep track of modifications made to any code over time. Moreover, it let us to collaborate on the same project helping us, for example, dealing with conflicts arising from a common file being modified by two people. 

The best way to learn git is working with git, but I am try to give you some useful tips to get started. 

## Create an account

Create your GitHub account here: https://github.com/join

> Setting up dual authentication at this stage might make your life easier later!

> I would recommend using a personal email rather than an institutional one. 

## Set up Git

### Check if git is installed:
```
git --version
```
If needed, install git from [here](https://git-scm.com/downloads). Alternatively, on Ubuntu, you can run the following command on the terminal
```
sudo apt install git-all
```

### Set up username and email

1. Open Terminal
2. Set user name
```
git config --global user.name "MyUserName"
```
> I recommend using your GitHub username, thought it is not required.
3. Set email
```
git config --global user.email "youremail@somewhere.com"
```
For more details check the [GitHub instructions](https://docs.github.com/en/get-started/getting-started-with-git/setting-your-username-in-git).

### Generate a SSH key

1. Open Terminal
2. Run the `ssh-keygen`
```
ssh-keygen -t ed25519 -C "youremail@somewhere.com"
```
You should receive the following prompt
```
> Enter a file in which to save the key (/home/you/.ssh/algorithm): [Press enter]
```
Just press enter to user the default location. The next prompt will ask you to define a password:
```
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]
```
If someone gains access to the computer where this SSH is setup, **they also gain access to your GitHub**. Therefore, I recommend that you set up a password.

3. Start the ssh-agent
```
eval "$(ssh-agent -s)"
```
4. Add your newly created SSH key to the ssh-agent
```
ssh-add ~/.ssh/id_ed25519
```

For more details check the [GitHub instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

### Adding the SSH key to your GitHub

1. Open Terminal
2. Get your public key
```
cat ~/.ssh/id_ed25519.pub
```
You should see a key printed on your terminal. It looks like this
```
ssh-ed25519 AAAACNjkjfnJFJKNfndflkFKJKnd/m/nisdasnknk youremail@somewhere.com
```
Copy that information making sure no trailing whitespaces or newlines are included. 

3. Go to your GitHub Settings. You can find that by clicking on your profile picture at the top right side of the screen, `Settings` must be the second-to-last option on the list that pops up.

4. Go to `SSH and GPG keys`. This option is found in the `Access` tab on the left side of the screen.

5. Click on `New SSH key`

6. Give it a name (`title`). Just pick a name that helps you remember which computer is using that key, e.g. `my laptop` or `work computer`.

7. Paste the key, once again make sure there are no trailing whitespaces. 

8. Hit `Add SSH key`.

To test if your SSH key is working, you can try cloning a repository using a SSH URL.


