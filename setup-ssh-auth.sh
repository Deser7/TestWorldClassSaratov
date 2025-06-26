#!/bin/bash

# Скрипт для настройки SSH аутентификации GitHub
# Запустите: chmod +x setup-ssh-auth.sh && ./setup-ssh-auth.sh

echo "🔑 Настройка SSH аутентификации GitHub..."
echo ""

# Проверяем, есть ли уже SSH ключи
if [ -f ~/.ssh/id_ed25519 ]; then
    echo "✅ SSH ключ уже существует: ~/.ssh/id_ed25519"
    echo "📋 Публичный ключ:"
    cat ~/.ssh/id_ed25519.pub
    echo ""
    echo "💡 Если этот ключ уже добавлен в GitHub, можно пропустить создание нового"
    read -p "Создать новый ключ? (y/N): " create_new
    if [[ $create_new != "y" && $create_new != "Y" ]]; then
        echo "Пропускаем создание нового ключа"
    else
        create_new_key=true
    fi
else
    create_new_key=true
fi

if [ "$create_new_key" = true ]; then
    echo "🔧 Генерируем новый SSH ключ..."
    ssh-keygen -t ed25519 -C "deser7@icloud.com" -f ~/.ssh/id_ed25519 -N ""
    
    if [ $? -eq 0 ]; then
        echo "✅ SSH ключ создан успешно!"
    else
        echo "❌ Ошибка при создании SSH ключа"
        exit 1
    fi
fi

# Запускаем ssh-agent
echo "🚀 Запускаем ssh-agent..."
eval "$(ssh-agent -s)"

# Добавляем ключ в ssh-agent
echo "🔑 Добавляем ключ в ssh-agent..."
ssh-add ~/.ssh/id_ed25519

# Показываем публичный ключ
echo ""
echo "📋 Публичный ключ (добавь его в GitHub):"
echo "=========================================="
cat ~/.ssh/id_ed25519.pub
echo "=========================================="
echo ""

echo "📋 Инструкция по добавлению ключа в GitHub:"
echo ""
echo "1. Скопируй публичный ключ выше"
echo "2. Открой GitHub: https://github.com"
echo "3. Войди в аккаунт (Deser7)"
echo "4. Перейди в Settings -> SSH and GPG keys"
echo "5. Нажми 'New SSH key'"
echo "6. Введи название: 'MacBook-Natasa'"
echo "7. Вставь публичный ключ в поле 'Key'"
echo "8. Нажми 'Add SSH key'"
echo ""

read -p "Нажми Enter когда добавишь ключ в GitHub..."

# Меняем URL репозитория на SSH
echo "🔧 Меняем URL репозитория на SSH..."
git remote set-url origin git@github.com:Deser7/TestWorldClassSaratov.git

echo ""
echo "🧪 Тестируем SSH подключение..."

# Тестируем подключение к GitHub
if ssh -T git@github.com; then
    echo "✅ SSH аутентификация успешна!"
    echo "🎉 Теперь ты можешь push/pull без ввода пароля"
else
    echo "❌ Ошибка SSH аутентификации"
    echo "💡 Убедись, что ключ добавлен в GitHub"
fi

echo ""
echo "📝 Полезные команды:"
echo "  git push origin Network    - отправить изменения"
echo "  git pull origin Network    - получить изменения"
echo "  git fetch origin           - обновить информацию о ветках"
echo ""
echo "🔒 SSH ключ сохранен в ~/.ssh/id_ed25519"
echo "💡 Ключ автоматически добавляется в ssh-agent при запуске" 