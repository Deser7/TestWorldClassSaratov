#!/bin/bash

# Скрипт для настройки аутентификации GitHub
# Запустите: chmod +x setup-github-auth.sh && ./setup-github-auth.sh

echo "🔐 Настройка аутентификации GitHub..."
echo ""

echo "📋 Инструкция по созданию Personal Access Token:"
echo ""
echo "1. Открой GitHub в браузере: https://github.com"
echo "2. Войди в свой аккаунт (Deser7)"
echo "3. Перейди в Settings -> Developer settings -> Personal access tokens -> Tokens (classic)"
echo "4. Нажми 'Generate new token (classic)'"
echo "5. Выбери 'Generate new token (classic)'"
echo ""
echo "🔧 Настройки токена:"
echo "   - Note: TestWorldClassSaratov iOS Project"
echo "   - Expiration: 90 days (или No expiration)"
echo "   - Scopes: выбери только 'repo' (полный доступ к репозиториям)"
echo ""
echo "6. Нажми 'Generate token'"
echo "7. Скопируй токен (он показывается только один раз!)"
echo ""

read -p "Введи свой Personal Access Token: " github_token

if [ -z "$github_token" ]; then
    echo "❌ Токен не введен. Настройка отменена."
    exit 1
fi

echo ""
echo "🔧 Настройка Git для использования токена..."

# Настройка URL с токеном
current_url=$(git remote get-url origin)
if [[ $current_url == https://* ]]; then
    # Заменяем URL на версию с токеном
    new_url="https://${github_token}@github.com/Deser7/TestWorldClassSaratov.git"
    git remote set-url origin "$new_url"
    echo "✅ URL репозитория обновлен с токеном"
else
    echo "⚠️  Текущий URL не HTTPS. Проверь настройки вручную."
fi

# Настройка credential helper
git config --global credential.helper osxkeychain

echo ""
echo "🧪 Тестируем подключение..."

# Пробуем выполнить fetch для проверки токена
if git fetch origin; then
    echo "✅ Аутентификация успешна!"
    echo "🎉 Теперь ты можешь push/pull без ввода пароля"
else
    echo "❌ Ошибка аутентификации. Проверь токен."
    echo "💡 Убедись, что токен имеет права 'repo'"
fi

echo ""
echo "📝 Полезные команды:"
echo "  git push origin Network    - отправить изменения"
echo "  git pull origin Network    - получить изменения"
echo "  git fetch origin           - обновить информацию о ветках"
echo ""
echo "🔒 Токен сохранен в macOS Keychain"
echo "💡 Если токен истечет, повтори этот процесс" 