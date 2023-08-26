#!/bin/bash

az provider register --namespace Microsoft.Dashboard --wait
az feature register --namespace "Microsoft.ContainerService" --name "AzureServiceMeshPreview"
az feature register --namespace "Microsoft.ContainerService" --name "NodeOsUpgradeChannelPreview"
