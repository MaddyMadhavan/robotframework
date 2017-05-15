*** Settings ***
Library  Telnet
Library  OperatingSystem

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

Auth fcap
        [Documentation]         Trying to set the fcap authentication...
        [Tags]                  test4
	Write			authutil --set -a fcap
	${out}			Read Until Prompt
	Should Match Regexp	${out}	Authentication is set to fcap.

*** Keywords ***

