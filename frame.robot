*** Settings ***
Library  Telnet
Library  OperatingSystem
Library  Dialogs
Library  Screenshot
Library  String
Suite Setup	Init
Suite Teardown	Cleanall

*** Variables ***

*** Test Cases ***
Auth show
        [Documentation]         Showing the authentication details...
        [Tags]                  test2
	Write			authutil --show
	Read Until Prompt

Auth dhchap
        [Documentation]         Trying to set the dhchap authentication...
        [Tags]                  test3
	Write			authutil --set -a dhchap
	${out}			Read Until Prompt
	${new}			Should Match Regexp	${out}	Authentication is set to dhchap.
	Set Global Variable	${new}

Set dhchap
        [Documentation]         Setting the secret key...
        [Tags]                  test4
	[Teardown]		Terminate	
	Pass Execution If	'${PREV TEST STATUS}'=='PASS'	dhchap already set.
	Write			secauthsecret --set
	Read Until		secrets >
	${new_line}		Evaluate	chr(int(13))
	Write Bare		${new_line}
	Read Until		(Leave blank when done):
	${wwn}			Get Value From User	Enter the wwn
	Write			${wwn}
	Read Until		Enter peer secret:
	${peer}			Get Value From User	Enter peer secret	hidden=yes
	Write                   ${peer}
	Read Until		Re-enter peer secret:
	${peer}                 Get Value From User	Re-enter peer secret:	hidden=yes
	Write			${peer}
	Read Until		Enter local secret:
	${local}                Get Value From User	Enter local secret	hidden=yes
	Write			${local}
	Read Until		Re-enter local secret:
	${local}                Get Value From User	Re-enter local secret	hidden=yes
	Write			${local}
	Read Until              (Leave blank when done):
	Write Bare		${new_line}
	Read Until		[no]
	${input}		Get Selection From User		Authentication: on/off	 yes	no
#	Pause Execution		Do you want to continue ?
	Write			${input}
	Read Until Prompt

dhchap auth
        [Documentation]         Again trying to set the dhchap authentication...
        [Tags]                  test5
	Write			authutil --set -a dhchap
	${out}			Read Until Prompt
	Should Match Regexp	${out}	Authentication is set to dhchap.

dhchap show
        [Documentation]         Showing the dhchap details...
        [Tags]                  test6
	Write			secauthsecret --show
	Read Until Prompt

Auth on
        [Documentation]         Turn on the authentication...
        [Tags]                  test7
	Write			echo y | authutil --policy -sw on
	${out}			Read Until Prompt
	Should Match Regexp	${out}	set to ON

Auth off
        [Documentation]         Turn off the authentication...
        [Tags]                  test8
	Write			echo y | authutil --policy -sw off
	${out}			Read Until Prompt
	Should Match Regexp	${out}	set to OFF

dhchap remove
        [Documentation]         Removing the dhchap...
        [Tags]                  test9
	Write			echo y | secauthsecret --remove -all
	Read Until Prompt

Grep string
	[Documentation]		Grep the string from the given file
	[Tags]			test10
	${ss}			Get File	SLOT1cp-Edge_Alleg_10-10.20.113.10-201610252232-SUPPORTSHOW_ALL
	${str_in}		Get Value From User	Enter the string to be grep
	${out}			Get Lines Containing String	${ss}	${str_in}	case_insensitive=yes
	Log			${out}

*** Keywords ***
Init
        [Documentation]         This is telnet login testing...
        [Tags]                  test1
        Open Connection         10.38.18.79
        Login                   root                  	fibranne 
        Set Prompt              (root>)         prompt_is_regexp=yes
        ${CTRL_C}               Evaluate                chr(int(3))
        Set Timeout             10s
	Sleep			5s
	Write Bare		${CTRL_C}
        Read Until Prompt

Cleanall
	Run Keyword	Close All Connections
	Run Keyword	Take Screenshot		mypic

Terminate
        Set Prompt              (root>)         prompt_is_regexp=yes
        ${CTRL_C}               Evaluate                chr(int(3))
	Run Keyword If Test Failed	Write Bare	${CTRL_C}

