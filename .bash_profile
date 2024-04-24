# Start ssh-agent and load keys
if [ -z "$SSH_AUTH_SOCK" ] ; then
   eval `ssh-agent -s`
  ssh-add ~/.ssh/id_*
fi
