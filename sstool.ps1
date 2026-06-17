Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml
Add-Type -AssemblyName System.Windows.Forms

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$installDir = "$env:USERPROFILE\Downloads\BlueMoonSSTool"

# ==============================================================================
# TOOL DATA
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
# XAML UI  —  Blue Moon palette
# ==============================================================================
[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="BlueMoon SS Toolkit"
    Width="1200" Height="760"
    MinWidth="1200" MinHeight="760"
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
        <SolidColorBrush x:Key="Accent"    Color="#7AB8E8"/>
        <SolidColorBrush x:Key="AccentDim" Color="#2C5F8A"/>
        <SolidColorBrush x:Key="TextMain"  Color="#C8DFF5"/>
        <SolidColorBrush x:Key="TextMuted" Color="#3A6A98"/>
        <SolidColorBrush x:Key="ConsoleBg" Color="#040A14"/>
        <SolidColorBrush x:Key="Border"    Color="#1A3050"/>

        <Style x:Key="SideBtn" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
            <Setter Property="FontSize"   Value="12"/>
            <Setter Property="Height"     Value="36"/>
            <Setter Property="Margin"     Value="0,0,0,3"/>
            <Setter Property="Cursor"     Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Left" VerticalAlignment="Center" Margin="12,0"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#122040"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="TitleBtn" TargetType="Button">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
            <Setter Property="Width"      Value="40"/>
            <Setter Property="Height"     Value="36"/>
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
    </Window.Resources>

    <Border Background="{StaticResource MainBg}" BorderBrush="#1A3050" BorderThickness="1" CornerRadius="8">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="42"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <!-- Title bar -->
            <Border Grid.Row="0" Background="{StaticResource SidebarBg}" CornerRadius="8,8,0,0">
                <Grid Margin="16,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <TextBlock Text=")))  " FontSize="14" FontWeight="Bold" Foreground="{StaticResource Accent}" FontFamily="Consolas"/>
                        <TextBlock Text="Blue Moon" FontSize="14" FontWeight="SemiBold" Foreground="{StaticResource TextMain}"/>
                        <TextBlock Text="  Screenshare Toolkit" FontSize="11" Foreground="{StaticResource TextMuted}" VerticalAlignment="Center" Margin="4,0,0,0"/>
                    </StackPanel>
                    <StackPanel Grid.Column="1" Orientation="Horizontal">
                        <Button x:Name="MinBtn"   Style="{StaticResource TitleBtn}" Content="_"/>
                        <Button x:Name="CloseBtn" Style="{StaticResource TitleBtn}" Content="X"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Body -->
            <Grid Grid.Row="1">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="210"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Sidebar -->
                <Border Grid.Column="0" Background="{StaticResource SidebarBg}" BorderBrush="#1A3050" BorderThickness="0,0,1,0">
                    <StackPanel Margin="10,14,10,14">

                        <!-- Moon art -->
                        <Border Background="#040A14" CornerRadius="6" Margin="0,0,0,14" Padding="0,10">
                            <TextBlock x:Name="MoonBlock"
                                Text="     .-~~~-.&#x0a;  .-~       ~-.&#x0a; /  .   .    \&#x0a;|  .   .   . |&#x0a; \  .   .   /&#x0a;  '-.     .-'&#x0a;     '~-~'"
                                FontFamily="Consolas" FontSize="9"
                                Foreground="{StaticResource Accent}"
                                HorizontalAlignment="Center"
                                TextAlignment="Center"
                                xml:space="preserve"/>
                        </Border>

                        <TextBlock Text="ACTIONS" FontSize="9" FontWeight="Bold" Foreground="{StaticResource TextMuted}" Margin="4,0,0,6"/>
                        <Button x:Name="OpenFolderBtn" Content="  Open Install Folder"    Style="{StaticResource SideBtn}"/>
                        <Button x:Name="ClearCacheBtn" Content="  Clear Downloaded Files" Style="{StaticResource SideBtn}"/>
                        <Button x:Name="OpenCmdBtn"    Content="  Open CMD"               Style="{StaticResource SideBtn}"/>
                        <Button x:Name="HostsCheckBtn" Content="  Check Hosts File"       Style="{StaticResource SideBtn}"/>

                        <Separator Background="#1A3050" Margin="0,10,0,10"/>

                        <TextBlock Text="ABOUT" FontSize="9" FontWeight="Bold" Foreground="{StaticResource TextMuted}" Margin="4,0,0,6"/>
                        <TextBlock Text="Blue Moon SS Toolkit" FontSize="11" FontWeight="SemiBold" Foreground="{StaticResource TextMain}" Margin="4,2,0,4"/>
                        <TextBlock Text="Screenshare forensics" FontSize="10" Foreground="{StaticResource TextMuted}" TextWrapping="Wrap" Margin="4,1,0,0"/>
                        <TextBlock Text="for Minecraft staff" FontSize="10" Foreground="{StaticResource TextMuted}" TextWrapping="Wrap" Margin="4,1,0,0"/>

                        <Separator Background="#1A3050" Margin="0,10,0,10"/>
                        <TextBlock x:Name="InstPathBlock" Text="" FontSize="9" Foreground="#2A4A6A" TextWrapping="Wrap" Margin="4,0"/>
                    </StackPanel>
                </Border>

                <!-- Main panel -->
                <Grid Grid.Column="1" Margin="16,14,16,14">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="10"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="10"/>
                        <RowDefinition Height="160"/>
                    </Grid.RowDefinitions>

                    <!-- Status card -->
                    <Border Grid.Row="0" Background="{StaticResource CardBg}" CornerRadius="6" Padding="16,10">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="Auto"/>
                            </Grid.ColumnDefinitions>
                            <StackPanel>
                                <TextBlock x:Name="StatusTitle" Text="Ready" FontSize="20" FontWeight="SemiBold" Foreground="{StaticResource TextMain}"/>
                                <TextBlock x:Name="StatusSub"   Text="Select a tool to launch or download." FontSize="11" Foreground="{StaticResource TextMuted}"/>
                            </StackPanel>
                            <Border Grid.Column="1" Background="#0D1F38" BorderBrush="#1A3A5C" BorderThickness="1" CornerRadius="4" Padding="10,4" VerticalAlignment="Center">
                                <TextBlock x:Name="StatusBadge" Text="IDLE" FontSize="12" FontWeight="Bold" Foreground="{StaticResource Accent}"/>
                            </Border>
                        </Grid>
                    </Border>

                    <!-- Tab control -->
                    <Border Grid.Row="2" Background="{StaticResource CardBg}" CornerRadius="6">
                        <TabControl x:Name="ToolsTab" Background="Transparent" BorderThickness="0" Padding="0">
                            <TabControl.Resources>
                                <Style TargetType="TabItem">
                                    <Setter Property="Foreground" Value="{StaticResource TextMuted}"/>
                                    <Setter Property="FontSize"   Value="11"/>
                                    <Setter Property="Padding"    Value="12,6"/>
                                    <Setter Property="Cursor"     Value="Hand"/>
                                    <Setter Property="Template">
                                        <Setter.Value>
                                            <ControlTemplate TargetType="TabItem">
                                                <Border x:Name="TabBorder" Background="Transparent" CornerRadius="4" Margin="3,4,3,0" Padding="12,5">
                                                    <ContentPresenter ContentSource="Header" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                                </Border>
                                                <ControlTemplate.Triggers>
                                                    <Trigger Property="IsSelected" Value="True">
                                                        <Setter TargetName="TabBorder" Property="Background" Value="#1A3A5C"/>
                                                        <Setter Property="Foreground" Value="#7AB8E8"/>
                                                    </Trigger>
                                                    <MultiTrigger>
                                                        <MultiTrigger.Conditions>
                                                            <Condition Property="IsMouseOver" Value="True"/>
                                                            <Condition Property="IsSelected"  Value="False"/>
                                                        </MultiTrigger.Conditions>
                                                        <Setter TargetName="TabBorder" Property="Background" Value="#122040"/>
                                                        <Setter Property="Foreground" Value="{StaticResource TextMain}"/>
                                                    </MultiTrigger>
                                                </ControlTemplate.Triggers>
                                            </ControlTemplate>
                                        </Setter.Value>
                                    </Setter>
                                </Style>
                            </TabControl.Resources>
                        </TabControl>
                    </Border>

                    <!-- Console -->
                    <Border Grid.Row="4" Background="{StaticResource ConsoleBg}" CornerRadius="6" Padding="12,8" BorderBrush="#1A3050" BorderThickness="1">
                        <Grid>
                            <Grid.RowDefinitions>
                                <RowDefinition Height="Auto"/>
                                <RowDefinition Height="*"/>
                            </Grid.RowDefinitions>
                            <TextBlock Text="ACTIVITY LOG" FontSize="9" FontWeight="Bold" Foreground="#2A4A6A" FontFamily="Consolas" Margin="0,0,0,4"/>
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

