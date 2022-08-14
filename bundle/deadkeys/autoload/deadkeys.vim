function deadkeys#init() abort
	if !exists('b:initialized_deadkeys')
		let b:initialized_deadkeys=1
		call deadkeys#on()
	endif
endfunction

function deadkeys#toggle() abort
	if !b:DeadKeysOn
		call deadkeys#on()
	else
		call deadkeys#off()
	endif
endfunction

function deadkeys#on() abort
	echo "Dead Keys: On"
	let b:DeadKeysOn=1
	"acute accents
	inoremap <buffer> 'a á
	inoremap <buffer> 'A Á
	inoremap <buffer> 'e é
	inoremap <buffer> 'E É
	inoremap <buffer> 'i í
	inoremap <buffer> 'I Í
	inoremap <buffer> 'l ĺ
	inoremap <buffer> 'L Ĺ
	inoremap <buffer> 'o ó
	inoremap <buffer> 'O Ó
	inoremap <buffer> 'r ŕ
	inoremap <buffer> 'R Ŕ
	inoremap <buffer> 'u ú
	inoremap <buffer> 'U Ú
	inoremap <buffer> 'y ý
	inoremap <buffer> 'Y Ý
	inoremap <buffer> '<space> '

	inoremap <buffer> [t ť
	inoremap <buffer> [T Ť
	inoremap <buffer> [s š
	inoremap <buffer> [S Š
	inoremap <buffer> [d ď
	inoremap <buffer> [D Ď
	inoremap <buffer> [l ľ
	inoremap <buffer> [L Ľ
	inoremap <buffer> [z ž
	inoremap <buffer> [Z ž
	inoremap <buffer> [c č
	inoremap <buffer> [C Č
	inoremap <buffer> [n ň
	inoremap <buffer> [N Ň
	inoremap <buffer> [o ô
	inoremap <buffer> [O Ô
	inoremap <buffer> [a ä
	inoremap <buffer> [A Ä
	inoremap <buffer> [<space> [

	inoremap <buffer> [e ě
	inoremap <buffer> [E Ě
	inoremap <buffer> [r ř
	inoremap <buffer> [R Ř
	inoremap <buffer> [u ů
	inoremap <buffer> [U Ů
endfunction

function deadkeys#off() abort
	echo "Dead Keys: Off"
	let b:DeadKeysOn=0

	iunmap <buffer> 'a
	iunmap <buffer> 'A
	iunmap <buffer> 'e
	iunmap <buffer> 'E
	iunmap <buffer> 'i
	iunmap <buffer> 'I
	iunmap <buffer> 'l
	iunmap <buffer> 'L
	iunmap <buffer> 'o
	iunmap <buffer> 'O
	iunmap <buffer> 'r
	iunmap <buffer> 'R
	iunmap <buffer> 'u
	iunmap <buffer> 'U
	iunmap <buffer> 'y
	iunmap <buffer> 'Y
	iunmap <buffer> '<space>

	iunmap <buffer> [t
	iunmap <buffer> [T
	iunmap <buffer> [s
	iunmap <buffer> [S
	iunmap <buffer> [d
	iunmap <buffer> [D
	iunmap <buffer> [l
	iunmap <buffer> [L
	iunmap <buffer> [z
	iunmap <buffer> [Z
	iunmap <buffer> [c
	iunmap <buffer> [C
	iunmap <buffer> [n
	iunmap <buffer> [N
	iunmap <buffer> [o
	iunmap <buffer> [O
	iunmap <buffer> [a
	iunmap <buffer> [A

	iunmap <buffer> [e
	iunmap <buffer> [E
	iunmap <buffer> [r
	iunmap <buffer> [R
	iunmap <buffer> [u
	iunmap <buffer> [U
endfunction
