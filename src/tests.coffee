

############################################################################################################
CND                       = require 'cnd'
rpr                       = CND.rpr.bind CND
badge                     = 'TO-WIDTH/tests'
log                       = CND.get_logger 'plain',     badge
info                      = CND.get_logger 'info',      badge
whisper                   = CND.get_logger 'whisper',   badge
alert                     = CND.get_logger 'alert',     badge
debug                     = CND.get_logger 'debug',     badge
warn                      = CND.get_logger 'warn',      badge
help                      = CND.get_logger 'help',      badge
urge                      = CND.get_logger 'urge',      badge
echo                      = CND.echo.bind CND
#...........................................................................................................
test                      = require 'guy-test'
#...........................................................................................................

#===========================================================================================================
# TESTS
#-----------------------------------------------------------------------------------------------------------
@[ "demo" ] = ( T, done ) ->
  { to_width, width_of, }   = require './main'
  show = ->
    border = CND.blue '│'
    for n in [ 2, 3, 4, 10, 20, 30 ]
      info()
      help n
      info CND.blue '┌' + ( '─'.repeat n ) + '┐'
      info CND.blue '│    .    1    .    2    .    3    .    4'[ .. n ] + '│'
      info CND.blue '│1234567890123456789012345678901234567890'[ .. n ] + '│'
      info CND.blue '├' + ( '─'.repeat n ) + '┤'
      for [ align, text, ] in alignments_and_texts
        text = CND.white text
        text = to_width text, n, { align, }
        info border + text + border + ' ' + ( CND.blue width_of text ) # + ' ' + ( CND.yellow text.length )
      # info '╭' + ( '─'.repeat n ) + '╮'
      # info '╰' + ( '─'.repeat n ) + '╯'
      info '└' + ( '─'.repeat n ) + '┘'

  colors = [ CND.gold, CND.steel, ]
  stripe = ( text ) -> ( colors[ idx % 2 ] glyph for glyph, idx in Array.from text ).join ''
  alignments_and_texts = [
    [ 'left',   "北", ]
    [ 'center', "北", ]
    [ 'right',  "北", ]
    [ 'center', "X", ]
    [ 'center', "北京市", ]
    [ 'left',   "Peking", ]
    [ 'center', "Peking", ]
    [ 'right',  "Peking", ]
    [ 'center', "xa\u0300xa\u0301xa\u0302xa\u0303xa\u0304xa\u0305xa\u0306xa\u0307xaxa\u0320xa\u0321xa\u0322xa\u0323xa\u0324xa\u0325xa\u0326xa\u0327xa", ]
    [ 'center', stripe "北京位於華北 (North China) 平原的西北边缘 (north-western border area)", ]
    ]
  show()
  # debug '          1         2         3         4'
  # debug ' 1234567890123456789012345678901234567890'
  # debug ( new TO_WIDTH._Wcstring "a nice test to see the effects of fixed width" ).truncate 30, '*'
  # debug ( new TO_WIDTH._Wcstring "北京 (Peking) 位於華北 (North China) 平原的西北边缘 (north-western border area)" ).truncate 30, '*'
  # debug ( new TO_WIDTH._Wcstring "北京 (Peking) " + ( CND.white "位於華北" ) + CND.yellow " (North China) 平原的西北边缘 (north-western border area)" ).truncate 30, '*'
  #.........................................................................................................
  done?()

#-----------------------------------------------------------------------------------------------------------
@[ "demo 2" ] = ( T, done ) ->
  { to_width, width_of, }   = require './main'
  info 'abcd', ( 'abcd'.length ), ( Buffer.byteLength 'abcd' ), ( width_of 'abcd' )
  info 'äöüß', ( 'äöüß'.length ), ( Buffer.byteLength 'äöüß' ), ( width_of 'äöüß' )
  info 'a\u0308o\u0308u\u0308ß', ( 'a\u0308o\u0308u\u0308ß'.length ), ( Buffer.byteLength 'a\u0308o\u0308u\u0308ß' ), ( width_of 'a\u0308o\u0308u\u0308ß' )
  info '北京', ( '北京'.length ), ( Buffer.byteLength '北京' ), ( width_of '北京' )
  info '𪜀𪜁', ( '𪜀𪜁'.length ), ( Buffer.byteLength '𪜀𪜁' ), ( width_of '𪜀𪜁' )
  info()
  info 'abcd',                   '#' + ( to_width 'abcdabcd',                   4 ) + '#'
  info 'äöüß',                   '#' + ( to_width 'äöüßäöüß',                   4 ) + '#'
  info 'a\u0308o\u0308u\u0308ß', '#' + ( to_width 'a\u0308o\u0308u\u0308ßa\u0308o\u0308u\u0308ß', 4 ) + '#'
  info '北京',                     '#' + ( to_width '北京北京',                     4 ) + '#'
  info '𪜀𪜁',                     '#' + ( to_width '𪜀𪜁𪜀𪜁',                     4 ) + '#'
  done()

#-----------------------------------------------------------------------------------------------------------
@[ "width_of" ] = ( T, done ) ->
  { to_width, width_of, }   = require './main'
  #.........................................................................................................
  probes_and_matchers = [
    [ '', 0, null ]
    [ '-', 1, null ]
    [ '--', 2, null ]
    [ '-a-', 3, null ]
    [ '-a', 2, null ]
    [ 'a-', 2, null ]
    [ 'helo', 4, null ]
    [ 'helo-world', 10, null ]
    [ 'HELO-WORLD', 10, null ]
    [ 'µ-DOM', 5, null ]
    [ 'danish-øre', 10, null ]
    [ '北京𪜀𪜁', 8, null ]
    ]
  for [ probe, matcher, error, ] in probes_and_matchers
    await T.perform probe, matcher, error, -> new Promise ( resolve ) ->
      result = width_of probe
      resolve result
  #.........................................................................................................
  done()
  return null

#-----------------------------------------------------------------------------------------------------------
@[ "to_width" ] = ( T, done ) ->
  { to_width, width_of, }   = require './main'
  #.........................................................................................................
  probes_and_matchers = [
    [ [ '', 5 ], '     ', null ]
    [ [ '-', 5 ], '-    ', null ]
    [ [ '--', 5 ], '--   ', null ]
    [ [ '-a-', 5 ], '-a-  ', null ]
    [ [ '-a', 5 ], '-a   ', null ]
    [ [ 'a-', 5 ], 'a-   ', null ]
    [ [ 'helo', 5 ], 'helo ', null ]
    [ [ 'helo-world', 5 ], 'helo…', null ]
    [ [ 'helo-world', 15 ], 'helo-world     ', null ]
    [ [ 'HELO-WORLD', 5 ], 'HELO…', null ]
    [ [ 'HELO-WORLD', 15 ], 'HELO-WORLD     ', null ]
    [ [ 'µ-DOM', 5 ], 'µ-DOM', null ]
    [ [ 'danish-øre', 5 ], 'dani…', null ]
    [ [ '北京𪜀𪜁', 5 ], '北京…', null ]
    [ [ '北京𪜀𪜁', 15 ], '北京𪜀𪜁       ', null ]
    ]
  for [ probe, matcher, error, ] in probes_and_matchers
    await T.perform probe, matcher, error, -> new Promise ( resolve ) ->
      [ text, width, ]  = probe
      # debug '^33985^', { text, width, }
      resolve to_width text, width
  #.........................................................................................................
  done()
  return null

############################################################################################################
unless module.parent?
  test @

