# GitHub

## ssh 相关

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

1. 新建 ssh key: ` ssh-keygen -t ed25519 -C "your_email@example.com"`
   备注: 此处的 -C 仅仅是对该 key 的备注, 并不需要和别的地方保持一致
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
   在 GitHub 中主要通过 email 识别用户