#!/bin/bash

terraform fmt
tflint -f compact
terraform validate
# terraform graph | dot -Tpng > graph.png