require'hop'.setup { keys = 'asdfhjlk' }

map {'\\f', 'f'}
map {'\\F', 'F'}
map {'\\t', 't'}
map {'\\T', 'T'}
map {'f', function() require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true }) end}
map {'F', function() require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true }) end}
map {'t', function() require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end}
map {'T', function() require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end}
