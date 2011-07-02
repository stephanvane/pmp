$ ->
  filename = "#{uuid()}.pdf"
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
      url = "http://paperprinten.s3.amazonaws.com/uploads/#{filename}"
      $text = $("<p class='success'>Uploaded file to <a href='#{url}'>#{url}</a></p>")
      $('#upload').replaceWith($text)
    auto: true
    cancelImg: 'js/uploadify/cancel.png'
    fileDataName: 'file'
    scriptData: { key: "uploads/#{filename}", success_action_status: 201, 'Content-Type': 'application/pdf' }
  console.log filename
    
uuid = ->
  'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
    r = Math.random()*16|0;v = if (c == 'x') then r else (r&0x3|0x8)
    v.toString(16);