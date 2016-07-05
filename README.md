
![](https://github.com/loveencounterflow/to-width/raw/master/art/Screen%20Shot%202016-07-05%20at%2016.44.59.png)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [To-Width](#to-width)
  - [Why?](#why)
    - [Dependencies](#dependencies)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# To-Width

**The essential building block for command line tables: truncate & pad strings
to given width, taking care of wide characters, accents and ANSI colors.**

## Why?

Because I need tabular data display on the command line and was dissatisfied
with existing solutions. There are some promising modules for doing this on
[npm](http://npmjs.org), but nothing that satisfied me in the end. I then
realized that the key requirement for doing tables in the terminal is the
ability to format data so that each chunk of text (that you build table cells
with) has exactly the correct visual width.

In programming languages and fixed-width displays, there are at least three meaningful measures of text 'length':

* **Length**—How many code units are used by a given programming language? In
  JavaScript, this measure is obtained by retrieving the value of `text.length`,
  and indeed, this is often used to implement simple-minded string truncation
  and padding when lines of constant length are desired. Be it said that the only two justifications for considering `text.length`

* **Size**—How long a string is under some special interpretation of its contents; for example, the string
`'a&#98x;c'` has a length of 8, but a size of 3 when NCRs are rendered as their corresponding code
points.

* **Width**—How wide does a given text appear on the screen? This is a tricky
  question, even if we reframe it a bit and try to answer, not "how many
  millimeters does this text take up", but, much more interestingly, "if I
  assume a monospaced (a.k.a fixed-width, non-proportional) font and a 'gauge' of
  (say) ten characters `0123456789`, then how many characters of a given text will
  fit into the exact same horizontal space?".


  Strictly speaking, we can only find out by this must ignore color codes and
  take CJK &c. into account; also, it should support [combining
  characters](https://en.wikipedia.org/wiki/Combining_character)


### Dependencies

The functionality of this module has been implemented using

* https://github.com/sindresorhus/string-width and
* https://github.com/martinheidegger/wcstring;

these packages have also been considered:

* https://github.com/chalk/strip-ansi
* https://github.com/chalk/ansi-styles
* https://github.com/jbnicolai/ansi-256-colors
* https://github.com/nexdrew/ansi-align
* https://github.com/sindresorhus/boxen
* https://github.com/sindresorhus/string-length
* https://github.com/sindresorhus/cli-truncate
* https://github.com/chalk/wrap-ansi
* https://github.com/chalk/slice-ansi
* https://github.com/substack/fixed-width-float

