function log() {
    echo " - $1"
}

function header() {
    echo "------------------------"
    echo " $1"
    echo "------------------------"
}

function select_ws() {
    WS=$1
    terraform workspace select $WS || (terraform workspace new $WS && terraform workspace select $WS)
}