

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
TO_WIDTH                  = require './main'

#===========================================================================================================
# TESTS
#-----------------------------------------------------------------------------------------------------------
@[ "demo" ] = ( T, done ) ->

  show_to_width = ( texts... ) ->
    for n in [ 2 .. 4 ] by +1
      help n
      for text in texts
        text_truncated = TO_WIDTH.to_width text, n
        urge '|' + text_truncated + '|' + TO_WIDTH.width_of text_truncated
    for n in [ 5 .. 25 ] by +5
      help n
      for text in texts
        text_truncated = TO_WIDTH.to_width text, n
        urge '|' + text_truncated + '|' + TO_WIDTH.width_of text_truncated

  texts = [
    "北"
    "P"
    "Pe"
    "北京"
    "Peking"
    "a nice test to see the effects of fixed width"
    "xa\u0300xa\u0301xa\u0302xa\u0303xa\u0304xa\u0305xa\u0306xa\u0307xaxa\u0320xa\u0321xa\u0322xa\u0323xa\u0324xa\u0325xa\u0326xa\u0327xa"
    "a\u0300xa\u0301xa\u0302xa\u0303xa\u0304xa\u0305xa\u0306xa\u0307xaxa\u0320xa\u0321xa\u0322xa\u0323xa\u0324xa\u0325xa\u0326xa\u0327xa"
    "a\u20ddb\u20dec\u20dfa\u20ddb\u20dec\u20dfa\u20ddb\u20dec\u20dfa\u20ddb\u20dec\u20df"
    "北京 (Peking) 位於華北 (North China) 平原的西北边缘 (north-western border area)"
    "北京 (Peking) " + ( CND.white "位於華北" ) + CND.yellow " (North China) 平原的西北边缘 (north-western border area)"
    ]

  # show_to_fixed_width texts...
  # show_truncate       texts...
  show_to_width     texts...

  debug '0         1         2         3         '
  debug '0123456789012345678901234567890123456789'
  debug ( new TO_WIDTH._Wcstring "a nice test to see the effects of fixed width" ).truncate 30, '*'
  debug ( new TO_WIDTH._Wcstring "北京 (Peking) 位於華北 (North China) 平原的西北边缘 (north-western border area)" ).truncate 30, '*'
  debug ( new TO_WIDTH._Wcstring "北京 (Peking) " + ( CND.white "位於華北" ) + CND.yellow " (North China) 平原的西北边缘 (north-western border area)" ).truncate 30, '*'


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

