class T2Ku.Views.Console extends Backbone.View
  constructor:(options)->
    super(options)
    window.myCodeMirror = CodeMirror.fromTextArea($('#to_be_replaced')[0],
      lineNumbers: false
      readOnly: true
      theme: "t2math"
      mode: "plain"
    )

  setLoading:->
    myCodeMirror.setValue('Loading ...')
    this.LoadingDots = 0
    this.LoadingInterval = window.setInterval(->
      T2KuConsole.LoadingDots += 1
      T2KuConsole.LoadingDots %= 4
      svalue = 'Loading '
      if T2KuConsole.LoadingDots > 0
        svalue += '.' for i in [1..T2KuConsole.LoadingDots]
      myCodeMirror.setValue(svalue)
    ,500)

  setNotLoading:->
    window.clearInterval(this.LoadingInterval)

  setIndex:->
    