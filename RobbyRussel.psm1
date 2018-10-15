#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )

    #check the last command state and indicate if failed
    If ($lastCommandFailed) {
        $prompt = Write-Prompt $StartSymbol -ForegroundColor $FailedCommandColor
    } else {
        $prompt = Write-Prompt $StartSymbol -ForegroundColor $SuccesfulCommandColor
    }

    # Writes the drive portion
    $path = (Get-Item $pwd).Name
    $prompt += Write-Prompt $path -ForegroundColor $DirColor

    $status = Get-VCSStatus
    if ($status) {
        $prompt += Write-Prompt " git:(" -ForegroundColor $GitForegroundColor
        $prompt += Write-Prompt $status.Branch  -ForegroundColor $BranchColor
        $prompt += Write-Prompt ")"  -ForegroundColor $GitForegroundColor
        if($status.HasUntracked){
            $prompt += Write-Prompt $GitUntrackedSymbol -ForegroundColor $GitUntrackedColor
        }
    }
    $prompt += " "

    $prompt
}

$StartSymbol = [char]::ConvertFromUtf32(0x279C) + "  "
$GitUntrackedSymbol = " " + [char]::ConvertFromUtf32(0x2717)
$GitUntrackedColor = [ConsoleColor]::Yellow
$GitForegroundColor = [ConsoleColor]::Blue
$BranchColor = [ConsoleColor]::Red
$DirColor = [ConsoleColor]::Cyan
$FailedCommandColor = [ConsoleColor]::Red
$SuccesfulCommandColor = [ConsoleColor]::Green
