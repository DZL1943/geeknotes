# GitHub

## ssh 相关

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

1. 新建 ssh key: ` ssh-keygen -t ed25519 -C "your_email@example.com"`
2. `eval "$(ssh-agent -s)"`
3. `touch ~/.ssh/config`
   ```text
    Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519
   ```
4. `ssh-add --apple-use-keychain ~/.ssh/id_ed25519`
5. `pbcopy < ~/.ssh/id_ed25519.pub`
6. 在 GitHub Settings 中添加
7. 在提交之前
   ```
    git config --global user.name "John Doe"
    git config --global user.email johndoe@example.com
   ```