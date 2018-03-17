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

### `global.sh`

- `$Y` - `"Y"`
- `$N` - `"N"`
- `getArg(name)` — get commandline an argument value
- `default(value, defaultValue)`
- `required(value, errorMessage)`
- `assignVar(ref, val)`

---

### `emoji.sh`

#### `emojiStatus(status)`
```sh
# Statuses: ok, err, done
echo "Wow" $(emojiStatus ok);
```

---

### `colors.sh`

#### const
- `$COLOR_RESET` or `$COLOR_CLR`
- `$COLOR_MSG`
- `$COLOR_ERR`
- `$COLOR_DONE`
- `$COLOR_WARN`
- `$COLOR_INFO`
- `$COLOR_VAR`
- `$COLOR_VERBOSE`

#### Color methods
- `colorize(color, text)`
- `colorRemove(text)`

---

### `log.sh`
```sh
# If you needed VERBOSE, then:
LOG_LEVEL=$(($LOG_LEVEL | $LOG_LEVEL_VERBOSE));
```

#### Levels (bits)
- `$LOG_LEVEL_ERR`
- `$LOG_LEVEL_DONE`
- `$LOG_LEVEL_WARN`
- `$LOG_LEVEL_INFO`
- `$LOG_LEVEL_VERBOSE`
- `$LOG_LEVEL` — bitwise mask, by default includes: `ERR`, `DONE`, `WARN` and `INFO`

#### `log(type, ...rest)`
```sh
# Types: msg, err, done, info, warn, verbose
echo $(log "done" "All files removed")
```

#### Shortcuts
 - `logMsg(...rest)`
 - `logErr(...rest)`
 - `logDone(...rest)`
 - `logInfo(...rest)`
 - `logWarn(...rest)`
 - `logVerbose(...rest)` - don't remember about `LOG_LEVEL`

 ---

 ### `git.sh`

- `gitPull()`
- `gitCurrentBranch()` — get current branch name
- `gitIsCurrentBranch(name): "Y" | "N"`
- `gitSwitchBranch(name)`

---

### `string.sh`

- `stringGetMatch(regexp, text)`
- `stringTrim(text)`
- `stringLength(text)` — without color codes

---

### `exec.sh`

- `execute(cmd)`
- `executeIf(s, cmd)` — where first argument: `Y` or `N`
- `executeIfNot(s, cmd)`

---

### `time.sh`

- `now()` — current timestamp

---

### `input.sh`

- `inputRead(msg, varName)`
- `inputReadSecure(msg, varName)`
- `inputReadChar(msg, varName)`
- `inputReadYesNo(msg, varName[[, defaultAnswer = Y | N], attempts = 2])`

```sh
inputReadYesNo "Connect to server" q $N
if [[ $q == $Y ]]; then
	inputRead "Enter login:" login
	inputReadSecure "Enter password:" pass
fi
```
