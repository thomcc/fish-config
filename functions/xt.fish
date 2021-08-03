# Defined via `source`
function xt --wraps='cargo xtask' --description 'alias xt cargo xtask'
  cargo xtask $argv;
end
