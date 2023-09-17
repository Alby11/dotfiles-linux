fpath+=( /home/tallonea/.cache/antidote/xPMo/zsh-ls-colors )
source /home/tallonea/.cache/antidote/xPMo/zsh-ls-colors/ls-colors.zsh
fpath+=( /home/tallonea/.cache/antidote/peterhurford/up.zsh )
source /home/tallonea/.cache/antidote/peterhurford/up.zsh/up.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/rummik/zsh-tailf )
source /home/tallonea/.cache/antidote/rummik/zsh-tailf/tailf.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/mattmc3/zman )
source /home/tallonea/.cache/antidote/mattmc3/zman/zman.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/agkozak/zsh-z )
source /home/tallonea/.cache/antidote/agkozak/zsh-z/zsh-z.plugin.zsh
export PATH="/home/tallonea/.cache/antidote/romkatv/zsh-bench:$PATH"
if ! (( $+functions[zsh-defer] )); then
  fpath+=( /home/tallonea/.cache/antidote/romkatv/zsh-defer )
  source /home/tallonea/.cache/antidote/romkatv/zsh-defer/zsh-defer.plugin.zsh
fi
fpath+=( /home/tallonea/.cache/antidote/olets/zsh-abbr )
zsh-defer source /home/tallonea/.cache/antidote/olets/zsh-abbr/zsh-abbr.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/bzr.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/clipboard.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/cli.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/compfix.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/completion.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/correction.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/diagnostics.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/directories.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/functions.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/git.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/grep.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/history.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/key-bindings.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/misc.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/nvm.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/prompt_info_functions.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/spectrum.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/termsupport.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/theme-and-appearance.zsh
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/lib/vcs_info.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ag )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/aliases )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/aliases/aliases.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ansible )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ansible/ansible.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/autoenv )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/autoenv/autoenv.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/battery )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/battery/battery.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/brew )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/colemak )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/colored-man-pages )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/colorize )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/colorize/colorize.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/command-not-found )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/command-not-found/command-not-found.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/compleat )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copybuffer )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copybuffer/copybuffer.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copyfile )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copyfile/copyfile.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copypath )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/copypath/copypath.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/cp )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/cp/cp.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/debian )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/debian/debian.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/dnf )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/dnf/dnf.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/dnote )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/docker )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/docker-compose )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/docker-machine )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/docker-machine/docker-machine.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/emoji )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/emoji/emoji.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/emotty )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/emotty/emotty.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/extract )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/extract/extract.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fasd )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fasd/fasd.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fd )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/firewalld )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/firewalld/firewalld.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fzf )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fzf/fzf.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gh )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git-auto-fetch )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git-auto-fetch/git-auto-fetch.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git-commit )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git-commit/git-commit.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git-extras )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gitast )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git-flow )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git-lfs )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git-lfs/git-lfs.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git/git.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/github )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/github/github.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gitignore )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gitignore/gitignore.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/globalias )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/globalias/globalias.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gnu-utils )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gnu-utils/gnu-utils.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/golang )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gpg-agent )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gpg-agent/gpg-agent.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/history )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/history/history.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/history-substring-search )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/history-substring-search/history-substring-search.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/keychain )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/keychain/keychain.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/kubectl )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/kubectx )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/kubectx/kubectx.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/last-working-dir )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/last-working-dir/last-working-dir.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/magic-enter )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/magic-enter/magic-enter.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/man )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/man/man.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/minikube )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/nmap )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/nmap/nmap.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/node )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/node/node.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/npm )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/nvm )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pep8 )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/per-directory-history )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/per-directory-history/per-directory-history.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pip )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/podman )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pyenv )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pyenv/pyenv.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pylint )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/python )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/python/python.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/qrcode )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/qrcode/qrcode.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ripgrep )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/rsync )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/screen )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/screen/screen.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/shrink-path )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/shrink-path/shrink-path.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/sprunge )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/sprunge/sprunge.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ssh-agent )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/systemadmin )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/systemadmin/systemadmin.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/systemd )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/systemd/systemd.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/thefuck )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/thefuck/thefuck.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/transfer )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/transfer/transfer.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/timer )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/timer/timer.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/tmux )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/tmux/tmux.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/tmuxinator )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/tmuxinator/tmuxinator.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ubuntu )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ubuntu/ubuntu.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/universalarchive )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/universalarchive/universalarchive.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/urltools )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/urltools/urltools.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/virtualenv )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/virtualenv/virtualenv.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/virtualenvwrapper )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/virtualenvwrapper/virtualenvwrapper.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/vscode )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/vscode/vscode.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/web-search )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/web-search/web-search.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/yum )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/yum/yum.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/zbell )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/zbell/zbell.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/zoxide )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/zoxide/zoxide.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/zdharma-continuum/fast-syntax-highlighting )
zsh-defer source /home/tallonea/.cache/antidote/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/srijanshetty/zsh-pip-completion/src )
fpath+=( /home/tallonea/.cache/antidote/3v1n0/zsh-bash-completions-fallback/src )
fpath+=( /home/tallonea/.cache/antidote/MenkeTechnologies/zsh-cargo-completion/src )
fpath+=( /home/tallonea/.cache/antidote/greymd/docker-zsh-completion/src )
fpath+=( /home/tallonea/.cache/antidote/lukechilds/zsh-better-npm-completion/src )
fpath+=( /home/tallonea/.cache/antidote/sunlei/zsh-ssh/src )
fpath+=( /home/tallonea/.cache/antidote/vasyharan/zsh-brew-services/src )
fpath+=( /home/tallonea/.cache/antidote/viasite-ansible/zsh-ansible-server/src )
fpath+=( /home/tallonea/.cache/antidote/MichaelAquilina/zsh-you-should-use/src )
fpath+=( /home/tallonea/.cache/antidote/zsh-users/zsh-completions/src )
fpath+=( /home/tallonea/.cache/antidote/jeffreytse/zsh-vi-mode )
source /home/tallonea/.cache/antidote/jeffreytse/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/psprint/zsh-sweep )
source /home/tallonea/.cache/antidote/psprint/zsh-sweep/zsh-sweep.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/unixorn/fzf-zsh-plugin )
source /home/tallonea/.cache/antidote/unixorn/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/Aloxaf/fzf-tab )
source /home/tallonea/.cache/antidote/Aloxaf/fzf-tab/fzf-tab.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/zsh-users/zsh-autosuggestions )
zsh-defer source /home/tallonea/.cache/antidote/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/zsh-users/zsh-history-substring-search )
source /home/tallonea/.cache/antidote/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
zsh-defer source /home/tallonea/.config/zsh/.aliases
zsh-defer source /home/tallonea/.config/zsh/.functions
fpath+=( /home/tallonea/.cache/antidote/mattmc3/zfunctions )
zsh-defer source /home/tallonea/.cache/antidote/mattmc3/zfunctions/zfunctions.plugin.zsh
