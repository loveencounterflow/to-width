

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
{ to_width, width_of, }   = require './main'

#===========================================================================================================
# TESTS
#-----------------------------------------------------------------------------------------------------------
@[ "demo" ] = ( T, done ) ->

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
  done()



#===========================================================================================================
# HELPERS
#-----------------------------------------------------------------------------------------------------------
@_prune = ->
  for name, value of @
    continue if name.startsWith '_'
    delete @[ name ] unless name in include
  return null

#-----------------------------------------------------------------------------------------------------------
@_main = ->
  test @, 'timeout': 3000

############################################################################################################
unless module.parent?
  include = [
    "demo"
    ]
  @_prune()
  @_main()


  # debug '5562', JSON.stringify key for key in Object.keys @

