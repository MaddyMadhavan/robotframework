*** Settings ***
Library  add.py

*** Test Cases ***
Ret
	[Documentation]		Get the return value from the add function
	[Tags]			test1
	${res}	Add
	Log	${res}
