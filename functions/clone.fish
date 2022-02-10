function clone --wraps='git clone --recurse-submodules --remote-submodules' --description 'alias clone git clone --recurse-submodules --remote-submodules'
  git clone --recursive $argv
end
