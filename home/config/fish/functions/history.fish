function history --wraps=history
    builtin history --show-time='%F %T ' $argv
end
