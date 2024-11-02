#Requires -Version 7

podman build -f builder.Dockerfile -t 4builder .
Get-ChildItem -File -Path 'etc' -Filter '*.env' | Select-Object -Property BaseName -ExpandProperty BaseName | ForEach-Object {
    $Project=$_
    & podman build -f final.Dockerfile --build-arg-file ./etc/$Project.env -t $Project .
    & podman image prune -f --filter label=stage=4builder
    & podman run --rm --mount "src=$(Get-Location),target=/mnt/output,type=bind" "$Project"
    & podman image prune -a -f --filter label=stage=4final
}