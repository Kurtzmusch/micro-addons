extends Control

@export var feedbackServerURL = 'http://<serverdomainname>/feedback'
@export var testURL = 'http://localhost:8080/feedback/'

@export var sendToTestURL = true

var buttonSend: Button
var labelReuestMessage: Label
var textEditFeedback: TextEdit

func _ready():
	buttonSend = find_child('ButtonSend')
	labelReuestMessage = find_child('LabelRequestMessage')
	textEditFeedback = find_child('TextEditFeedback')

func _process(delta):
	pass

func _on_http_request_request_completed(result, response_code, headers, body):
	var requestMessage = 'sent !'
	if result != HTTPRequest.RESULT_SUCCESS:
		requestMessage = "failed to send feedback ='("
	
	labelReuestMessage.text = requestMessage
	buttonSend.disabled = false

func _on_button_send_pressed():
	var url = feedbackServerURL
	if sendToTestURL:
		url = testURL
	buttonSend.disabled = true
	var sendText = textEditFeedback.text
	labelReuestMessage.text = 'sending ...'
	$HTTPRequest.request(url, [], HTTPClient.METHOD_POST, sendText)

func _on_button_close_pressed():
	visible = false
	queue_free()
