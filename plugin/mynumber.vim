" This is based on https://github.com/koron/go-mynumber

function! s:b2n(b)
  if a:b < char2nr('0') || a:b > char2nr('9')
    return -1
  endif
  return a:b - char2nr('0')
endfunction

function! s:validate_mynumber(bs)
  if len(a:bs) != 12
    return 0
  endif
  let s = 0
  for i in range(len(a:bs)-1)
    let p = 11 - i
    if p <= 6
      let p += 1
    else
      let p -= 5
    endif
    let q = s:b2n(a:bs[i])
    if q < 0
      return 0
    endif
    let s += p * q
  endfor
  let s = s % 11
  if s <= 1
    let s = 0
  else
    let s = 11 - s
  endif
  return s:b2n(a:bs[11]) == s
endfunction

function! s:validate(s)
  if s:validate_mynumber(map(split(a:s, '\zs'), 'char2nr(v:val)'))
    echohl MoreMsg | echo 'Your MyNumber is Valid! Congratulations!' | echohl None
  else
    echohl ErrorMsg | echo 'Your MyNumber is NOT Valid! So Bad!' | echohl None
  endif
endfunction

command! -nargs=1 ValidateMyNumber call s:validate(<f-args>)
