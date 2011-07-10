$ ->
  filename = "#{uuid()}.pdf"
  url = "http://paperprinten.s3.amazonaws.com/uploads/#{filename}"
  
  $printButton = $('.peecho-print-button')
  
  $('#upload').uploadify
    uploader: 'js/uploadify/uploadify.swf'
    script: 'http://paperprinten.s3.amazonaws.com'
    #script: 'http://localhost/~stephan/post_debug.php'
    method: 'post'
    multi: false
    fileExt: '*.pdf'
    fileDesc: 'Pdf'
    onError: (error) ->
      console.log error
    onComplete: (e, id, file, response, data) ->
      $text = $("<p class='success'>Uploaded file to <a href='#{url}'>#{url}</a></p>")
      $('#upload').replaceWith($text)
      $('#uploadUploader').hide()

      $printButton.attr 'data-src', url
      
      $('#step2').show()
    auto: true
    cancelImg: 'js/uploadify/cancel.png'
    fileDataName: 'file'
    scriptData:
      key: "uploads/#{filename}"
      success_action_status: 201
      'Content-Type': 'application/pdf'
      
  $('#step2 form').submit (e) ->
    $printButton.attr 'data-pages', $('#numPages').val()
    switch $('#size').val()
      when 'a4'
        $printButton.attr 'data-width', 210
        $printButton.attr 'data-height', 297
      when 'a5'
        $printButton.attr 'data-width', 148
        $printButton.attr 'data-height', 210
    
    $('#step3').show();
    false
      
uuid = ->
  'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
    r = Math.random()*16|0;v = if (c == 'x') then r else (r&0x3|0x8)
    v.toString(16);