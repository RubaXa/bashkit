~/.bashkit/
-----------
It is the toolset for the developing bash scripts.

### Usage
![iterm2](https://habrastorage.org/webt/xd/2e/pt/xd2eptkfqtbqn-b2jn6ocylwgdi.png)

```sh
#!/bin/bash

if [ ! -d $HOME/.bashkit/ ]; then echo 'Install `~/.bashkit/`'; git clone git@github.com:RubaXa/bashkit.git $HOME/.bashkit; fi
source "$HOME/.bashkit/all.sh";

inputRead "Enter %username%:" name;
hrLine $(logDone "Hi, $name" $(emojiStatus "ok"));

inputReadYesNo "Are you wish to play even/odd?" game $Y;
if [[ $game == $Y ]]; then
	echo "";

	while : ; do
		inputReadChar "Even/Odd (e/o)?:" ans
		num=$RANDOM;
		echo -n "Number $num is" ""

		if (( $num % 2 == 0 )); then echo -n "Even!"; res="e";
		else echo -n "Odd!"; res="o"; fi

		if [[ $res == $ans ]]; then
			echo "" $(colorize $COLOR_DONE "You WIN!") $(emojiStatus done);
		else
			echo "" $(colorize $COLOR_ERR "You LOOSE!") $(emojiStatus err);
		fi

		echo ""
	done
fi
```
<!--api-->
---

### [colors.sh](./colors.sh)

#### Constants
- [$COLOR_CLR](./colors.sh#L4)
- [$COLOR_RESET](./colors.sh#L5)
- [$COLOR_TXT](./colors.sh#L7)
- [$COLOR_ERR](./colors.sh#L8)
- [$COLOR_DONE](./colors.sh#L9)
- [$COLOR_INFO](./colors.sh#L10)
- [$COLOR_WARN](./colors.sh#L11)
- [$COLOR_VERBOSE](./colors.sh#L12)
- [$COLOR_VAR](./colors.sh#L13)

#### Functions

##### [colorize](./colors.sh#L15-19)
- color
- ...text

##### [colorRemove](./colors.sh#L21-28)
- ...text

---

### [exec.sh](./exec.sh)


#### Functions

##### [execute](./exec.sh#L3-9)
- cmd

##### [executeStatus](./exec.sh#L11-18)
- code

##### [executeIf](./exec.sh#L20-30)
- cond
- cmd

##### [executeIfNot](./exec.sh#L32-38)
- cond
- cmd

---

### [fs.sh](./fs.sh)


#### Functions

##### [fsGetFiles](./fs.sh#L3-8)
- path

##### [fsReadFile](./fs.sh#L10-16)
- file

##### [fsWriteFile](./fs.sh#L18-22)
- file
- content

---

### [git.sh](./git.sh)

#### Constants
- [$GIT_BRANCH](./git.sh#L31)

#### Functions

##### [gitIsCurrentBranch](./git.sh#L15-22)
- name

##### [gitSwitchBranch](./git.sh#L24-29)
- name

---

### [global.sh](./global.sh)

#### Constants
- [$Y](./global.sh#L3)
- [$N](./global.sh#L4)
- [$GNU_SED](./global.sh#L5)
- [$SECOND](./global.sh#L7)
- [$HOUR](./global.sh#L8)
- [$ARGS](./global.sh#L10)

#### Functions

##### [default](./global.sh#L12-20)
- val

##### [required](./global.sh#L22-31)
- val
- errMsg

##### [assignVar](./global.sh#L33-37)
- ref
- val

##### [getArg](./global.sh#L39-46)
- name

---

### [input.sh](./input.sh)


#### Functions

##### [inputRead](./input.sh#L3-9)
- text
- ref

##### [inputReadSecure](./input.sh#L11-15)
- text
- ref

##### [inputReadChar](./input.sh#L17-24)
- text
- ref

##### [inputReadYesNo](./input.sh#L26-65)
- text
- ref

---

### [log.sh](./log.sh)

#### Constants
- [$LOG_LEVEL_ERR](./log.sh#L3)
- [$LOG_LEVEL_DONE](./log.sh#L4)
- [$LOG_LEVEL_WARN](./log.sh#L5)
- [$LOG_LEVEL_INFO](./log.sh#L6)
- [$LOG_LEVEL_VERBOSE](./log.sh#L7)
- [$LOG_LEVEL](./log.sh#L8)

#### Functions

##### [log](./log.sh#L14-50)
- level
- ...msg

##### [logMsg](./log.sh#L52-55)
- ...msg

##### [logErr](./log.sh#L57-60)
- ...msg

##### [logDone](./log.sh#L62-65)
- ...msg

##### [logWarn](./log.sh#L67-70)
- ...msg

##### [logInfo](./log.sh#L72-75)
- ...msg

##### [logVerbose](./log.sh#L77-80)
- ...msg

##### [hrLine](./log.sh#L82-88)
- ...msg

---

### [risk.sh](./risk.sh)

#### Constants
- [$RISK_FLAGS](./risk.sh#L3)

#### Functions

##### [riskPush](./risk.sh#L15-23)
- name
- branch

##### [riskSwitch](./risk.sh#L25-33)
- name
- branch

##### [riskAlpha](./risk.sh#L35-40)
- name

##### [riskRemove](./risk.sh#L42-51)
- name

---

### [string.sh](./string.sh)


#### Functions

##### [stringGetMatch](./string.sh#L3-9)
- regex
- value

##### [stringTrim](./string.sh#L11-26)
- value

##### [stringLength](./string.sh#L28-36)
- value

##### [stringCutAfter](./string.sh#L38-43)
- sep
- text

##### [stringCutBefore](./string.sh#L45-50)
- sep
- text


