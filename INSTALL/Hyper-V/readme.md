# Install Hyper-V Role

## Check what optional features installed

```
Get-WindowsOptionalFeature -Online
```
## Enable

```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

## Links for the reference

- https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v