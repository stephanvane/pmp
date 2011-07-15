sizes = 
  a4: [210, 297]
  a5: [148, 210]

$ ->
  filename = "#{uuid()}.pdf"
  url = "http://www.printmijnscriptie.nl.s3.amazonaws.com/uploads/#{filename}"
  $printButton = $('.peecho-print-button')
  
  # Uploader
  $('#upload').uploadify
    uploader: 'js/uploadify/uploadify.swf'
    script: 'http://www.printmijnscriptie.nl.s3.amazonaws.com'
    method: 'post'
    multi: false
    fileExt: '*.pdf'
    fileDesc: 'Pdf'
    auto: true
    cancelImg: 'js/uploadify/cancel.png'
    fileDataName: 'file'
    scriptData:
      key: "uploads/#{filename}"
      success_action_status: 201
      'Content-Type': 'application/pdf'
    
    #events
    onComplete: (e, id, file, response, data) ->
      $text = $("<p class='success'>Successfully uploaded file</p>")
      $('#upload').replaceWith($text)
      $('#uploadUploader').hide()

      $printButton.attr 'data-src', url

      $('#step2').show()
    onError: (event, id, fileObj, errorObj) ->
      console.log event
      console.log id
      console.log fileObj
      console.log errorObj

  $('#step2 form').submit ->
    $printButton.attr 'data-pages', $('#numPages').val()
    size = sizes[$('#size').val()]
    $printButton.attr 'data-width', size[0]
    $printButton.attr 'data-height', size[1]
    
    $('#step3').show();
    false
      
uuid = ->
  'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
    r = Math.random()*16|0;v = if (c == 'x') then r else (r&0x3|0x8)
    v.toString(16);