*** Settings ***
Library  Telnet
Library  OperatingSystem
Library  Dialogs

*** Variables ***
${CTRL_C}

*** Test Cases ***
Telnet login78
        [Documentation]         This is telnet login testing...
        [Tags]                  test1
        Open Connection         10.38.18.78
        Login                   root                    password
        Set Prompt              (root>)         prompt_is_regexp=yes
        ${CTRL_C}               Evaluate                chr(int(3))
        Set Timeout             10s
        Sleep                   5s
        Write Bare              ${CTRL_C}
        Read Until Prompt

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
	Should Match Regexp	${out}	Authentication is set to dhchap.

Set dhchap
        [Documentation]         Setting the secret key...
        [Tags]                  test4
	Write			secauthsecret --set
	Read Until		secrets >
	${new_line}		Evaluate	chr(int(13))
	Write Bare		${new_line}
	Read Until		(Leave blank when done):
	${wwn}			Get Value From User	Enter the wwn
	Write			${wwn}
	Read Until		Enter peer secret:
	${peer}			Get Value From User	Enter peer secret
	Write                   ${peer}
	Read Until		Re-enter peer secret:
	${peer}                 Get Value From User	Re-enter peer secret:
	Write			${peer}
	Read Until		Enter local secret:
	${local}                Get Value From User	Enter local secret
	Write			${local}
	Read Until		Re-enter local secret:
	${local}                Get Value From User	Re-enter local secret
	Write			${local}
	Read Until              (Leave blank when done):
	Write Bare		${new_line}
	Read Until		[no]
	${y}                	Get Value From User		say yes/no
	Write			${y}
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

*** Keywords ***

