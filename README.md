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

---

### Features

- AutoUpdate support 🚀
- Easy and intuitive development 💡
- Logging (levels supports), Colors and Emoji 😁
- Documentation 📑

---

### Development

 - `./all.sh --bashkit-docs` — Docs generator.

<!--api-->
---

### [risk.sh](./risk.sh)

#### Constants
- [$RISK_FLAGS](./risk.sh#L3)

#### Functions

##### [riskCreate](./risk.sh#L5-L13) `[branch]`
- [branch] — create risk for git-branch

##### [riskPush](./risk.sh#L15-L23) `name branch`
- name — tarball name
- branch — risk branch

##### [riskSwitch](./risk.sh#L25-L33) `name branch`
- name — tarball name
- branch — risk branch

##### [riskAlpha](./risk.sh#L35-L40) `name`
- name — tarball name

##### [riskRemove](./risk.sh#L42-L51) `name [branch=trb]`
- name — tarball name
- [branch=trb] — risk branch

##### [riskAutoRemove](./risk.sh#L53-L80) `[branch]`
- [branch] — risk branch

---

### [fs.sh](./fs.sh)


##### [fsGetFiles](./fs.sh#L3-L9) `path [depth=1]`

##### [fsReadFile](./fs.sh#L11-L17) `file`

##### [fsWriteFile](./fs.sh#L19-L23) `file content`

##### [fsReplaceInFile](./fs.sh#L25-L31) `file pattern value`

##### [fsReplaceInFiles](./fs.sh#L33-L42) `path pattern value`

##### [fsFileExists](./fs.sh#L44-L51) `file`

##### [fsReadFileIfExists](./fs.sh#L53-L58) `file`

---

### [input.sh](./input.sh)


##### [inputRead](./input.sh#L3-L9) `text ref`

##### [inputReadSecure](./input.sh#L11-L15) `text ref`

##### [inputReadChar](./input.sh#L17-L24) `text ref`

##### [inputReadYesNo](./input.sh#L26-L70) `text ref [def=$N] [attempts=2]`

##### [inputSelect](./input.sh#L98-L144) `text ref ...items`
- ref — will contains a selected index

---

### [array.sh](./array.sh)


##### [arrayIncludes](./array.sh#L3-L14) `value ...list`
- ...list — for example `arrayIncludes "y" "x" "y"`, or `arrayIncludes $val ${list[@]}`

---

### [string.sh](./string.sh)


##### [stringTest](./string.sh#L3-L11) `regex value`

##### [stringGetMatch](./string.sh#L13-L19) `regex value`

##### [stringGetMatches](./string.sh#L21-L27) `regex value`

##### [stringTrim](./string.sh#L29-L44) `value`

##### [stringLength](./string.sh#L46-L54) `value`

##### [stringCutAfter](./string.sh#L56-L61) `sep text`

##### [stringCutBefore](./string.sh#L63-L68) `sep text`

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

##### [colorize](./colors.sh#L15-L19) `color ...text`

##### [colorRemove](./colors.sh#L21-L28) `...text`

---

### [git.sh](./git.sh)

#### Constants
- [$GIT_BRANCH](./git.sh#L31)

#### Functions

##### [gitIsCurrentBranch](./git.sh#L15-L22) `name`

##### [gitSwitchBranch](./git.sh#L24-L29) `name`

---

### [time.sh](./time.sh)


##### [timeParse](./time.sh#L7-L19) `value`
- value — ex.: `2s`, `5m`, `24h` or `5d`

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

##### [log](./log.sh#L14-L50) `level ...msg`
- level — msg, ok, done, info, warn, err, verbose

##### [logMsg](./log.sh#L52-L55) `...msg`

##### [logErr](./log.sh#L57-L60) `...msg`

##### [logDone](./log.sh#L62-L65) `...msg`

##### [logWarn](./log.sh#L67-L70) `...msg`

##### [logInfo](./log.sh#L72-L75) `...msg`

##### [logVerbose](./log.sh#L77-L80) `...msg`

##### [hrLine](./log.sh#L82-L88) `...msg`

##### [logHead](./log.sh#L90-L93) `text`

##### [logFinish](./log.sh#L95-L112) `[status] [done=DONE] [failed=FAILED]`

---

### [global.sh](./global.sh)

#### Constants
- [$Y](./global.sh#L3)
- [$N](./global.sh#L4)
- [$GNU_SED](./global.sh#L5)
- [$DIRNAME](./global.sh#L8)
- [$FILENAME](./global.sh#L9)
- [$SECOND](./global.sh#L11)
- [$HOUR](./global.sh#L12)
- [$ARGS](./global.sh#L14)

#### Functions

##### [default](./global.sh#L16-L24) `val`

##### [required](./global.sh#L26-L35) `val errMsg`

##### [assignVar](./global.sh#L37-L41) `ref val`

##### [getArg](./global.sh#L43-L50) `name`

##### [RE](./global.sh#L52-L62) `pattern forSED`

##### [range](./global.sh#L64-L68) `from to`

##### [md5hash](./global.sh#L70-L77) `value`

---

### [package-json.sh](./package-json.sh)

#### Constants
- [$PKG_JSON_RAW](./package-json.sh#L14)
- [$PKG_JSON_NAME](./package-json.sh#L15)
- [$PKG_JSON_VERSION](./package-json.sh#L16)
- [$PKG_JSON_DESCRIPTION](./package-json.sh#L17)
- [$PKG_JSON_AUTHOR](./package-json.sh#L18)
- [$PKG_JSON_MAIN](./package-json.sh#L19)
- [$PKG_JSON_GIT_URL](./package-json.sh#L20)

#### Functions

##### [pkgJsonRead](./package-json.sh#L3-L6) `path`

##### [pkgJsonReadProp](./package-json.sh#L8-L12) `raw prop`
- raw — a result of `pkgJsonRead`

---

### [exec.sh](./exec.sh)

#### Constants
- [$EXEC_OK](./exec.sh#L3)
- [$EXEC_ERR](./exec.sh#L4)

#### Functions

##### [execute](./exec.sh#L6-L29) `cmd [ref-status]`
- [ref-status] — execution result status, `$EXEC_OK` — success, else failed

##### [executeStatus](./exec.sh#L31-L38) `code`

##### [executeIf](./exec.sh#L40-L49) `cond cmd [ref-status]`
- cond — $Y/$EXEC_OK or $N
- [ref-status] — execution result status, `$EXEC_OK` — success, else failed

##### [executeIfNot](./exec.sh#L51-L57) `cond cmd`
- cond — $Y/$EXEC_OK or $N

---

### [emoji.sh](./emoji.sh)


##### [emojiStatus](./emoji.sh#L7-L19) `[name=done]`
- [name=done] — `ok`, `err` or `done`

---

### [recently.sh](./recently.sh)


##### [recently](./recently.sh#L3-L85) `name period ...fn`
- period — ex: `300s`, `24h` or `7d`
