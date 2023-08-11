#!/usr/bin/env bash

# Define a usage function
usage() {
    echo "Usage: $0 <resource> <name> [-n <namespace>]"
    echo "Options:"
    echo "  -n <namespace>  Specify the namespace (optional)"
    echo "Arguments:"
    echo "  <resource>      Specify the resource"
    echo "  <name>          Specify the name"
    exit 1
}

# Define the default values
namespace=""
resource=""
name=""

# Parse the command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n)
            shift
            namespace=$1
            namespace_flag="-n $namespace"
            ;;
        *)
            if [ -z "$resource" ]; then
                resource=$1
            elif [ -z "$name" ]; then
                name=$1
            else
                echo "Unexpected argument: $1"
                usage
            fi
            ;;
    esac
    shift
done

# Check if the required arguments are specified
if [ -z "$resource" ] || [ -z "$name" ]; then
    echo "Invalid number of arguments."
    usage
fi

kubectl get "$resource/$name" $namespace_flag -o json | jq 'walk(if type == "object" and has("finalizers") then .finalizers = [] else . end)' > /tmp/temp.json
kubectl apply -f /tmp/temp.json $namespace_flag
