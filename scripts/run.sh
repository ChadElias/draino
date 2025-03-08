#!/bin/bash
# Need to add custom conditions here
./draino --kubeconfig ~/.kube/config  --node-label-expr="metadata['labels']['node-role'] in ['default', 'default', 'default-compute', 'default-memory']" --evict-unreplicated-pods --evict-emptydir-pods --evict-daemonset-pods AMIProblem KernelDeadlock ReadonlyFilesystem OutOfDisk 