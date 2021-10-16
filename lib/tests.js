(function() {
  //###########################################################################################################
  var CND, alert, badge, debug, echo, help, info, log, rpr, test, urge, warn, whisper;

  CND = require('cnd');

  rpr = CND.rpr.bind(CND);

  badge = 'TO-WIDTH/tests';

  log = CND.get_logger('plain', badge);

  info = CND.get_logger('info', badge);

  whisper = CND.get_logger('whisper', badge);

  alert = CND.get_logger('alert', badge);

  debug = CND.get_logger('debug', badge);

  warn = CND.get_logger('warn', badge);

  help = CND.get_logger('help', badge);

  urge = CND.get_logger('urge', badge);

  echo = CND.echo.bind(CND);

  //...........................................................................................................
  test = require('guy-test');

  //...........................................................................................................

  //===========================================================================================================
  // TESTS
  //-----------------------------------------------------------------------------------------------------------
  this["demo"] = function(T, done) {
    var alignments_and_texts, colors, show, stripe, to_width, width_of;
    ({to_width, width_of} = require('./main'));
    show = function() {
      var align, border, i, j, len, len1, n, ref, results, text;
      border = CND.blue('│');
      ref = [2, 3, 4, 10, 20, 30];
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        n = ref[i];
        info();
        help(n);
        info(CND.blue('┌' + ('─'.repeat(n)) + '┐'));
        info(CND.blue('│    .    1    .    2    .    3    .    4'.slice(0, +n + 1 || 9e9) + '│'));
        info(CND.blue('│1234567890123456789012345678901234567890'.slice(0, +n + 1 || 9e9) + '│'));
        info(CND.blue('├' + ('─'.repeat(n)) + '┤'));
        for (j = 0, len1 = alignments_and_texts.length; j < len1; j++) {
          [align, text] = alignments_and_texts[j];
          text = CND.white(text);
          text = to_width(text, n, {align});
          info(border + text + border + ' ' + (CND.blue(width_of(text)))); // + ' ' + ( CND.yellow text.length )
        }
        // info '╭' + ( '─'.repeat n ) + '╮'
        // info '╰' + ( '─'.repeat n ) + '╯'
        results.push(info('└' + ('─'.repeat(n)) + '┘'));
      }
      return results;
    };
    colors = [CND.gold, CND.steel];
    stripe = function(text) {
      var glyph, idx;
      return ((function() {
        var i, len, ref, results;
        ref = Array.from(text);
        results = [];
        for (idx = i = 0, len = ref.length; i < len; idx = ++i) {
          glyph = ref[idx];
          results.push(colors[idx % 2](glyph));
        }
        return results;
      })()).join('');
    };
    alignments_and_texts = [['left', "北"], ['center', "北"], ['right', "北"], ['center', "X"], ['center', "北京市"], ['left', "Peking"], ['center', "Peking"], ['right', "Peking"], ['center', "xa\u0300xa\u0301xa\u0302xa\u0303xa\u0304xa\u0305xa\u0306xa\u0307xaxa\u0320xa\u0321xa\u0322xa\u0323xa\u0324xa\u0325xa\u0326xa\u0327xa"], ['center', stripe("北京位於華北 (North China) 平原的西北边缘 (north-western border area)")]];
    show();
    return typeof done === "function" ? done() : void 0;
  };

  //-----------------------------------------------------------------------------------------------------------
  this["demo 2"] = function(T, done) {
    var to_width, width_of;
    ({to_width, width_of} = require('./main'));
    info('abcd', 'abcd'.length, Buffer.byteLength('abcd'), width_of('abcd'));
    info('äöüß', 'äöüß'.length, Buffer.byteLength('äöüß'), width_of('äöüß'));
    info('a\u0308o\u0308u\u0308ß', 'a\u0308o\u0308u\u0308ß'.length, Buffer.byteLength('a\u0308o\u0308u\u0308ß'), width_of('a\u0308o\u0308u\u0308ß'));
    info('北京', '北京'.length, Buffer.byteLength('北京'), width_of('北京'));
    info('𪜀𪜁', '𪜀𪜁'.length, Buffer.byteLength('𪜀𪜁'), width_of('𪜀𪜁'));
    info();
    info('abcd', '#' + (to_width('abcdabcd', 4)) + '#');
    info('äöüß', '#' + (to_width('äöüßäöüß', 4)) + '#');
    info('a\u0308o\u0308u\u0308ß', '#' + (to_width('a\u0308o\u0308u\u0308ßa\u0308o\u0308u\u0308ß', 4)) + '#');
    info('北京', '#' + (to_width('北京北京', 4)) + '#');
    info('𪜀𪜁', '#' + (to_width('𪜀𪜁𪜀𪜁', 4)) + '#');
    return done();
  };

  //-----------------------------------------------------------------------------------------------------------
  this["width_of"] = async function(T, done) {
    var error, i, len, matcher, probe, probes_and_matchers, to_width, width_of;
    ({to_width, width_of} = require('./main'));
    //.........................................................................................................
    probes_and_matchers = [['', 0, null], ['-', 1, null], ['--', 2, null], ['-a-', 3, null], ['-a', 2, null], ['a-', 2, null], ['helo', 4, null], ['helo-world', 10, null], ['HELO-WORLD', 10, null], ['µ-DOM', 5, null], ['danish-øre', 10, null], ['北京𪜀𪜁', 8, null]];
    for (i = 0, len = probes_and_matchers.length; i < len; i++) {
      [probe, matcher, error] = probes_and_matchers[i];
      await T.perform(probe, matcher, error, function() {
        return new Promise(function(resolve) {
          var result;
          result = width_of(probe);
          return resolve(result);
        });
      });
    }
    //.........................................................................................................
    done();
    return null;
  };

  //-----------------------------------------------------------------------------------------------------------
  this["to_width"] = async function(T, done) {
    var error, i, len, matcher, probe, probes_and_matchers, to_width, width_of;
    ({to_width, width_of} = require('./main'));
    //.........................................................................................................
    probes_and_matchers = [[['', 5], '     ', null], [['-', 5], '-    ', null], [['--', 5], '--   ', null], [['-a-', 5], '-a-  ', null], [['-a', 5], '-a   ', null], [['a-', 5], 'a-   ', null], [['helo', 5], 'helo ', null], [['helo-world', 5], 'helo…', null], [['helo-world', 15], 'helo-world     ', null], [['HELO-WORLD', 5], 'HELO…', null], [['HELO-WORLD', 15], 'HELO-WORLD     ', null], [['µ-DOM', 5], 'µ-DOM', null], [['danish-øre', 5], 'dani…', null], [['北京𪜀𪜁', 5], '北京…', null], [['北京𪜀𪜁', 15], '北京𪜀𪜁       ', null]];
    for (i = 0, len = probes_and_matchers.length; i < len; i++) {
      [probe, matcher, error] = probes_and_matchers[i];
      await T.perform(probe, matcher, error, function() {
        return new Promise(function(resolve) {
          var text, width;
          [text, width] = probe;
          // debug '^33985^', { text, width, }
          return resolve(to_width(text, width));
        });
      });
    }
    //.........................................................................................................
    done();
    return null;
  };

  //###########################################################################################################
  if (module.parent == null) {
    test(this);
  }

}).call(this);

//# sourceMappingURL=tests.js.map