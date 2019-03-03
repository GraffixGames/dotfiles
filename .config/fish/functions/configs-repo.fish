function configs-repo --description 'git in .myconfigs'
    git --git-dir=$HOME/.myconfigs/ --work-tree=$HOME $argv
end

