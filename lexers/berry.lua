-- Copyright 2021 Sodomon <sodomon2@gmail.com> 
-- Berry LPeg lexer.

local lexer = require('lexer')
local token, word_match = lexer.token, lexer.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local lex = lexer.new('berry')

-- Whitespace.
lex:add_rule('whitespace', token(lexer.WHITESPACE, lexer.space^1))

-- Keywords.
lex:add_rule('keyword', token(lexer.KEYWORD, word_match[[
  if elif else for while do end break continue
  return try except raise var def class true 
  false nil self super import as
]]))
-- Function.
lex:add_rule('function', token(lexer.FUNCTION, word_match[[
  print count assert type compile int real number
  size char open str
]]))

-- Libraries
local library = token('library', word_match[[
  -- STRING
  string.format string.count string.split
  string.find string.hex string.byte
  string.char string.tolower string.toupper
  -- JSON
  json.dump json.load
  -- MATH
  math.abs math.ceil math.floor math.sin
  math.cos math.tan math.asin math.acos
  math.atan math.sinh math.cosh math.tanh
  math.sqrt math.exp math.log math.log10
  math.deg math.rad math.pow math.srand
  math.rand math.pi math.imax math.imin
  -- TIME
  time.clock time.dump time.time
  -- OS
  os.path.isdir os.path.isfile
  os.path.exists os.path.split
  os.path.splitext os.path.join
  os.getcwd os.chdir os.mkdir os.remove
  os.listdir os.system os.exit os.path
  -- SYS
  sys.path
  -- DEBUG
  debug.attrdump debug.codedump
  debug.traceback debug.sethook
  debug.calldepth debug.top 
  debug.varname debug.upvname
  -- GC
  gc.allocated gc.collect
]])

lex:add_rule('library', library)
lex:add_style('library', lexer.STYLE_TYPE)

-- Identifiers.
lex:add_rule('identifier', token(lexer.IDENTIFIER, lexer.word))

-- Strings.
lex:add_rule('string', token(lexer.STRING, lexer.delimited_range("'") +
                                           lexer.delimited_range('"')))

-- Comments.
local line_comment = '#' * lexer.nonnewline_esc^0
local block_comment = lexer.starts_line('#-') *
                      (lexer.any - lexer.newline * '-#')^0 *
                      (lexer.newline * '-#')^-1
lex:add_rule('comment', token(lexer.COMMENT, block_comment + line_comment))

-- Numbers.
lex:add_rule('number', token(lexer.NUMBER, lexer.float + lexer.integer))

-- Operators.
lex:add_rule('operator', token(lexer.OPERATOR, S('+-*/%&!=<>^~?:.,[](){}|')))

return lex
