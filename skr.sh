#!/bin/bash

# Директория для хранения логов
log_dir="/home/cics/grap/logcron"
mkdir -p "$log_dir"

# Лог-файл с текущей датой
log_file="${log_dir}/disk_usage_$(date +%F).log"

# Сбор информации о дисковом пространстве
echo "Отчёт о дисковом пространстве пользователей на $(date)" > "$log_file"
echo "-------------------------------------------" >> "$log_file"

# Для каждой домашней директории вычисляем размер
for dir in /home/*; do
  if [ -d "$dir" ]; then
    user=$(basename "$dir")
    usage=$(du -sh "$dir" 2>/dev/null | awk '{print $1}')
    echo "$user: $usage" >> "$log_file"
  fi
done

echo "Отчёт сохранён в $log_file"
