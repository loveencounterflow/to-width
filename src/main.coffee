


############################################################################################################
CND                       = require 'cnd'
rpr                       = CND.rpr.bind CND
badge                     = 'TO-WIDTH'
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
# probes                    = require './probes'
@_width_of_string         = require 'string-width'
@_Wcstring                = require 'wcstring'


#-----------------------------------------------------------------------------------------------------------
@to_width = ( me, width, settings ) ->
  ### Fit text into `width` columns, taking into account ANSI color codes (that take up bytes but not width)
  and double-width glyphs such as CJK characters. ###
  throw new Error "width must at least be 2, got #{width}" unless width >= 2
  padder        = settings?[ 'padder'   ] ? ' '
  ellipsis      = settings?[ 'ellipsis' ] ? '…'
  R             = me
  old_width     = @width_of R
  return R if old_width is width
  #.........................................................................................................
  if old_width > ( width_1 = width - 1)
    ### `WCString` occasionally is off by one, so here we fix that: ###
    R = ( new @_Wcstring me ).truncate width_1, ''
    R += ellipsis + if ( ( @width_of R ) < width_1 ) then ellipsis else ''
  #.........................................................................................................
  else
    R = R + ' '.repeat width - old_width
  #.........................................................................................................
  return R

#-----------------------------------------------------------------------------------------------------------
@width_of = ( me ) => @_width_of_string me





