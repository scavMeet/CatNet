echo 'Created by https://github.com/scavMeet'


echo "hi $USER"
while true; do
    echo "------ ACTIVE TCP PORTS ------"
    sudo ss -tulpn | awk -F'[: ]+' '/tcp/ {print $6}'
    echo "commands: open <port>, close <port>"
    read -p "input command: " action port
    if [[ -n "$port" && ! "$port" =~ ^[0-9]+$ ]]; then
        echo "ERROR: $port is not number!"
        sleep 2
        continue
    fi
    case $action in
        open)
            echo "Open port $port...."
            nc -l -p "$port" > /dev/null 2>&1 &
            ;;
        close)
            echo "Close port $port..."
            sudo fuser -k "$port/tcp"
            ;;
        exit)
            break
            ;;
        *)
            echo "uncorrect command, enter: open <port >or close <port>"
            ;;
    esac
    sleep 1
done
