~/.bashkit/
-----------
It is this toolset for the developing bash scripts.

### Usage
```sh
#!/bin/bash

if [ ! -d ~/.bashkit/ ]; then echo 'Install `~/.bashkit/`'; git clone git@github.com:RubaXa/bashkit.git $HOME/.bashkit; fi
source "$HOME/.bashkit/all.sh";

logInfo "Hello!" $(emojiStatus "ok");
```

---

### `global.sh`

- `$Y` - `"Y"`
- `$N` - `"N"`
- `getArg(name)` — get commandline argument value [or `$Y` (@todo)]
- `default(value, defaultValue)`
- `required(value, errorMessage)`

---

### `emoji.sh`

#### `emojiStatus(status)`
```sh
# Statuses: ok, err, done
echo "Wow" $(emojiStatus ok);
```

---

### `colors.sh`

#### Types
- `$COLOR_RESET` or `$COLOR_CLR`
- `$COLOR_ERR`
- `$COLOR_DONE`
- `$COLOR_WARN`
- `$COLOR_INFO`
- `$COLOR_VERBOSE`

#### `colorize(type, text)`
```sh
echo $(colorize $COLOR_ERR "System error!")
```

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
# Types: err, done, info, warn, verbose
echo $(log "done" "All files removed")
```

#### Shortcuts
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

### `exec.sh`

- `execute(cmd)`
- `executeIf(s, cmd)` — where first argument: `Y` or `N`
- `executeIfNot(s, cmd)`

---

### `time.sh`

- `now()` — current timestamp

---

### `risk.sh`

- `riskCreate([gitBranchName = master])`
-