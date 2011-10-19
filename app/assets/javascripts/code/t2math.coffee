CodeMirror.defineMode("T2Math", (config, parserConfig)->
  indentUnit = config.indentUnit
  indefinite_article = 'a'
  definite_article = 'the'
  last_element_of_is = (array,something) ->
    if 0==array.length
      return false
    else if something==array[array.length-1]
      return true
  
  verbParse = (stream, state,ch)->
    stream.eatWhile(/\w/)
    firstword = stream.string.slice(stream.start, stream.pos)
    if firstword is 'Let'
      state.verb=firstword
      return 'verb'
    if stream.eatSpace()
      pos=stream.pos
      stream.eatWhile(/\w/)
      secondword = stream.string.slice(pos, stream.pos)
      together = firstword+' '+secondword
      if /(^(Suppose|Prove) (that|tha|th|t|)$)/.test(together)
        if together is 'Suppose that' or together is 'Prove that'
          state.verb = together
          return 'verb'
        else
          # this verb is unfinished
          # go on writting it! (no bad feelings)
          # Well...I mean ... no red colorings
          return 'error-unfinished'
      else
        return 'error-undefined-verb'

  textParse = (stream, state,ch)->
    if ch is '$'
      #math environment started
      state.noun = '$'
      state.stack.push('$')
      return 'dollar'
    else if '.'==ch
      # time to start a new sentence
      state.verb = ''
      state.milestone = ''
      state.stack = []
      return 'end_of_sentence'
    else if ','==ch
      # not finished under the same verb
      state.verb='Let' if 'Let be'==state.verb
      state.stack = []
      state.milestone = ''
      state.noun= ''
      return 'comma_of_sentence'
    else if '_'==ch or /\W/.test(ch)
      #Other special characters are
      #not supposed to appear in text env
      return 'error-no-special-chars'
    else if /\d/.test(ch)
      #We shall give a hint
      #that numbers are supposed to be in math env
      return 'error-number-in-text'
    else if ''==state.verb
      return verbParse(stream,state,ch)
    else if state.milestone != ''
      switch state.milestone
        when 'is'
          #TODO
          return 'adjective'
        else
          #TODO
          return 'error-internal'
    else if 'Let'==state.verb
      if state.noun!=''
        stream.eatWhile(/\w/)
        word = stream.string.slice(stream.start,stream.pos)
        if 'be'==word
          state.verb='Let be'
          return 'verb'
        else
          return 'error-let-expecting-be'
      else
        return 'error-let-expecting-object'
    else if 'Let be'==state.verb
      if /\w/.test(ch)
        pos = stream.pos - 1
        while !stream.eol()
          stream.eatWhile(/\w/)
          word = stream.string.slice(pos,stream.pos)
          if ''==word
            break
          else if 'of'==word
            if stream.start != pos
              # stop here.`of` will be highlighted next time
              stream.pos = pos
              break
            else
              # this is the next time that we encounter `of`
              state.milestone = 'of'
              return 'keyword'
          else
            while stream.eatSpace()
              if stream.eol()
                break
          pos = stream.pos
        return 'complement'
      else
        #It should be impossible to reach here
        #since special characters in text env has already been dealt with
        return 'error-internal'
    else
      stream.eatWhile(/\w/)
      word = stream.string.slice(stream.start,stream.pos)
      if 'for'==word
        if stream.eatSpace()
          pos=stream.pos
          stream.eatWhile(/\w/)
          secondword = stream.string.slice(pos, stream.pos)
          together = word+' '+secondword
          if /(^(for) (all|al|a|some|som|so|s|)$)/.test(together)
            if 'for all' == together or 'for some' == together
              state.milestone = together
              return 'keyword'
            else
              # this keyword is unfinished
              # go on writting it! (no bad feelings)
              # Well...I mean ... no red colorings
              return 'error-unfinished'
          else
            # We only accept
            # "for all" or "for some"
            return 'error-for-expecting-all-or-some'
      else if 'is'==word
        state.milestone = 'is'
        return 'keyword'
      else
        # T2Math won't understand this
        return 'error'
      
  mathParse = (stream, state,ch)->
    if ch is '$'
      #math environment is over
      pop = state.stack.pop()
      if '$'==pop
        return 'dollar'
      else
        state.stack.push(pop)
        return 'error-math-mismatch'
    else if '{'==ch
      state.stack.push('{')
      return 'braces'
    else if '}'==ch
      pop = state.stack.pop()
      if '{'==pop
        return 'braces'
      else
        state.stack.push(pop)
        return 'error-math-mismatch'
    else if ch is '\\'
      stream.eatWhile(/[\w]/)
      return 'tag'
    else if /[*+-=_]/.test(ch)
      return 'operator'
    else
      stream.eatWhile(/\w/)
      return 'variable'
    
  return {
    startState:(base)->
      verb: ''
      noun: ''
      milestone: ''
      stack: []
      baseIndent: base || 0
    
    token:(stream, state)->
      return null if stream.eatSpace()
      # Are we inside a math environment?
      if -1==$.inArray('$',state.stack)
        insidemath = false
      else
        insidemath = true
      #caution: must eat at least one next character
      ch = stream.next()
      if '%'==ch
        stream.skipToEnd()
        return 'comment'
      if insidemath
        result = mathParse(stream,state,ch)
        state.noun += stream.string.slice(stream.start,stream.pos)
        return result
      else
        return textParse(stream,state,ch)
        
    indent:(state, textAfter)->
      n = state.stack.length;
      if state.verb!=''
        return state.baseIndent + (n+1) * indentUnit;
      else
        return 0
  }
)

CodeMirror.defineMIME("text/x-t2math", "T2Math")