$MinBtn        = $window.FindName("MinBtn")
$CloseBtn      = $window.FindName("CloseBtn")
$StatusTitle   = $window.FindName("StatusTitle")
$StatusSub     = $window.FindName("StatusSub")
$StatusBadge   = $window.FindName("StatusBadge")
$LogBox        = $window.FindName("LogBox")
$ToolsTab      = $window.FindName("ToolsTab")
$OpenFolderBtn = $window.FindName("OpenFolderBtn")
$ClearCacheBtn = $window.FindName("ClearCacheBtn")
$OpenCmdBtn    = $window.FindName("OpenCmdBtn")
$HostsCheckBtn = $window.FindName("HostsCheckBtn")
$MoonBlock     = $window.FindName("MoonBlock")
$InstPathBlock = $window.FindName("InstPathBlock")

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

function Save-UrlToFile {
    param([string]$Uri, [string]$OutFile)
    $tmp = "$OutFile.download"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue }
    $wc = New-Object System.Net.WebClient
    $wc.Headers.Add("User-Agent","BlueMoonSSTool")
    try {
        $wc.DownloadFile($Uri,$tmp)
        if (Test-Path -LiteralPath $OutFile) { Remove-Item -LiteralPath $OutFile -Force -ErrorAction Stop }
        Move-Item -LiteralPath $tmp -Destination $OutFile -Force -ErrorAction Stop
    } finally {
        $wc.Dispose()
        if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue }
    }
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
# POPULATE TABS
# ==============================================================================
$Categories = @("RedLotus","Spokwn","Praiselily","Tonynoh","PS Scripts","Echo","Forensics","Zimmerman","Dependencies")

