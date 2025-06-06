﻿<#
DESCRIPTION:
    This function initializes the environment for a test run. It sets up global variables 
    for log storage, initializes result tracking structures, and validates the 
    WSE (Windows Subsystem for Enhanced) enabling status based on specified target versions.
INPUT PARAMETERS:
    - TstsetNme [string] :- The name of the test set, used for naming log folders.
    - targetMepCameraVer [string] :- The target version of the MEP Camera component to be validated.
    - targetMepAudioVer [string] :- The target version of the MEP Audio component to be validated.
    - targetPerceptionCoreVer [string] :- The target version of the Perception Core component to be validated.
RETURN TYPE:
    - void
#>
function InitializeTest($TstsetNme, $targetMepCameraVer, $targetMepAudioVer, $targetPerceptionCoreVer)
{
    $Global:pathLogsFolder = ".\Logs\" + "$((get-date).tostring('yyyy-MM-dd-HH-mm-ss'))" + "-$TstsetNme"
    New-Item -ItemType Directory -Force -Path $pathLogsFolder  | Out-Null
    $Global:SequenceNumber = 0
    $Global:Results = '' | SELECT ScenarioName,fps,TotalNumberOfFrames,FramesAbove33ms,'AvgProcessingTimePerFrame(In ms)','MaxProcessingTimePerFrame(In ms)','MinProcessingTimePerFrame(In ms)','timetofirstframe(In secs)','CameraAppInItTime(In secs)','VoiceRecorderInItTime(In secs)','timetofirstframeForAudio(In secs)',FramesAbove33msForAudioBlur,'PeakWorkingSetSize(In MB)','AvgWorkingSetSize(In MB)', BeforeMedianCPUUsage, BeforeMedianNPUUsage, BeforeMedianMemoryUsage, BeforePeakCPUUsage, BeforePeakNPUUsage, BeforePeakMemoryUsage, BeforeAverageCPUUsage, BeforeAverageNPUUsage, BeforeAverageMemoryUsage, BeforeMedianMemoryUsageGB, BeforePeakMemoryUsageGB, BeforeAverageMemoryUsageGB, AfterMedianCPUUsage, AfterMedianNPUUsage, AfterMedianMemoryUsage, AfterPeakCPUUsage, AfterPeakNPUUsage, AfterPeakMemoryUsage, AfterAverageCPUUsage, AfterAverageNPUUsage, AfterAverageMemoryUsage, AfterMedianMemoryUsageGB, AfterPeakMemoryUsageGB, AfterAverageMemoryUsageGB, DiffMedianCPUUsage, DiffMedianNPUUsage, DiffMedianMemoryUsage, DiffPeakCPUUsage, DiffPeakNPUUsage, DiffPeakMemoryUsage, DiffAverageCPUUsage, DiffAverageNPUUsage, DiffAverageMemoryUsage, DiffMedianMemoryUsageGB, DiffPeakMemoryUsageGB, DiffAverageMemoryUsageGB, Status, ReasonForNotPass
    $Global:validatedCameraFriendlyName = ""
    $Global:pythonLibFolder = ".\Library\python\npu_cpu_memory_utilization.py"
    # once if the WseEnabingStatus validation fails, stop and exit the test
    if ((WseEnablingStatus $targetMepCameraVer $targetMepAudioVer $targetPerceptionCoreVer) -eq $false)
    {
        Write-Error "WseEnablingStatus fail!"
        exit
    }
}


