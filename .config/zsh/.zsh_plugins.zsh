fpath+=( /home/tallonea/.cache/antidote/peterhurford/up.zsh )
source /home/tallonea/.cache/antidote/peterhurford/up.zsh/up.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/rummik/zsh-tailf )
source /home/tallonea/.cache/antidote/rummik/zsh-tailf/tailf.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/mattmc3/zman )
source /home/tallonea/.cache/antidote/mattmc3/zman/zman.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/agkozak/zsh-z )
source /home/tallonea/.cache/antidote/agkozak/zsh-z/zsh-z.plugin.zsh
source $ZDOTDIR/.aliases
fpath+=( /home/tallonea/.cache/antidote/belak/zsh-utils/prompt )
source /home/tallonea/.cache/antidote/belak/zsh-utils/prompt/prompt.plugin.zsh
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
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/compleat/compleat.plugin.zsh
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
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/docker )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/docker/docker.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/docker-compose )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/docker-compose/docker-compose.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/extract )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/extract/extract.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fd )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fzf )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/fzf/fzf.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/git/git.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/github )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/github/github.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gitignore )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gitignore/gitignore.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/golang )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/golang/golang.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gpg-agent )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/gpg-agent/gpg-agent.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/history )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/history/history.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/history-substring-search )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/history-substring-search/history-substring-search.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/kubectl )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/kubectl/kubectl.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/kubectx )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/kubectx/kubectx.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/last-working-dir )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/last-working-dir/last-working-dir.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/magic-enter )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/magic-enter/magic-enter.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/minikube )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/minikube/minikube.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/node )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/node/node.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/npm )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/npm/npm.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/nvm )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/nvm/nvm.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pep8 )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pip )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pip/pip.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pyenv )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/pyenv/pyenv.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/python )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/python/python.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ripgrep )
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/rsync )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/rsync/rsync.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/sprunge )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/sprunge/sprunge.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ssh-agent )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ssh-agent/ssh-agent.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/sudo )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/sudo/sudo.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/systemd )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/systemd/systemd.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/tmux )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/tmux/tmux.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/tmuxinator )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/tmuxinator/tmuxinator.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ubuntu )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/ubuntu/ubuntu.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/urltools )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/urltools/urltools.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/vi-mode )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/vi-mode/vi-mode.plugin.zsh
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
fpath+=( /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/zoxide )
source /home/tallonea/.cache/antidote/ohmyzsh/ohmyzsh/plugins/zoxide/zoxide.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/belak/zsh-utils/editor )
source /home/tallonea/.cache/antidote/belak/zsh-utils/editor/editor.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/belak/zsh-utils/history )
source /home/tallonea/.cache/antidote/belak/zsh-utils/history/history.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/belak/zsh-utils/utility )
source /home/tallonea/.cache/antidote/belak/zsh-utils/utility/utility.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/zsh-users/zsh-syntax-highlighting )
zsh-defer source /home/tallonea/.cache/antidote/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
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
fpath+=( /home/tallonea/.cache/antidote/belak/zsh-utils/completion )
source /home/tallonea/.cache/antidote/belak/zsh-utils/completion/completion.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/zsh-users/zsh-autosuggestions )
zsh-defer source /home/tallonea/.cache/antidote/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/mattmc3/zfunctions )
zsh-defer source /home/tallonea/.cache/antidote/mattmc3/zfunctions/zfunctions.plugin.zsh
fpath+=( /home/tallonea/.cache/antidote/zsh-users/zsh-history-substring-search )
source /home/tallonea/.cache/antidote/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
