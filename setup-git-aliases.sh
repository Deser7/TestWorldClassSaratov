#!/bin/bash

# Скрипт для настройки Git алиасов для iOS разработки
# Запустите: chmod +x setup-git-aliases.sh && ./setup-git-aliases.sh

echo "🚀 Настройка Git алиасов для iOS разработки..."

# Проверяем, существует ли .gitconfig
if [ ! -f ~/.gitconfig ]; then
    echo "📝 Создаем новый .gitconfig файл..."
    touch ~/.gitconfig
fi

# Добавляем алиасы в .gitconfig
echo "📝 Добавляем алиасы в .gitconfig..."

cat >> ~/.gitconfig << 'EOF'

[alias]
    # Основные команды
    st = status
    co = checkout
    br = branch
    ci = commit
    ca = commit -a
    cm = commit -m
    
    # Просмотр истории
    lg = log --oneline --graph --decorate
    ll = log --oneline -10
    last = log -1 HEAD
    
    # Работа с ветками
    new-branch = checkout -b
    delete-branch = branch -d
    merge-branch = merge --no-ff
    
    # Специальные команды для iOS
    ios-status = status --porcelain | grep -E "\\.(swift|storyboard|xib|plist)$"
    swift-files = diff --name-only HEAD~1 | grep "\\.swift$"
    
    # Коммиты по типам
    feat = commit -m "feat: "
    fix = commit -m "fix: "
    refactor = commit -m "refactor: "
    docs = commit -m "docs: "
    
    # Полезные команды
    undo = reset --soft HEAD~1
    unstage = reset HEAD
    discard = checkout --
    
    # Статистика
    stats = log --oneline --stat
    author-stats = shortlog -sn
    
    # Чистка
    clean-all = clean -fd
    prune-branches = remote prune origin
    
    # Слияние
    merge-main = !git checkout main && git pull origin main && git checkout -
    sync-branch = !git fetch origin && git rebase origin/main
    
    # Создание релиза
    release = !git tag -a v$1 -m \"Release version $1\" && git push origin v$1
    
    # Просмотр изменений
    changes = diff --cached
    staged = diff --cached --name-only
    unstaged = diff --name-only
    
    # Работа с stash
    stash-list = stash list
    stash-pop = stash pop
    stash-save = stash save
    
    # Информация о репозитории
    info = !echo \"Repository: $(git remote get-url origin)\" && echo \"Current branch: $(git branch --show-current)\" && echo \"Last commit: $(git log -1 --oneline)\"
    
    # Быстрые команды для ежедневной работы
    daily-start = !git checkout develop && git pull origin develop && git checkout -b feature/
    daily-end = !git push origin HEAD && echo \"Branch pushed to origin\"
    
    # Проверка качества коммита
    check-commit = !git diff --cached --stat && echo \"\\nПроверьте изменения выше перед коммитом\"
    
    # Создание feature ветки
    feature = !git checkout -b feature/$1
    bugfix = !git checkout -b bugfix/$1
    hotfix = !git checkout -b hotfix/$1
    
    # Просмотр файлов в коммите
    show-files = show --name-only
    show-stats = show --stat
    
    # Работа с тегами
    tags = tag -l
    latest-tag = describe --tags --abbrev=0
    
    # Синхронизация с удаленным репозиторием
    sync = !git fetch origin && git rebase origin/$(git branch --show-current)
    push-force = push --force-with-lease
    
    # Полезные команды для iOS
    ios-clean = !xcodebuild clean -project *.xcodeproj -scheme * && rm -rf ~/Library/Developer/Xcode/DerivedData
    ios-build = !xcodebuild build -project *.xcodeproj -scheme * -destination 'platform=iOS Simulator,name=iPhone 14'
    
    # Команды для работы с конфликтами
    conflicts = diff --name-only --diff-filter=U
    resolve = !git add $1 && git commit -m \"fix: разрешен конфликт в $1\"
    
    # Статистика по файлам
    file-stats = !git log --oneline --name-only --pretty=format: | sort | uniq -c | sort -nr | head -10
    
    # Поиск в истории
    search = log --grep
    search-author = log --author
    
    # Экспорт изменений
    export-patch = format-patch -1 HEAD
    apply-patch = am
    
    # Работа с submodules
    sub-update = submodule update --init --recursive
    sub-status = submodule status
    
    # Команды для code review
    review = !git diff HEAD~1..HEAD
    review-stats = !git diff --stat HEAD~1..HEAD
    
    # Быстрые исправления
    quick-fix = !git add . && git commit -m \"fix: $1\" && git push origin HEAD
    
    # Информация о текущем состоянии
    status-short = status --short
    status-branch = status --branch --short
    
    # Команды для работы с удаленными ветками
    remote-branches = branch -r
    local-branches = branch
    all-branches = branch -a
    
    # Очистка старых веток
    cleanup-branches = !git branch --merged | grep -v \"\\*\" | xargs -n 1 git branch -d
    
    # Команды для работы с stash
    stash-save-work = stash save \"WIP: $(date)\"
    stash-apply = stash apply
    stash-drop = stash drop
    
    # Команды для работы с тегами
    tag-version = !git tag -a v$1 -m \"Version $1\" && git push origin v$1
    delete-tag = !git tag -d $1 && git push origin :refs/tags/$1
    
    # Команды для работы с историей
    reflog = reflog --oneline
    reset-hard = reset --hard
    reset-soft = reset --soft
    
    # Команды для работы с файлами
    add-all = add .
    add-swift = add "*.swift"
    add-ui = add "*.storyboard" "*.xib" "*.swift"
    
    # Команды для работы с коммитами
    amend = commit --amend
    amend-no-edit = commit --amend --no-edit
    squash = rebase -i HEAD~$1
    
    # Команды для работы с ветками
    rename-branch = branch -m
    checkout-orphan = checkout --orphan
    
    # Команды для работы с удаленным репозиторием
    remote-add = remote add
    remote-remove = remote remove
    remote-rename = remote rename
    
    # Команды для работы с конфигурацией
    config-list = config --list
    config-get = config --get
    config-set = config
    
    # Команды для работы с ignore
    ignore = !echo $1 >> .gitignore
    ignored = status --ignored
    
    # Команды для работы с blame
    blame-file = blame $1
    blame-line = blame -L $1,$2 $3
    
    # Команды для работы с bisect
    bisect-start = bisect start
    bisect-good = bisect good
    bisect-bad = bisect bad
    bisect-reset = bisect reset
    
    # Команды для работы с cherry-pick
    cherry-pick-commit = cherry-pick $1
    cherry-pick-abort = cherry-pick --abort
    cherry-pick-continue = cherry-pick --continue
    
    # Команды для работы с rebase
    rebase-interactive = rebase -i
    rebase-abort = rebase --abort
    rebase-continue = rebase --continue
    
    # Команды для работы с merge
    merge-abort = merge --abort
    merge-continue = merge --continue
    
    # Команды для работы с pull
    pull-rebase = pull --rebase
    pull-ff-only = pull --ff-only
    
    # Команды для работы с push
    push-upstream = push -u origin HEAD
    push-all = push --all
    push-tags = push --tags
    
    # Команды для работы с fetch
    fetch-all = fetch --all
    fetch-tags = fetch --tags
    fetch-prune = fetch --prune
    
    # Команды для работы с remote
    remote-show = remote show
    remote-set-url = remote set-url
    
    # Команды для работы с worktree
    worktree-add = worktree add
    worktree-list = worktree list
    worktree-remove = worktree remove
    
    # Команды для работы с submodule
    submodule-add = submodule add
    submodule-foreach = submodule foreach
    submodule-sync = submodule sync
    
    # Команды для работы с bundle
    bundle-create = bundle create
    bundle-verify = bundle verify
    bundle-list-heads = bundle list-heads
    
    # Команды для работы с notes
    notes-add = notes add
    notes-show = notes show
    notes-edit = notes edit
    
    # Команды для работы с replace
    replace-add = replace
    replace-list = replace -l
    replace-delete = replace -d
    
    # Команды для работы с gc
    gc-aggressive = gc --aggressive
    gc-prune = gc --prune
    
    # Команды для работы с fsck
    fsck-full = fsck --full
    fsck-unreachable = fsck --unreachable
    
    # Команды для работы с reflog
    reflog-expire = reflog expire
    reflog-delete = reflog delete
    
    # Команды для работы с filter-branch
    filter-branch-email = filter-branch --env-filter
    filter-branch-tree = filter-branch --tree-filter
    
    # Команды для работы с update-index
    update-index-assume-unchanged = update-index --assume-unchanged
    update-index-no-assume-unchanged = update-index --no-assume-unchanged
    
    # Команды для работы с ls-files
    ls-files-ignored = ls-files --ignored
    ls-files-others = ls-files --others
    ls-files-deleted = ls-files --deleted
    
    # Команды для работы с diff
    diff-staged = diff --cached
    diff-unstaged = diff
    diff-ignore-space = diff --ignore-space-change
    diff-ignore-all-space = diff --ignore-all-space
    
    # Команды для работы с show
    show-stats = show --stat
    show-name-only = show --name-only
    show-pretty = show --pretty=format:
    
    # Команды для работы с log
    log-oneline = log --oneline
    log-graph = log --graph
    log-decorate = log --decorate
    log-author = log --author
    log-since = log --since
    log-until = log --until
    
    # Команды для работы с branch
    branch-merged = branch --merged
    branch-no-merged = branch --no-merged
    branch-verbose = branch -v
    branch-all = branch -a
    
    # Команды для работы с tag
    tag-list = tag -l
    tag-annotated = tag -a
    tag-signed = tag -s
    tag-delete = tag -d
    
    # Команды для работы с stash
    stash-list = stash list
    stash-show = stash show
    stash-pop = stash pop
    stash-apply = stash apply
    stash-drop = stash drop
    stash-clear = stash clear
    
    # Команды для работы с commit
    commit-verbose = commit -v
    commit-amend = commit --amend
    commit-fixup = commit --fixup
    commit-squash = commit --squash
    
    # Команды для работы с checkout
    checkout-b = checkout -b
    checkout-orphan = checkout --orphan
    checkout-track = checkout --track
    
    # Команды для работы с merge
    merge-no-ff = merge --no-ff
    merge-squash = merge --squash
    merge-abort = merge --abort
    merge-continue = merge --continue
    
    # Команды для работы с rebase
    rebase-interactive = rebase -i
    rebase-continue = rebase --continue
    rebase-abort = rebase --abort
    rebase-skip = rebase --skip
    
    # Команды для работы с reset
    reset-soft = reset --soft
    reset-mixed = reset --mixed
    reset-hard = reset --hard
    reset-keep = reset --keep
    
    # Команды для работы с revert
    revert-no-edit = revert --no-edit
    revert-continue = revert --continue
    revert-abort = revert --abort
    revert-skip = revert --skip
    
    # Команды для работы с cherry-pick
    cherry-pick-no-commit = cherry-pick --no-commit
    cherry-pick-continue = cherry-pick --continue
    cherry-pick-abort = cherry-pick --abort
    cherry-pick-skip = cherry-pick --skip
    
    # Команды для работы с bisect
    bisect-start = bisect start
    bisect-good = bisect good
    bisect-bad = bisect bad
    bisect-skip = bisect skip
    bisect-reset = bisect reset
    bisect-log = bisect log
    bisect-replay = bisect replay
    bisect-run = bisect run
    
    # Команды для работы с blame
    blame-porcelain = blame --porcelain
    blame-line-number = blame -L
    blame-ignore-rev = blame --ignore-rev
    blame-ignore-file = blame --ignore-file
    
    # Команды для работы с grep
    grep-basic = grep
    grep-extended = grep -E
    grep-fixed = grep -F
    grep-ignore-case = grep -i
    grep-line-number = grep -n
    grep-count = grep -c
    grep-files-with-matches = grep -l
    grep-files-without-match = grep -L
    
    # Команды для работы с show-branch
    show-branch-all = show-branch -a
    show-branch-remote = show-branch -r
    show-branch-current = show-branch --current
    
    # Команды для работы с name-rev
    name-rev-all = name-rev --all
    name-rev-tags = name-rev --tags
    name-rev-refs = name-rev --refs
    
    # Команды для работы с describe
    describe-tags = describe --tags
    describe-all = describe --all
    describe-dirty = describe --dirty
    describe-long = describe --long
    
    # Команды для работы с archive
    archive-format = archive --format
    archive-output = archive --output
    archive-prefix = archive --prefix
    
    # Команды для работы с bundle
    bundle-create = bundle create
    bundle-verify = bundle verify
    bundle-list-heads = bundle list-heads
    bundle-unbundle = bundle unbundle
    
    # Команды для работы с notes
    notes-add = notes add
    notes-show = notes show
    notes-edit = notes edit
    notes-remove = notes remove
    notes-copy = notes copy
    notes-append = notes append
    notes-prune = notes prune
    
    # Команды для работы с replace
    replace-add = replace
    replace-list = replace -l
    replace-delete = replace -d
    replace-edit = replace -e
    replace-graft = replace -g
    
    # Команды для работы с gc
    gc-aggressive = gc --aggressive
    gc-prune = gc --prune
    gc-quiet = gc --quiet
    gc-force = gc --force
    
    # Команды для работы с fsck
    fsck-full = fsck --full
    fsck-unreachable = fsck --unreachable
    fsck-no-reflogs = fsck --no-reflogs
    fsck-verbose = fsck --verbose
    
    # Команды для работы с reflog
    reflog-expire = reflog expire
    reflog-delete = reflog delete
    reflog-exists = reflog exists
    reflog-show = reflog show
    
    # Команды для работы с filter-branch
    filter-branch-env = filter-branch --env-filter
    filter-branch-tree = filter-branch --tree-filter
    filter-branch-index = filter-branch --index-filter
    filter-branch-parent = filter-branch --parent-filter
    filter-branch-msg = filter-branch --msg-filter
    filter-branch-commit = filter-branch --commit-filter
    filter-branch-tag = filter-branch --tag-name-filter
    filter-branch-subdir = filter-branch --subdirectory-filter
    
    # Команды для работы с update-index
    update-index-assume-unchanged = update-index --assume-unchanged
    update-index-no-assume-unchanged = update-index --no-assume-unchanged
    update-index-skip-worktree = update-index --skip-worktree
    update-index-no-skip-worktree = update-index --no-skip-worktree
    update-index-again = update-index --again
    update-index-cacheinfo = update-index --cacheinfo
    update-index-index-info = update-index --index-info
    update-index-remove = update-index --remove
    
    # Команды для работы с ls-files
    ls-files-ignored = ls-files --ignored
    ls-files-others = ls-files --others
    ls-files-deleted = ls-files --deleted
    ls-files-modified = ls-files --modified
    ls-files-stage = ls-files --stage
    ls-files-unmerged = ls-files --unmerged
    ls-files-killed = ls-files --killed
    ls-files-exclude = ls-files --exclude
