$projects = @("4cade", "4live", "4sports", "a2fc", "adventure-replay", "anti-m", "dhrslide", "million-perfect-letters", "million-perfect-tiles", "passport", "pitch-dark", "pitch-darker", "untitled-word-game", "untitled-word-game-pro", "wizard-replay", "word-clock")

foreach ($project in $projects) {
    & podman build --build-arg-file "./etc/$project.env" -t "$project" .
    & podman run -it --mount "src=$(Get-Location),target=/mnt/output,type=bind" "$project"
}