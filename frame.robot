*** Settings ***
Library  Telnet
Library  OperatingSystem

*** Variables ***
${CTRL_C}

*** Test Cases ***
Telnet login78
	[Documentation]		This is telnet login on sw1...
	[Tags]			test1
	Open Connection		10.38.18.78
	Login			root			password
	Set Prompt		(root>)		prompt_is_regexp=yes
	${CTRL_C}		Evaluate		chr(int(3))
	Set Timeout		10s
	Sleep			5s
	Write Bare		${CTRL_C}
	Read Until Prompt

Telnet login79
	[Documentation]		This is telnet login on sw2...
	[Tags]			test2
	Open Connection		10.38.18.79
	Login			root			fibranne
	Set Prompt		(root>)		prompt_is_regexp=yes
	${CTRL_C}		Evaluate		chr(int(3))
	Set Timeout		10s
	Sleep			5s
	Write Bare		${CTRL_C}
	Read Until Prompt

switchshow on sw1
	[Documentation]		showing the sw1 details
	[Tags]			test3
	Switch Connection	1	
	Write			switchshow
	Read Until Prompt

switchshow on sw2
	[Documentation]		showing the sw2 details
	[Tags]			test4
	Switch Connection	2
	Write			switchshow
	Read Until Prompt

fabricshow on sw1
	[Documentation]		showing the sw1 fabric details
	[Tags]			test5
	Switch Connection	1
	Write			fabricshow
	Read Until Prompt
