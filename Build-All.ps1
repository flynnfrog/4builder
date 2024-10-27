$projects = @("4cade", "4live", "4sports", "a2fc", "adventure-replay", "anti-m", "dhrslide", "million-perfect-letters", "million-perfect-tiles", "passport", "pitch-dark", "pitch-darker", "probable", "untitled-word-game", "untitled-word-game-pro", "wizard-replay", "word-clock")

podman build -f builder.Dockerfile -t 4builder .
foreach ($project in $projects) {
    & podman build -f final.Dockerfile --build-arg-file ./etc/$project.env -t $project .
    & podman image prune -f --filter label=stage=4builder
    & podman run --rm --mount "src=$(Get-Location),target=/mnt/output,type=bind" "$project"
    & podman image prune -a -f --filter label=stage=4final
}