EOF

echo "✅ Git алиасы успешно добавлены в ~/.gitconfig"
echo ""
echo "🎯 Теперь ты можешь использовать следующие команды:"
echo ""
echo "📋 Основные команды:"
echo "  git st          - статус репозитория"
echo "  git co          - переключение веток"
echo "  git br          - список веток"
echo "  git ci          - коммит"
echo "  git lg          - красивая история коммитов"
echo ""
echo "🚀 Быстрые коммиты:"
echo "  git feat        - коммит новой функции"
echo "  git fix         - коммит исправления"
echo "  git refactor    - коммит рефакторинга"
echo "  git docs        - коммит документации"
echo ""
echo "📱 iOS специфичные:"
echo "  git ios-status  - статус только Swift файлов"
echo "  git swift-files - измененные Swift файлы"
echo "  git ios-clean   - очистка Xcode кэша"
echo "  git ios-build   - сборка проекта"
echo ""
echo "🔄 Ежедневный workflow:"
echo "  git daily-start - начало работы (создание feature ветки)"
echo "  git daily-end   - конец работы (push в origin)"
echo "  git sync        - синхронизация с удаленным репозиторием"
echo ""
echo "💡 Полезные команды:"
echo "  git info        - информация о репозитории"
echo "  git undo        - отменить последний коммит"
echo "  git unstage     - убрать файлы из staging"
echo "  git check-commit - проверить изменения перед коммитом"
echo ""
echo "🎉 Настройка завершена! Теперь твоя работа с Git станет намного удобнее." 