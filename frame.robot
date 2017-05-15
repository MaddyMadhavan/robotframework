*** Settings ***
Library  add.py
Library  BuiltIn

*** Test Cases ***
Ret
	[Documentation]		Check the expected value from the addition function
	[Tags]			test1
	${res}	Add
	${str}  Convert to String	${res}
	Should Be Equal		${str}	30
