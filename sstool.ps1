Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml
Add-Type -AssemblyName System.Windows.Forms

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$installDir = "$env:USERPROFILE\Downloads\BlueMoonSSTool"

# ==============================================================================
# TOOL DATA  (unchanged from original list)
# ==============================================================================
$ToolData = @(
    # Red Lotus
    @{ Name="RL AltChecker";        Category="RedLotus";    Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotusAltChecker/releases/latest" },
    @{ Name="RL ModAnalyzer";       Category="RedLotus";    Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Mod-Analyzer/releases/latest" },
    @{ Name="RL TaskSentinel";      Category="RedLotus";    Type="GitHub"; URL="https://github.com/ItzIceHere/RedLotus-Task-Sentinel/releases/latest" },

    # Spokwn
    @{ Name="BAM Parser";           Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/BAM-parser/releases/latest" },
    @{ Name="PathsParser";          Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/PathsParser/releases/latest" },
    @{ Name="JournalTrace";         Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/JournalTrace/releases/latest" },
    @{ Name="BamDeletedKeys";       Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/BamDeletedKeys/releases/latest" },
    @{ Name="KernelDumpTool";       Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/KernelLiveDumpTool/releases/latest" },
    @{ Name="Espouken";             Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/Tool/releases/latest" },
    @{ Name="PcaSvcExecuted";       Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/pcasvc-executed/releases/latest" },
    @{ Name="PrefetchParser";       Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/prefetch-parser/releases/latest" },
    @{ Name="ActivitiesCache";      Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/ActivitiesCache-execution/releases/latest" },
    @{ Name="Replaceparser";        Category="Spokwn";      Type="GitHub"; URL="https://github.com/spokwn/Replaceparser/releases/latest" },

    # Praiselily
    @{ Name="PSHunter";             Category="Praiselily";  Type="GitHub"; URL="https://github.com/praiselily/PSHunter/releases/latest" },
    @{ Name="AltDetector";          Category="Praiselily";  Type="GitHub"; URL="https://github.com/praiselily/AltDetector/releases/latest" },
    @{ Name="WeHateFakers";         Category="Praiselily";  Type="Cmd";    Command="iwr https://raw.githubusercontent.com/praiselily/WeHateFakers/refs/heads/main/HotspotLogs.ps1 | iex" },
    @{ Name="CommonDirectories";    Category="Praiselily";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/CommonDirectories.ps1')" },
    @{ Name="HarddiskConverter";    Category="Praiselily";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/HarddiskConverter.ps1')" },
    @{ Name="Services";             Category="Praiselily";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Services.ps1')" },
    @{ Name="SignedScheduledTasks"; Category="Praiselily";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Signed-Scheduled-Tasks.ps1')" },
    @{ Name="Collector";            Category="Praiselily";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/Collector.ps1')" },
    @{ Name="DoomsdayFinder";       Category="Praiselily";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/praiselily/lilith-ps/refs/heads/main/DoomsdayFinder.ps1')" },

    # Tonynoh
    @{ Name="MeowModAnalyzer";      Category="Tonynoh";     Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')" },
    @{ Name="MeowDoomsdayFucker";   Category="Tonynoh";     Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowDoomsdayFucker/releases/latest" },
    @{ Name="MeowResolver";         Category="Tonynoh";     Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowResolver/releases/latest" },
    @{ Name="MeowNovowareFucker";   Category="Tonynoh";     Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowNovowareFucker/releases/latest" },
    @{ Name="MeowImportsChecker";   Category="Tonynoh";     Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowImportsChecker/releases/latest" },
    @{ Name="MeowClientFucker";   Category="Tonynoh";     Type="GitHub"; URL="https://github.com/MeowTonynoh/MeowClientFucker/releases/latest" },


    # PowerShell Scripts
    @{ Name="HabibiModAnalyzer";    Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/HadronCollision/PowershellScripts/refs/heads/main/HabibiModAnalyzer.ps1')" },
    @{ Name="Spokwn BAM (PS)";      Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/spokwn/powershells/refs/heads/main/bamparser.ps1')" },
    @{ Name="Streams";              Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/spokwn/powershells/refs/heads/main/Streams.ps1')" },
    @{ Name="Signatures";           Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/spokwn/powershells/refs/heads/main/signatures.ps1')" },
    @{ Name="AnyDesk Reset";        Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/spokwn/powershells/refs/heads/main/anydesk.ps1')" },
    @{ Name="JARParser (PS)";       Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/NoDiff-del/JARParser/refs/heads/main/JARParser.ps1')" },
    @{ Name="BAM Deleted Keys (PS)";Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Florinyoq/Screenshare/refs/heads/main/bam.ps1')" },
    @{ Name="Prefetch Integrity";   Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/bacanoicua/Screenshare/main/RedLotusPrefetchIntegrityAnalyzer.ps1')" },
    @{ Name="DoomsDay (Zedoon)";    Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/zedoonvm1/powershell-scripts/refs/heads/main/DoomsDayDetector.ps1')" },
    @{ Name="All-in-one";           Category="PS Scripts";  Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Enr1c0o/Powershell-Scripts/refs/heads/main/All-in-one.ps1')" },

    # Echo Tools
    @{ Name="Echo Scanner";         Category="Echo";        Type="Link";   URL="https://dl.echo.ac/free" },
    @{ Name="Echo Journal";         Category="Echo";        Type="Link";   URL="https://dl.echo.ac/tool/journal" },
    @{ Name="Echo BAM";             Category="Echo";        Type="Link";   URL="https://dl.echo.ac/tool/bam" },

    # Others / Forensics
    @{ Name="InjGen";               Category="Forensics";   Type="GitHub"; URL="https://github.com/NotRequiem/InjGen/releases/latest" },
    @{ Name="SystemInformer";       Category="Forensics";   Type="Link";   URL="https://www.systeminformer.com/canary" },
    @{ Name="DIE Engine";           Category="Forensics";   Type="Web";    URL="https://github.com/horsicq/DIE-engine/releases" },
    @{ Name="Everything";           Category="Forensics";   Type="Web";    URL="https://www.voidtools.com/Everything-1.4.1.1029.x64-Setup.exe" },
    @{ Name="HxD";                  Category="Forensics";   Type="Web";    URL="https://mh-nexus.de/downloads/HxDPortableSetup.zip" },
    @{ Name="PEStudio";             Category="Forensics";   Type="Web";    URL="https://www.winitor.com/tools/pestudio/current/pestudio.zip" },
    @{ Name="Luyten";               Category="Forensics";   Type="Web";    URL="https://github.com/deathmarine/Luyten/releases/download/v0.5.4_Rebuilt_with_Latest_depenencies/luyten-0.5.4.jar" },
    @{ Name="Recaf";                Category="Forensics";   Type="Web";    URL="https://github.com/Col-E/Recaf/releases/download/2.21.14/recaf-2.21.14-J8-jar-with-dependencies.jar" },
    @{ Name="LastActivityView";     Category="Forensics";   Type="Web";    URL="https://www.nirsoft.net/utils/lastactivityview.zip" },
    @{ Name="AlternateStreamView";  Category="Forensics";   Type="Web";    URL="https://www.nirsoft.net/utils/alternatestreamview-x64.zip" },
    @{ Name="MacroDetector";        Category="Forensics";   Type="Cmd";    Command="Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/Nickk196/MacroDetector/refs/heads/main/MacroDetector.ps1')" },

    # Zimmerman
    @{ Name="PECmd";                Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/PECmd.zip" },
    @{ Name="MFTECmd";              Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/MFTECmd.zip" },
    @{ Name="JLECmd";               Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/JLECmd.zip" },
    @{ Name="bstrings";             Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/bstrings.zip" },
    @{ Name="RegistryExplorer";     Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/RegistryExplorer.zip" },
    @{ Name="ShellBagsExplorer";    Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/ShellBagsExplorer.zip" },
    @{ Name="TimelineExplorer";     Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/TimelineExplorer.zip" },
    @{ Name="JumpListExplorer";     Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/JumpListExplorer.zip" },
    @{ Name="SrumECmd";             Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/SrumECmd.zip" },
    @{ Name="RecentFileCacheParser";Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/RecentFileCacheParser.zip" },
    @{ Name="EvtxECmd";             Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/EvtxECmd.zip" },
    @{ Name="LECmd";                Category="Zimmerman";   Type="Web";    URL="https://download.ericzimmermanstools.com/net9/LECmd.zip" },

    # Dependencies
    @{ Name="NET 9.0 SDK";          Category="Dependencies";Type="Web";    URL="https://download.visualstudio.microsoft.com/download/pr/92dba916-bc51-4e76-8b0e-d41d37ce5fa4/ab08f3e95bf7a3d3da336a7e8c8eca63/dotnet-sdk-9.0.203-win-x64.exe" },
    @{ Name="VC Redist x64";        Category="Dependencies";Type="Web";    URL="https://aka.ms/vs/17/release/vc_redist.x64.exe" }
)

# ==============================================================================
# MOON ICON  —  pixel-art crescent, drawn as scaled gradient pixel blocks
# ==============================================================================
# Each entry: x, y, width, height (in 20px pixel-grid units, pre-scale), hex color
$MoonPixels = @(
    @(100,0,  20,20,"#3A5FC0"),
    @(80,20,  20,20,"#3A5FC0"),
    @(100,20, 20,20,"#5078D6"),
    @(60,40,  20,20,"#3458BE"),
    @(80,40,  20,20,"#6E94E6"),
    @(40,60,  20,20,"#2E4FAE"),
    @(60,60,  20,20,"#7FA6EE"),
    @(80,60,  20,20,"#9CC4FA"),
    @(30,80,  20,20,"#2C4AA0"),
    @(50,80,  20,20,"#8CB6F2"),
    @(70,80,  20,20,"#A9D0FF"),
    @(20,100, 20,20,"#26429A"),
    @(40,100, 20,20,"#7FA6EE"),
    @(60,100, 20,20,"#A9D0FF"),
    @(20,120, 20,20,"#24408E"),
    @(40,120, 20,20,"#7491E0"),
    @(60,120, 20,20,"#9CC4FA"),
    @(20,140, 20,20,"#2C4AA0"),
    @(40,140, 20,20,"#6678C8"),
    @(60,140, 20,20,"#8C9CE0"),
    @(30,160, 20,20,"#34428C"),
    @(50,160, 20,20,"#5C68B4"),
    @(70,160, 20,20,"#7E84C8"),
    @(40,180, 20,20,"#3A3A78"),
    @(60,180, 20,20,"#52529A"),
    @(80,180, 20,20,"#6E64AC"),
    @(60,200, 20,20,"#322A66"),
    @(80,200, 20,20,"#4C4288"),
    @(100,200,20,20,"#604E9A"),
    @(80,220, 20,20,"#2A2454"),
    @(100,220,20,20,"#3E3470"),
    @(100,240,20,20,"#241E40"),
    @(120,240,20,20,"#382E5C"),
    @(120,260,20,20,"#241E40"),
    @(140,260,20,20,"#2A2454"),
    @(140,280,20,20,"#1E1834")
)
# The bright crater accent, drawn last so it sits on top
$MoonCrater = @(60,80,14,14)

# Small pixel-diamond stars scattered near the moon, scaled separately
$StarClusters = @(
    @{ OffsetX=205; OffsetY=35; Scale=0.6; Pixels=@(
            @(20,0,10,10),@(10,10,10,10),@(30,10,10,10),@(0,20,10,10),
            @(20,20,10,10),@(40,20,10,10),@(10,30,10,10),@(30,30,10,10),@(20,40,10,10)
        )
    },
    @{ OffsetX=235; OffsetY=90; Scale=0.6; Pixels=@(
            @(6,0,6,6),@(0,6,6,6),@(12,6,6,6),@(6,12,6,6)
        )
    },
    @{ OffsetX=10; OffsetY=160; Scale=0.6; Pixels=@(
            @(8,0,8,8),@(0,8,8,8),@(16,8,8,8),@(8,16,8,8)
        )
    }
)

function New-MoonGlyphCanvas {
    param([double]$Scale = 0.62)

    $canvas = New-Object System.Windows.Controls.Canvas
    $canvas.Width  = 200 * $Scale
    $canvas.Height = 320 * $Scale
    $canvas.SnapsToDevicePixels = $true

    foreach ($p in $MoonPixels) {
        $x = $p[0]; $y = $p[1]; $w = $p[2]; $h = $p[3]; $hex = $p[4]
        $rect = New-Object System.Windows.Shapes.Rectangle
        $rect.Width  = $w * $Scale
        $rect.Height = $h * $Scale
        $rect.Fill   = New-Object System.Windows.Media.SolidColorBrush ([System.Windows.Media.ColorConverter]::ConvertFromString($hex))
        [System.Windows.Controls.Canvas]::SetLeft($rect, $x * $Scale)
        [System.Windows.Controls.Canvas]::SetTop($rect,  $y * $Scale)
        $canvas.Children.Add($rect) | Out-Null
    }

    # Crater glow accent
    $craterBrush = New-Object System.Windows.Media.RadialGradientBrush
    $craterBrush.GradientOrigin = New-Object System.Windows.Point(0.4,0.4)
    $craterBrush.Center         = New-Object System.Windows.Point(0.4,0.4)
    $craterBrush.RadiusX = 0.6; $craterBrush.RadiusY = 0.6
    $craterBrush.GradientStops.Add((New-Object System.Windows.Media.GradientStop ([System.Windows.Media.Color]::FromRgb(0xFF,0xF8,0xD8)), 0.0))
    $craterBrush.GradientStops.Add((New-Object System.Windows.Media.GradientStop ([System.Windows.Media.Color]::FromRgb(0xF2,0xC2,0x4A)), 1.0))
    $crater = New-Object System.Windows.Shapes.Rectangle
    $crater.Width  = $MoonCrater[2] * $Scale
    $crater.Height = $MoonCrater[3] * $Scale
    $crater.Fill   = $craterBrush
    [System.Windows.Controls.Canvas]::SetLeft($crater, $MoonCrater[0] * $Scale)
    [System.Windows.Controls.Canvas]::SetTop($crater,  $MoonCrater[1] * $Scale)
    $canvas.Children.Add($crater) | Out-Null

    # Soft glow behind the whole moon shape
    $glowEffect = New-Object System.Windows.Media.Effects.DropShadowEffect
    $glowEffect.Color = [System.Windows.Media.Color]::FromRgb(0x7A,0xB8,0xE8)
    $glowEffect.BlurRadius = 22
    $glowEffect.ShadowDepth = 0
    $glowEffect.Opacity = 0.55
    $canvas.Effect = $glowEffect

    # Star clusters with their own gentle glow + gold radial gradient
    foreach ($cluster in $StarClusters) {
        $starBrush = New-Object System.Windows.Media.RadialGradientBrush
        $starBrush.GradientStops.Add((New-Object System.Windows.Media.GradientStop ([System.Windows.Media.Color]::FromRgb(0xFF,0xF4,0xC2)), 0.0))
        $starBrush.GradientStops.Add((New-Object System.Windows.Media.GradientStop ([System.Windows.Media.Color]::FromRgb(0xFF,0xD2,0x5A)), 0.55))
        $starBrush.GradientStops.Add((New-Object System.Windows.Media.GradientStop ([System.Windows.Media.Color]::FromRgb(0xF0,0xA8,0x28)), 1.0))

        $starGlow = New-Object System.Windows.Media.Effects.DropShadowEffect
        $starGlow.Color = [System.Windows.Media.Color]::FromRgb(0xFF,0xD2,0x5A)
        $starGlow.BlurRadius = 10
        $starGlow.ShadowDepth = 0
        $starGlow.Opacity = 0.7

        $starGroupCanvas = New-Object System.Windows.Controls.Canvas
        $starGroupCanvas.Effect = $starGlow
        foreach ($sp in $cluster.Pixels) {
            $sx = $sp[0]; $sy = $sp[1]; $sw = $sp[2]; $sh = $sp[3]
            $srect = New-Object System.Windows.Shapes.Rectangle
            $srect.Width  = $sw * $cluster.Scale
            $srect.Height = $sh * $cluster.Scale
            $srect.Fill   = $starBrush
            [System.Windows.Controls.Canvas]::SetLeft($srect, $sx * $cluster.Scale)
            [System.Windows.Controls.Canvas]::SetTop($srect,  $sy * $cluster.Scale)
            $starGroupCanvas.Children.Add($srect) | Out-Null
        }
        [System.Windows.Controls.Canvas]::SetLeft($starGroupCanvas, $cluster.OffsetX * $Scale)
        [System.Windows.Controls.Canvas]::SetTop($starGroupCanvas,  $cluster.OffsetY * $Scale)
        $canvas.Children.Add($starGroupCanvas) | Out-Null
    }

    return $canvas
}

# ==============================================================================
# CATEGORY GLYPHS  (Segoe UI Symbol / Segoe MDL2 friendly unicode glyphs)
# ==============================================================================
$CategoryGlyphs = @{
    "RedLotus"     = [string][char]0x2766   # floral heart - lotus-ish
    "Spokwn"       = [string][char]0x2317   # viewfinder-ish
    "Praiselily"   = [string][char]0x2741   # eight petalled flower
    "Tonynoh"      = [string][char]0x25C8   # diamond
    "PS Scripts"   = [string][char]0x276F   # heavy right angle bracket (prompt)
    "Echo"         = [string][char]0x29BF   # circled bullet
    "Forensics"    = [string][char]0x2316   # position indicator (magnifier-ish)
    "Zimmerman"    = [string][char]0x2710   # pen
    "Dependencies" = [string][char]0x2699   # gear
}

# ==============================================================================
# XAML UI  —  Blue Moon palette, refined
# ==============================================================================
[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="BlueMoon SS Toolkit"
    Width="1240" Height="780"
    MinWidth="1240" MinHeight="780"
    WindowStartupLocation="CenterScreen"
    ResizeMode="NoResize"
    WindowStyle="None"
    AllowsTransparency="True"
    Background="Transparent"
    FontFamily="Segoe UI">

    <Window.Resources>
        <!-- Blue Moon colour palette -->
        <SolidColorBrush x:Key="MainBg"    Color="#070D1A"/>
        <SolidColorBrush x:Key="SidebarBg" Color="#0B1628"/>
        <SolidColorBrush x:Key="CardBg"    Color="#0D1F38"/>
        <SolidColorBrush x:Key="CardBg2"   Color="#0F2440"/>
        <SolidColorBrush x:Key="Accent"    Color="#7AB8E8"/>
        <SolidColorBrush x:Key="AccentDim" Color="#2C5F8A"/>
        <SolidColorBrush x:Key="AccentSoft" Color="#3A6A98"/>
        <SolidColorBrush x:Key="TextMain"  Color="#D7EAFB"/>
        <SolidColorBrush x:Key="TextMuted" Color="#5A86AC"/>
        <SolidColorBrush x:Key="ConsoleBg" Color="#040A14"/>
        <SolidColorBrush x:Key="Border"    Color="#1A3050"/>
        <SolidColorBrush x:Key="GlyphBg"   Color="#13294A"/>

        <Style x:Key="SideBtn" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
            <Setter Property="FontSize"   Value="12"/>
            <Setter Property="Height"     Value="38"/>
            <Setter Property="Margin"     Value="0,0,0,4"/>
            <Setter Property="Cursor"     Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="SBorder" Background="{TemplateBinding Background}" CornerRadius="6" BorderThickness="1" BorderBrush="Transparent">
                            <ContentPresenter HorizontalAlignment="Left" VerticalAlignment="Center" Margin="14,0"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="SBorder" Property="Background" Value="#122548"/>
                                <Setter TargetName="SBorder" Property="BorderBrush" Value="#234B78"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="TitleBtn" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
            <Setter Property="Width"      Value="42"/>
            <Setter Property="Height"     Value="40"/>
            <Setter Property="Cursor"     Value="Hand"/>
            <Setter Property="FontSize"   Value="13"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#1A3A5C"/>
                                <Setter Property="Foreground" Value="#7AB8E8"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style TargetType="TabItem" x:Key="GlyphTab">
            <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
            <Setter Property="FontSize"   Value="11"/>
            <Setter Property="Padding"    Value="14,7"/>
            <Setter Property="Cursor"     Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border x:Name="TabBorder" Background="#0E1E36" CornerRadius="7" Margin="3,5,3,0" Padding="13,6" BorderThickness="1" BorderBrush="#16304E">
                            <ContentPresenter ContentSource="Header" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="TabBorder" Property="Background" Value="#1B3E64"/>
                                <Setter TargetName="TabBorder" Property="BorderBrush" Value="#3D7AB0"/>
                                <Setter Property="Foreground" Value="#9FD2FA"/>
                            </Trigger>
                            <MultiTrigger>
                                <MultiTrigger.Conditions>
                                    <Condition Property="IsMouseOver" Value="True"/>
                                    <Condition Property="IsSelected"  Value="False"/>
                                </MultiTrigger.Conditions>
                                <Setter TargetName="TabBorder" Property="Background" Value="#15294A"/>
                                <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
                            </MultiTrigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Border Background="{StaticResource MainBg}" BorderBrush="#1A3050" BorderThickness="1" CornerRadius="10">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="46"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <!-- Particle canvas layered behind everything, clipped to rounded corners -->
            <Canvas x:Name="ParticleCanvas" Grid.Row="0" Grid.RowSpan="2" Background="Transparent" IsHitTestVisible="False" ClipToBounds="True"/>

            <!-- Title bar -->
            <Border x:Name="TitleBar" Grid.Row="0" Background="#0B1628" CornerRadius="10,10,0,0" Opacity="0.92">
                <Grid Margin="18,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Background="#13294A" CornerRadius="5" Padding="6,3" Margin="0,0,8,0">
                            <TextBlock Text="◗◗◗" FontSize="11" FontWeight="Bold" Foreground="{StaticResource Accent}" FontFamily="Consolas"/>
                        </Border>
                        <TextBlock Text="Blue Moon" FontSize="15" FontWeight="SemiBold" Foreground="{StaticResource TextMain}" VerticalAlignment="Center"/>
                        <TextBlock Text="  Screenshare Toolkit" FontSize="11" Foreground="{StaticResource TextMuted}" VerticalAlignment="Center" Margin="6,2,0,0"/>
                    </StackPanel>
                    <StackPanel Grid.Column="1" Orientation="Horizontal">
                        <Button x:Name="MinBtn"   Style="{StaticResource TitleBtn}" Content="&#xE921;" FontFamily="Segoe MDL2 Assets" FontSize="10"/>
                        <Button x:Name="CloseBtn" Style="{StaticResource TitleBtn}" Content="&#xE8BB;" FontFamily="Segoe MDL2 Assets" FontSize="11"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Body -->
            <Grid Grid.Row="1">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="220"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Sidebar -->
                <Border Grid.Column="0" Background="#0B1628" Opacity="0.92" BorderBrush="#1A3050" BorderThickness="0,0,1,0">
                    <StackPanel Margin="12,16,12,14">

                        <!-- Moon glyph card -->
                        <Border Background="#081120" CornerRadius="8" Margin="0,0,0,16" Padding="0,18" BorderBrush="#162E4E" BorderThickness="1">
                            <StackPanel HorizontalAlignment="Center">
                                <Border x:Name="MoonHost" Width="124" Height="198" HorizontalAlignment="Center"/>
                                <TextBlock Text="SS MODE" FontSize="9" FontWeight="Bold" Foreground="{StaticResource TextMuted}" HorizontalAlignment="Center" Margin="0,10,0,0"/>
                            </StackPanel>
                        </Border>

                        <TextBlock Text="ACTIONS" FontSize="9" FontWeight="Bold" Foreground="{StaticResource TextMuted}" Margin="4,0,0,6"/>
                        <Button x:Name="OpenFolderBtn" Style="{StaticResource SideBtn}">
                            <StackPanel Orientation="Horizontal">
                                <TextBlock Text="&#x1F4C2;" FontFamily="Segoe UI Emoji" FontSize="13" Margin="0,0,8,0"/>
                                <TextBlock Text="Open Install Folder" VerticalAlignment="Center"/>
                            </StackPanel>
                        </Button>
                        <Button x:Name="ClearCacheBtn" Style="{StaticResource SideBtn}">
                            <StackPanel Orientation="Horizontal">
                                <TextBlock Text="&#x1F5D1;" FontFamily="Segoe UI Emoji" FontSize="13" Margin="0,0,8,0"/>
                                <TextBlock Text="Clear Downloaded Files" VerticalAlignment="Center"/>
                            </StackPanel>
                        </Button>
                        <Button x:Name="OpenCmdBtn" Style="{StaticResource SideBtn}">
                            <StackPanel Orientation="Horizontal">
                                <TextBlock Text="&#x2318;" FontSize="13" Margin="0,0,8,0"/>
                                <TextBlock Text="Open CMD" VerticalAlignment="Center"/>
                            </StackPanel>
                        </Button>
                        <Button x:Name="HostsCheckBtn" Style="{StaticResource SideBtn}">
                            <StackPanel Orientation="Horizontal">
                                <TextBlock Text="&#x2316;" FontSize="13" Margin="0,0,8,0"/>
                                <TextBlock Text="Check Hosts File" VerticalAlignment="Center"/>
                            </StackPanel>
                        </Button>

                        <Border Height="1" Background="#1A3050" Margin="0,12,0,12"/>

                        <TextBlock Text="ABOUT" FontSize="9" FontWeight="Bold" Foreground="{StaticResource TextMuted}" Margin="4,0,0,6"/>
                        <TextBlock Text="Blue Moon SS Toolkit" FontSize="11" FontWeight="SemiBold" Foreground="{StaticResource TextMain}" Margin="4,2,0,4"/>
                        <TextBlock Text="Screenshare forensics" FontSize="10" Foreground="{StaticResource TextMuted}" TextWrapping="Wrap" Margin="4,1,0,0"/>
                        <TextBlock Text="for Minecraft staff" FontSize="10" Foreground="{StaticResource TextMuted}" TextWrapping="Wrap" Margin="4,1,0,0"/>

                        <Border Height="1" Background="#1A3050" Margin="0,12,0,12"/>
                        <TextBlock x:Name="InstPathBlock" Text="" FontSize="9" Foreground="#3A5E80" TextWrapping="Wrap" Margin="4,0"/>
                    </StackPanel>
                </Border>

                <!-- Main panel -->
                <Grid Grid.Column="1" Margin="18,16,18,16">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="10"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="10"/>
                        <RowDefinition Height="150"/>
                    </Grid.RowDefinitions>

                    <!-- Status card -->
                    <Border Grid.Row="0" Background="#0D1F38" Opacity="0.92" CornerRadius="8" Padding="18,12" BorderBrush="#16304E" BorderThickness="1">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="Auto"/>
                            </Grid.ColumnDefinitions>
                            <StackPanel>
                                <TextBlock x:Name="StatusTitle" Text="Ready" FontSize="21" FontWeight="SemiBold" Foreground="{StaticResource TextMain}"/>
                                <TextBlock x:Name="StatusSub"   Text="Select a tool to launch or download." FontSize="11" Foreground="{StaticResource TextMuted}"/>
                            </StackPanel>
                            <Border Grid.Column="1" Background="#13294A" BorderBrush="#2C5F8A" BorderThickness="1" CornerRadius="5" Padding="11,5" VerticalAlignment="Center">
                                <TextBlock x:Name="StatusBadge" Text="IDLE" FontSize="12" FontWeight="Bold" Foreground="{StaticResource Accent}"/>
                            </Border>
                        </Grid>
                    </Border>

                    <!-- Tab control -->
                    <Border Grid.Row="2" Background="#0D1F38" Opacity="0.92" CornerRadius="8" BorderBrush="#16304E" BorderThickness="1">
                        <TabControl x:Name="ToolsTab" Background="Transparent" BorderThickness="0" Padding="4">
                        </TabControl>
                    </Border>

                    <!-- Console -->
                    <Border Grid.Row="4" Background="#040A14" Opacity="0.94" CornerRadius="8" Padding="14,10" BorderBrush="#16304E" BorderThickness="1">
                        <Grid>
                            <Grid.RowDefinitions>
                                <RowDefinition Height="Auto"/>
                                <RowDefinition Height="*"/>
                            </Grid.RowDefinitions>
                            <StackPanel Orientation="Horizontal" Margin="0,0,0,5">
                                <TextBlock Text="&#x25CF;" FontSize="8" Foreground="#3A6A98" Margin="0,0,6,0" VerticalAlignment="Center"/>
                                <TextBlock Text="ACTIVITY LOG" FontSize="9" FontWeight="Bold" Foreground="#3A6A98" FontFamily="Consolas"/>
                            </StackPanel>
                            <TextBox x:Name="LogBox"
                                Grid.Row="1"
                                Background="Transparent"
                                Foreground="{StaticResource Accent}"
                                BorderThickness="0"
                                FontFamily="Consolas"
                                FontSize="11"
                                IsReadOnly="True"
                                VerticalScrollBarVisibility="Auto"
                                TextWrapping="Wrap"/>
                        </Grid>
                    </Border>
                </Grid>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

# ==============================================================================
# LOAD WINDOW
# ==============================================================================
$reader        = New-Object System.Xml.XmlNodeReader $xaml
$window        = [Windows.Markup.XamlReader]::Load($reader)

$MinBtn         = $window.FindName("MinBtn")
$CloseBtn       = $window.FindName("CloseBtn")
$StatusTitle    = $window.FindName("StatusTitle")
$StatusSub      = $window.FindName("StatusSub")
$StatusBadge    = $window.FindName("StatusBadge")
$LogBox         = $window.FindName("LogBox")
$ToolsTab       = $window.FindName("ToolsTab")
$OpenFolderBtn  = $window.FindName("OpenFolderBtn")
$ClearCacheBtn  = $window.FindName("ClearCacheBtn")
$OpenCmdBtn     = $window.FindName("OpenCmdBtn")
$HostsCheckBtn  = $window.FindName("HostsCheckBtn")
$InstPathBlock  = $window.FindName("InstPathBlock")
$ParticleCanvas = $window.FindName("ParticleCanvas")
$MoonHost       = $window.FindName("MoonHost")

$InstPathBlock.Text = "Install path:`n$installDir"

# ==============================================================================
# HELPERS
# ==============================================================================
function Write-Log {
    param([string]$msg)
    $time = Get-Date -Format "HH:mm:ss"
    $LogBox.Dispatcher.Invoke([Action]{
        $LogBox.AppendText("[$time] $msg`r`n")
        $LogBox.ScrollToEnd()
    })
}

function Set-Status {
    param($title, $sub, $badge = "BUSY")
    $window.Dispatcher.Invoke([Action]{
        $StatusTitle.Text = $title
        $StatusSub.Text   = $sub
        $StatusBadge.Text = $badge
    })
}

function Start-AppOrScript {
    param([string]$Path, [string]$WorkingDirectory)
    if (-not $WorkingDirectory) { $WorkingDirectory = Split-Path -Parent $Path }
    $ext = [System.IO.Path]::GetExtension($Path).ToLowerInvariant()
    $q   = '"' + $Path + '"'
    switch ($ext) {
        ".cmd" { Start-Process "cmd.exe" -ArgumentList "/k",$q -WorkingDirectory $WorkingDirectory -WindowStyle Normal }
        ".bat" { Start-Process "cmd.exe" -ArgumentList "/k",$q -WorkingDirectory $WorkingDirectory -WindowStyle Normal }
        default { Start-Process -FilePath $Path -WorkingDirectory $WorkingDirectory -WindowStyle Normal }
    }
}

function Start-CmdToolCommand {
    param([string]$Command)
    $enc = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($Command))
    Start-Process "cmd.exe" -ArgumentList "/k","powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand $enc" -WindowStyle Normal
}

function Start-DownloadedTool {
    param([string]$Directory, [string]$PreferredFile)
    if ($PreferredFile -and (Test-Path -LiteralPath $PreferredFile) -and ($PreferredFile -notmatch "\.zip$")) {
        Write-Log "Launching $(Split-Path -Leaf $PreferredFile)"
        Start-AppOrScript -Path $PreferredFile -WorkingDirectory (Split-Path -Parent $PreferredFile)
        return $true
    }
    $launch = Get-ChildItem -Path $Directory -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Extension -match "^\.(exe|cmd|bat)$" } |
        Sort-Object @{ Expression = { if ($_.Extension -eq ".exe") {0} else {1} } }, FullName |
        Select-Object -First 1
    if ($launch) {
        Write-Log "Launching $($launch.Name)"
        Start-AppOrScript -Path $launch.FullName -WorkingDirectory $launch.DirectoryName
        return $true
    }
    Write-Log "No executable found - opening folder."
    Start-Process explorer.exe -ArgumentList "`"$Directory`""
    return $false
}

# ==============================================================================
# HOSTS FILE CHECK (popup dialog)
# ==============================================================================
function Show-HostsCheck {
    $acDomains = @("anticheat.ac","echo.ac","detect.ac","napse.ac")
    $hostsPath = "C:\Windows\System32\drivers\etc\hosts"
    $results   = ""
    $flagged   = $false

    try {
        $content = Get-Content $hostsPath -Raw -ErrorAction Stop
        foreach ($d in $acDomains) {
            if ($content -match [regex]::Escape($d)) {
                $results += "  [BLOCKED]  $d`n"
                $flagged  = $true
            } else {
                $results += "  [  OK   ]  $d`n"
            }
        }
    } catch {
        $results = "Could not read hosts file: $_"
    }

    $verdict = if ($flagged) { "`nWARNING: Blocked domains found. Bannable offense." } else { "`nAll clean - no AC domains blocked." }
    [System.Windows.MessageBox]::Show("Hosts file check:`n$hostsPath`n`n$results$verdict", "Blue Moon - Hosts Check", "OK", $(if ($flagged){"Warning"}else{"Information"})) | Out-Null
    Write-Log "Hosts check complete. Flagged: $flagged"
}

# ==============================================================================
# PARTICLE BACKGROUND  (constellation-style floating dots + connecting lines)
# ==============================================================================
$particleCount = 42
$particles = New-Object System.Collections.Generic.List[Object]
$rand = New-Object System.Random

# Canvas logical size (matches window content area)
$canvasW = 1238
$canvasH = 778

for ($i = 0; $i -lt $particleCount; $i++) {
    $dot = New-Object System.Windows.Shapes.Ellipse
    $size = 1.4 + ($rand.NextDouble() * 2.0)
    $dot.Width  = $size
    $dot.Height = $size
    $opacity = 0.15 + ($rand.NextDouble() * 0.45)
    $dot.Fill = New-Object System.Windows.Media.SolidColorBrush ([System.Windows.Media.Color]::FromArgb([byte](255*$opacity), 122, 184, 232))
    $x = $rand.NextDouble() * $canvasW
    $y = $rand.NextDouble() * $canvasH
    [System.Windows.Controls.Canvas]::SetLeft($dot, $x)
    [System.Windows.Controls.Canvas]::SetTop($dot, $y)
    $ParticleCanvas.Children.Add($dot) | Out-Null

    $vx = (($rand.NextDouble() * 2) - 1) * 0.18
    $vy = (($rand.NextDouble() * 2) - 1) * 0.18

    $particles.Add(@{
        Shape = $dot
        X = $x; Y = $y
        VX = $vx; VY = $vy
        BaseOpacity = $opacity
    })
}

# Lines pool (reused each tick, only shown when two particles are close enough)
$maxLines = 60
$lines = New-Object System.Collections.Generic.List[Object]
for ($i = 0; $i -lt $maxLines; $i++) {
    $ln = New-Object System.Windows.Shapes.Line
    $ln.Stroke = New-Object System.Windows.Media.SolidColorBrush ([System.Windows.Media.Color]::FromArgb(40, 122, 184, 232))
    $ln.StrokeThickness = 0.6
    $ln.Visibility = "Collapsed"
    $ParticleCanvas.Children.Add($ln) | Out-Null
    $lines.Add($ln)
}

$linkDistance = 95.0

$particleTimer = New-Object System.Windows.Threading.DispatcherTimer
$particleTimer.Interval = [TimeSpan]::FromMilliseconds(33)
$particleTimer.Add_Tick({
    foreach ($p in $particles) {
        $p.X += $p.VX
        $p.Y += $p.VY
        if ($p.X -lt 0)        { $p.X = 0;       $p.VX = -$p.VX }
        if ($p.X -gt $canvasW) { $p.X = $canvasW; $p.VX = -$p.VX }
        if ($p.Y -lt 0)        { $p.Y = 0;       $p.VY = -$p.VY }
        if ($p.Y -gt $canvasH) { $p.Y = $canvasH; $p.VY = -$p.VY }
        [System.Windows.Controls.Canvas]::SetLeft($p.Shape, $p.X)
        [System.Windows.Controls.Canvas]::SetTop($p.Shape, $p.Y)
    }

    # Recompute nearby links, up to $maxLines
    $lineIdx = 0
    for ($i = 0; $i -lt $particles.Count -and $lineIdx -lt $maxLines; $i++) {
        for ($j = $i + 1; $j -lt $particles.Count -and $lineIdx -lt $maxLines; $j++) {
            $dx = $particles[$i].X - $particles[$j].X
            $dy = $particles[$i].Y - $particles[$j].Y
            $dist = [Math]::Sqrt(($dx*$dx) + ($dy*$dy))
            if ($dist -lt $linkDistance) {
                $ln = $lines[$lineIdx]
                $ln.X1 = $particles[$i].X
                $ln.Y1 = $particles[$i].Y
                $ln.X2 = $particles[$j].X
                $ln.Y2 = $particles[$j].Y
                $fade = 1.0 - ($dist / $linkDistance)
                $alpha = [byte](60 * $fade)
                $ln.Stroke = New-Object System.Windows.Media.SolidColorBrush ([System.Windows.Media.Color]::FromArgb($alpha, 122, 184, 232))
                $ln.Visibility = "Visible"
                $lineIdx++
            }
        }
    }
    # Hide unused lines
    for ($k = $lineIdx; $k -lt $maxLines; $k++) {
        $lines[$k].Visibility = "Collapsed"
    }
})
$particleTimer.Start()

# ==============================================================================
# POPULATE TABS  (glyph-tagged headers, restyled cards)
# ==============================================================================
$Categories = @("RedLotus","Spokwn","Praiselily","Tonynoh","PS Scripts","Echo","Forensics","Zimmerman","Dependencies")

$btnTemplate = @"
<ControlTemplate xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' xmlns:x='http://schemas.microsoft.com/winfx/2006/xaml' TargetType='Button'>
    <Border x:Name='CardBorder' Background='{TemplateBinding Background}' CornerRadius='8' BorderBrush='#1C3A5E' BorderThickness='1'>
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height='*'/>
                <RowDefinition Height='Auto'/>
            </Grid.RowDefinitions>
            <ContentPresenter Grid.Row='0' HorizontalAlignment='Center' VerticalAlignment='Center'/>
        </Grid>
    </Border>
    <ControlTemplate.Triggers>
        <Trigger Property='IsMouseOver' Value='True'>
            <Setter TargetName='CardBorder' Property='Background' Value='#173258'/>
            <Setter TargetName='CardBorder' Property='BorderBrush' Value='#3D7AB0'/>
            <Setter Property='Foreground' Value='#9FD2FA'/>
        </Trigger>
    </ControlTemplate.Triggers>
</ControlTemplate>
"@

foreach ($cat in $Categories) {
    $glyph = $CategoryGlyphs[$cat]

    $tab = New-Object System.Windows.Controls.TabItem
    $tab.SetResourceReference([System.Windows.Controls.Control]::StyleProperty, "GlyphTab")

    $headerPanel = New-Object System.Windows.Controls.StackPanel
    $headerPanel.Orientation = "Horizontal"
    $glyphBlock = New-Object System.Windows.Controls.TextBlock
    $glyphBlock.Text = $glyph
    $glyphBlock.FontSize = 12
    $glyphBlock.Margin = "0,0,6,0"
    $glyphBlock.Foreground = [System.Windows.Media.Brushes]::SteelBlue
    $headerPanel.Children.Add($glyphBlock) | Out-Null
    $labelBlock = New-Object System.Windows.Controls.TextBlock
    $labelBlock.Text = $cat
    $headerPanel.Children.Add($labelBlock) | Out-Null
    $tab.Header = $headerPanel

    $scroll = New-Object System.Windows.Controls.ScrollViewer
    $scroll.VerticalScrollBarVisibility   = "Auto"
    $scroll.HorizontalScrollBarVisibility = "Disabled"

    $wrap = New-Object System.Windows.Controls.WrapPanel
    $wrap.Margin = "10"

    $catTools = $ToolData | Where-Object { $_.Category -eq $cat }

    foreach ($tool in $catTools) {
        $t = $tool

        $sp = New-Object System.Windows.Controls.StackPanel
        $sp.HorizontalAlignment = "Center"
        $sp.VerticalAlignment   = "Center"

        $glyphTile = New-Object System.Windows.Controls.TextBlock
        $glyphTile.Text = $glyph
        $glyphTile.FontSize = 18
        $glyphTile.Foreground = "#4F8FC4"
        $glyphTile.HorizontalAlignment = "Center"
        $glyphTile.Margin = "0,0,0,4"
        $sp.Children.Add($glyphTile) | Out-Null

        $nameBlock            = New-Object System.Windows.Controls.TextBlock
        $nameBlock.Text       = $t.Name
        $nameBlock.FontSize   = 12
        $nameBlock.Foreground = "#D7EAFB"
        $nameBlock.HorizontalAlignment = "Center"
        $nameBlock.TextAlignment = "Center"
        $nameBlock.TextWrapping = "Wrap"
        $nameBlock.Width = 150

        $typeBlock            = New-Object System.Windows.Controls.TextBlock
        $typeBlock.Text       = $t.Type.ToUpper()
        $typeBlock.FontSize   = 9
        $typeBlock.FontFamily = "Consolas"
        $typeBlock.HorizontalAlignment = "Center"
        $typeBlock.Margin     = "0,4,0,0"
        $typeBlock.Foreground = switch ($t.Type) {
            "GitHub" { "#5A9BD6" }
            "Cmd"    { "#4A8AB8" }
            "Web"    { "#5A6FC8" }
            "Link"   { "#6A9ACC" }
            default  { "#3A6A98" }
        }

        $sp.Children.Add($nameBlock) | Out-Null
        $sp.Children.Add($typeBlock) | Out-Null

        $btn             = New-Object System.Windows.Controls.Button
        $btn.Content     = $sp
        $btn.Width       = 192
        $btn.Height      = 96
        $btn.Margin      = "6"
        $btn.Cursor      = "Hand"
        $btn.Background  = "#0F2440"
        $btn.Foreground  = "#D7EAFB"
        $btn.Tag         = $t.Name
        $btn.Template    = [Windows.Markup.XamlReader]::Parse($btnTemplate)

        $btn.Add_Click({
            $clickedBtn = $_.Source
            $tName      = $clickedBtn.Tag
            $tData      = $ToolData | Where-Object { $_.Name -eq $tName } | Select-Object -First 1

            $origBg = $clickedBtn.Background
            $origFg = $clickedBtn.Foreground
            $clickedBtn.Background = "#1B3E64"
            $clickedBtn.IsEnabled  = $false

            if ($tData.Type -eq "Link") {
                Start-Process $tData.URL
                Set-Status "Ready" "Opened $tName in browser." "IDLE"
                Write-Log "Opened browser: $tName"
                $clickedBtn.Background = $origBg
                $clickedBtn.Foreground = $origFg
                $clickedBtn.IsEnabled  = $true

            } elseif ($tData.Type -eq "Cmd") {
                Set-Status "Running" "Launching $tName..." "BUSY"
                Write-Log "Starting: $tName"
                try {
                    Start-CmdToolCommand -Command $tData.Command
                    Write-Log "Launched: $tName"
                    Set-Status "Ready" "$tName launched." "IDLE"
                } catch {
                    Write-Log "Error: $_"
                    Set-Status "Error" "Failed to launch $tName." "ERR"
                }
                $clickedBtn.Background = $origBg
                $clickedBtn.Foreground = $origFg
                $clickedBtn.IsEnabled  = $true

            } else {
                Set-Status "Downloading" "Fetching $tName..." "BUSY"
                Write-Log "Starting download: $tName"

                $rs = [runspacefactory]::CreateRunspace()
                $rs.ApartmentState = "STA"
                $rs.ThreadOptions  = "ReuseThread"
                $rs.Open()

                $rs.SessionStateProxy.SetVariable("tData",       $tData)
                $rs.SessionStateProxy.SetVariable("installDir",  $installDir)
                $rs.SessionStateProxy.SetVariable("dispatcher",  $clickedBtn.Dispatcher)
                $rs.SessionStateProxy.SetVariable("btn",         $clickedBtn)
                $rs.SessionStateProxy.SetVariable("origBg",      $origBg)
                $rs.SessionStateProxy.SetVariable("origFg",      $origFg)
                $rs.SessionStateProxy.SetVariable("StatusTitle", $StatusTitle)
                $rs.SessionStateProxy.SetVariable("StatusSub",   $StatusSub)
                $rs.SessionStateProxy.SetVariable("StatusBadge", $StatusBadge)
                $rs.SessionStateProxy.SetVariable("LogBox",      $LogBox)

                $ps = [powershell]::Create()
                $ps.Runspace = $rs
                $null = $ps.AddScript({
                    function Set-StatusBg {
                        param($title,$sub,$badge)
                        $dispatcher.Invoke([Action]{
                            $StatusTitle.Text = $title
                            $StatusSub.Text   = $sub
                            $StatusBadge.Text = $badge
                        })
                    }
                    function Write-LogBg {
                        param($msg)
                        $dispatcher.Invoke([Action]{
                            $LogBox.AppendText("[$(Get-Date -f 'HH:mm:ss')] $msg`n")
                            $LogBox.ScrollToEnd()
                        })
                    }
                    function Restore-Btn {
                        $dispatcher.Invoke([Action]{
                            $btn.Background = $origBg
                            $btn.Foreground = $origFg
                            $btn.IsEnabled  = $true
                        })
                    }

                    $name = $tData.Name
                    $url  = $tData.URL
                    $cat  = $tData.Category
                    $type = $tData.Type

                    try {
                        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                        $destDir = "$installDir\$cat\$name"
                        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }

                        if ($type -eq "GitHub") {
                            $parts   = ($url -replace "https://github.com/","") -split "/"
                            $owner   = $parts[0]; $repo = $parts[1]
                            $api     = "https://api.github.com/repos/$owner/$repo/releases/latest"
                            $headers = @{"User-Agent"="BlueMoonSSTool"}
                            $rel     = Invoke-RestMethod -Uri $api -Headers $headers -ErrorAction Stop
                            $asset   = $rel.assets | Where-Object { $_.name -match "\.(zip|exe)$" } | Select-Object -First 1
                            if (-not $asset) { throw "No downloadable asset found." }
                            $dlUrl   = $asset.browser_download_url
                            $fname   = $asset.name
                        } else {
                            $dlUrl = $url
                            $fname = ($url -split "/")[-1]
                        }

                        $destFile = "$destDir\$fname"
                        if (Test-Path $destFile) {
                            Write-LogBg "Cached: $fname - skipping download."
                        } else {
                            Write-LogBg "Downloading $fname..."
                            $wc = New-Object System.Net.WebClient
                            $wc.Headers.Add("User-Agent","BlueMoonSSTool")
                            $wc.DownloadFile($dlUrl, $destFile)
                            Write-LogBg "Download complete: $fname"
                        }

                        if ($fname -match "\.zip$") {
                            Write-LogBg "Extracting..."
                            Expand-Archive -Path $destFile -DestinationPath $destDir -Force -ErrorAction Stop
                            $exe = Get-ChildItem -Path $destDir -Filter "*.exe" -Recurse | Select-Object -First 1
                            if ($exe) {
                                Write-LogBg "Launching $($exe.Name)..."
                                Start-Process -FilePath $exe.FullName
                            } else {
                                $dispatcher.Invoke([Action]{ Start-Process explorer.exe -ArgumentList "`"$destDir`"" })
                            }
                        } else {
                            Write-LogBg "Launching $fname..."
                            Start-Process -FilePath $destFile
                        }
                        Set-StatusBg "Ready" "$name launched successfully." "IDLE"
                    } catch {
                        Write-LogBg "Error: $_"
                        Set-StatusBg "Error" "Something went wrong with $name." "ERR"
                        $dispatcher.Invoke([Action]{ Start-Process $url })
                    }
                    Restore-Btn
                    $rs.Close()
                })
                $null = $ps.BeginInvoke()
            }
        })

        $wrap.Children.Add($btn) | Out-Null
    }

    $scroll.Content = $wrap
    $tab.Content    = $scroll
    $ToolsTab.Items.Add($tab) | Out-Null
}

# ==============================================================================
# MOON ICON  —  build once, animate a gentle glow pulse
# ==============================================================================
$moonCanvasInstance = New-MoonGlyphCanvas -Scale 0.62
$MoonHost.Child = $moonCanvasInstance

$glowPulse = New-Object System.Windows.Media.Animation.DoubleAnimation
$glowPulse.From = 0.35
$glowPulse.To   = 0.75
$glowPulse.Duration = New-Object System.Windows.Duration ([TimeSpan]::FromSeconds(2.6))
$glowPulse.AutoReverse = $true
$glowPulse.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever
$glowPulse.EasingFunction = New-Object System.Windows.Media.Animation.SineEase

$moonCanvasInstance.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $glowPulse)

# ==============================================================================
# EVENTS
# ==============================================================================
$window.Add_MouseLeftButtonDown({ try { $window.DragMove() } catch {} })
$CloseBtn.Add_Click({ $particleTimer.Stop(); $window.Close() })
$MinBtn.Add_Click({ $window.WindowState = "Minimized" })

$OpenFolderBtn.Add_Click({
    if (-not (Test-Path $installDir)) { New-Item -ItemType Directory -Path $installDir -Force | Out-Null }
    Start-Process explorer.exe $installDir
    Write-Log "Opened install folder."
})

$ClearCacheBtn.Add_Click({
    if (Test-Path $installDir) {
        $items = Get-ChildItem -Path $installDir -Force -ErrorAction SilentlyContinue
        $count = @($items).Count
        $items | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        Write-Log "Cleared $count item(s) from install folder."
        Set-Status "Clean" "Removed downloaded files." "IDLE"
    } else {
        Write-Log "Nothing to clear."
    }
})

$OpenCmdBtn.Add_Click({
    Start-Process "cmd.exe"
    Write-Log "Opened CMD."
})

$HostsCheckBtn.Add_Click({
    Write-Log "Running hosts file check..."
    Show-HostsCheck
})

Write-Log "Blue Moon SS Toolkit ready."
Write-Log "Files will be saved to: $installDir"
Set-Status "Ready" "Select a tool to launch or download." "IDLE"

$window.ShowDialog() | Out-Null
