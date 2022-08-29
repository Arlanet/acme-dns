$_containerName = "arlanet_acme-dns_build"
$_volumeNameModCache= "arlanet_acme-dns_build-modcache"
$_volumeNameCache = "arlanet_acme-dns_build-cache"

function CreateDockerVolume($volumeName) {
    docker volume inspect $volumeName *> $null

    if ($LASTEXITCODE -ne 0) {
        docker volume create $volumeName | Out-Null
    }
}

function RunCompiler($containerName, $buildArgs, $compileArgs = "", $outputDir) {
    docker run `
        --rm `
        --name ${containerName} `
        -v ${_volumeNameModCache}:/go/pkg/mod `
        -v ${_volumeNameCache}:/root/.cache/go-build `
        -v ${PWD}/..:/src `
        -v ${PWD}${outputDir}:/output `
        -e GOARGS=${buildArgs} `
        -e GOBUILDARGS=${compileArgs} `
        arlanet/build-go:latest #&
}

Write-Host "Creating Docker volumes..."
CreateDockerVolume $_volumeNameModCache
CreateDockerVolume $_volumeNameCache

Write-Host "Compiling Linux..."
RunCompiler `
    -containerName "$_containerName-linux" `
    -buildArgs "go mod tidy && GOOS=linux GOARCH=amd64 CGO_ENABLED=1 CC=gcc" `
    -outputDir "/output/linux"

Write-Host "Compiling Windows..."
RunCompiler `
    -containerName "$_containerName-windows" `
    -buildArgs "go mod tidy && GOOS=windows GOARCH=amd64 CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc" `
    -outputDir "/output/windows"