# Button template string (Blue Moon style)
$btnTemplate = "
<ControlTemplate xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation' TargetType='Button'>
    <Border Background='{TemplateBinding Background}' CornerRadius='6' BorderBrush='#1A3A5C' BorderThickness='1'>
        <StackPanel HorizontalAlignment='Center' VerticalAlignment='Center'>
            <ContentPresenter HorizontalAlignment='Center' VerticalAlignment='Center'/>
            <TextBlock x:Name='TypeTag' Text='' FontSize='9' Foreground='#2A5A8A' HorizontalAlignment='Center' Margin='0,2,0,0' FontFamily='Consolas'/>
        </StackPanel>
    </Border>
    <ControlTemplate.Triggers>
        <Trigger Property='IsMouseOver' Value='True'>
            <Setter Property='Background' Value='#1A3A5C'/>
            <Setter Property='Foreground' Value='#7AB8E8'/>
        </Trigger>
    </ControlTemplate.Triggers>
</ControlTemplate>"

foreach ($cat in $Categories) {
    $tab             = New-Object System.Windows.Controls.TabItem
    $tab.Header      = $cat

    $scroll          = New-Object System.Windows.Controls.ScrollViewer
    $scroll.VerticalScrollBarVisibility   = "Auto"
    $scroll.HorizontalScrollBarVisibility = "Disabled"

    $wrap            = New-Object System.Windows.Controls.WrapPanel
    $wrap.Margin     = "8"

    $catTools = $ToolData | Where-Object { $_.Category -eq $cat }

    foreach ($tool in $catTools) {
        $t = $tool

        # Build a small stack: name + type badge
        $sp              = New-Object System.Windows.Controls.StackPanel
        $sp.HorizontalAlignment = "Center"
        $sp.VerticalAlignment   = "Center"

        $nameBlock            = New-Object System.Windows.Controls.TextBlock
        $nameBlock.Text       = $t.Name
        $nameBlock.FontSize   = 12
        $nameBlock.Foreground = "#C8DFF5"
        $nameBlock.HorizontalAlignment = "Center"

        $typeBlock            = New-Object System.Windows.Controls.TextBlock
        $typeBlock.Text       = $t.Type.ToUpper()
        $typeBlock.FontSize   = 9
        $typeBlock.FontFamily = "Consolas"
        $typeBlock.HorizontalAlignment = "Center"
        $typeBlock.Margin     = "0,3,0,0"
        $typeBlock.Foreground = switch ($t.Type) {
            "GitHub" { "#3A6A98" }
            "Cmd"    { "#2A5A7A" }
            "Web"    { "#3A4A78" }
            "Link"   { "#4A6A8A" }
            default  { "#2A4A6A" }
        }

        $sp.Children.Add($nameBlock) | Out-Null
        $sp.Children.Add($typeBlock) | Out-Null

        $btn             = New-Object System.Windows.Controls.Button
        $btn.Content     = $sp
        $btn.Width       = 200
        $btn.Height      = 62
        $btn.Margin      = "6"
        $btn.Cursor      = "Hand"
        $btn.Background  = "#0D1F38"
        $btn.Foreground  = "#C8DFF5"
        $btn.Tag         = $t.Name
        $btn.Template    = [Windows.Markup.XamlReader]::Parse($btnTemplate)

        $btn.Add_Click({
            $clickedBtn = $_.Source
            $tName      = $clickedBtn.Tag
            $tData      = $ToolData | Where-Object { $_.Name -eq $tName } | Select-Object -First 1

            # Flash blue
            $origBg = $clickedBtn.Background
            $origFg = $clickedBtn.Foreground
            $clickedBtn.Background = "#1A3A5C"
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
                # GitHub / Web — download in background runspace
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
# MOON PHASE ANIMATION
# ==============================================================================
$moonFrames = @(
    "     .-~~~-.`n  .-~       ~-.`n /  .   .    \`n|  .   .   . |`n \  .   .   /`n  '-.     .-'`n     '~-~'",
    "     .-~~~-.`n  .-~       ~-.`n /    .   .  \`n|  .   .   . |`n \    .   . /`n  '-.     .-'`n     '~-~'",
    "     .-~~~-.`n  .-~       ~-.`n /  .   .    \`n|    .   .   |`n \  .   .   /`n  '-.     .-'`n     '~-~'",
    "     .-~~~-.`n  .-~       ~-.`n /    .      \`n|  .   .   . |`n \    .   . /`n  '-.     .-'`n     '~-~'"
)
$script:moonIdx = 0
$moonTimer = New-Object System.Windows.Threading.DispatcherTimer
$moonTimer.Interval = [TimeSpan]::FromMilliseconds(1200)
$moonTimer.Add_Tick({
    $script:moonIdx = ($script:moonIdx + 1) % $moonFrames.Count
    $MoonBlock.Text = $moonFrames[$script:moonIdx]
})
$moonTimer.Start()

# ==============================================================================
# EVENTS
# ==============================================================================
$window.Add_MouseLeftButtonDown({ try { $window.DragMove() } catch {} })
$CloseBtn.Add_Click({ $moonTimer.Stop(); $window.Close() })
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
