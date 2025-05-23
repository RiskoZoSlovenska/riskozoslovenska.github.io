<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "How I Switched to Linux", desc = "A short re-telling of my adventure and a record of overcome challenges." })
	<script src="./assets/scripts/code-blocks.js" type="module"></script>
</head>

<body>
	$(sidebar{})

	<main class="article-main">
		<h1>How I Switched to Linux</h1>
		<figure class="mx-auto md:m-0 md:ml-5 md:float-right">
			<img src="./assets/images/ntfs.png" width="364" height="149" alt="Screenshot of six files with the same name on Windows 7">
			<figcaption>
				I stumbled upon this while clearing out my old Win 7 laptop. All six files are unique and in the same folder.
			</figcaption>
		</figure>
		<p>
			I’ve grown up on Windows 7 and 10, and for the most part, I’ve had no issues with them. However, recently I’ve been
			lucky enough to frequent communities where Linux was practically everyone’s daily driver, and it sort of began to rub
			off on me. At some point, I got bored of Windows and finally decided that I should try Linux for myself.
		</p>
		<p>
			I spent a few days trying out different distributions. I wanted something practical: something less spoonfeed-y than
			Windows, but nothing that would be a nightmare to get into or troubleshoot. Towards the end of my trial process (which
			was neither systematic nor robust — I tried out only a small handful of distributions and judged mostly by first
			impressions), two distributions caught my eye: <a href="https://getsol.us/">Solus</a> and
			<a href="https://zorin.com/os/">Zorin</a>. In the end, I decided to go for Zorin, mostly because it was Ubuntu-based
			and so I expected that apps and support for it would be abundant.
		</p>
		<figure class="horizontal-centered">
			<img src="./assets/images/zorin.png" width="1366" height="768" alt="Screenshot of the Zorin OS 16 desktop">
			<figcaption>Random but authentic screenshot I took while triaging Zorin.</figcaption>
		</figure>
		<p>
			It took me a moment to appreciate <a href="https://www.gnome.org/">GNOME</a>. Once I accepted that I wouldn’t be able
			to theme it to look like Windows 10 (I really liked sharp corners), it didn’t take all that long for me to warm up to
			it. The filesystem structure was a bit new to me, but I grasped it quickly and found a new workflow in a matter of
			days. Zorin wasn’t perfect by any means and I had to spend some time fixing various issues, but I liked it overall.
		</p>
		<p>
			A year or so later, I gradually started questioning Zorin. There was nothing noticeably wrong about it at first, but
			the glacial pace at which it moved became more and more apparent the longer I used it. Zorin is built upon Ubuntu LTS,
			meaning that it only gets a new release when a new LTS comes out — once every two years. That’s an abysmally long
			time. Zorin’s consistent tardiness began to be irritating, and slowly I grew bored again.
		</p>
		<p>
			Shortly before I started considering switching distros, a (non-tech-savvy) friend of mine took the plunge and hopped
			from Windows 10 to <a href="https://fedoraproject.org/workstation/">Fedora Workstation</a>. Furthermore,
			<a href="https://fedoraproject.org/">Fedora</a> cropped up often in online discussions and was ultimately recommended
			to me by another friend. Needless to say, it caught my attention. After a bit of research, I was excited:
			Fedora was said to be easy, up-to-date, and it enjoyed wide support — a perfect match. I had also given thought to
			<a href="https://archlinux.org/">Arch</a>, <a href="https://endeavouros.com/">EndeavourOS</a> and Solus, but I didn’t
			want to make my life any more difficult than it needed to be nor did I want to risk breaking my system with rolling
			releases. So, Fedora it was.
		</p>
		<p>
			Next, I needed to pick a desktop environment. GNOME was an obvious candidate, but
			<a href="https://kde.org/plasma-desktop/">KDE</a> caught my eye thanks to its reputation as being heavily
			configurable, pretty and lightweight. I also wanted to try out <a href="https://fedoraproject.org/spins/cinnamon/">
			Cinnamon</a>, but the moment I booted up a Fedora KDE LiveCD, I knew that it was the one. KDE greeted me with the
			beloved Windows-like taskbar layout, and the default file manager,
			<a href="https://apps.kde.org/dolphin/">Dolphin</a>, completely blew <a href="https://apps.gnome.org/Nautilus/">
			Nautilus</a> and <a href="https://docs.xfce.org/xfce/thunar/start">Thunar</a> (the file managers on Zorin Core and
			Zorin Lite, respectively) out of the water. With that, I was set to switch once again.
		</p>
		<p>
			The switch from Zorin to <a href="https://fedoraproject.org/spins/kde/">Fedora KDE</a> felt even bigger than the
			switch from Windows to Zorin. Features that needed GNOME extensions under Zorin were built into KDE, and I liked KDE’s
			sharper, denser interface in comparison to GNOME’s lofty buttons and overweight corners. Fedora’s package manager
			(<code>dnf</code>) also felt friendlier and more complete than Ubuntu’s (and by extension, Zorin’s) <code>apt</code>,
			and I no longer had to deal with Snaps since Fedora’s package repositories are impeccably up-to-date, sometimes even
			surpassing Flathub.
		</p>
		<p>
			One thing that I’ll admit Zorin did better was the initial installation and setup process. Fedora 38’s installer was
			somewhat confusing (thankfully, as of this writing, there should be a new and improved one coming out soon — if it
			isn’t out already). I also had to manually add/install Flathub, <a href="https://rpmfusion.org/Howto/NVIDIA">
			NVIDIA drivers</a> and <a href="https://wiki.winehq.org/Fedora">WINE</a>, which wasn’t hard but was still something
			Zorin did for me (or let me do with a single click). I also set X11 as the default window system as I didn’t want
			to deal with yet another thing that could make stuff break (I've since switched to Wayland and have had no issues).
			Just like on Zorin, a few residual nitpicks remain, but otherwise, the process went very smoothly.
		</p>
		<p>
			Overall, there were hiccups. Despite that, Linux, Fedora, KDE and the things around them are phenomenal pieces of
			software; ditching Windows is probably one of the best decisions I’ve ever made. It’s been and continues to be a wild
			ride that never fails to teach me something new. If you, dear reader, are on Windows and are getting bored of — or fed
			up with — it, why not try something new? Linux won’t disappoint.
		</p>
		<hr>
		<p>
			Here follows a list of Windows-specific software I have (or haven’t) found Linux alternatives to, in case someone
			might find it useful.
		</p>
		<ul class="list-disc pl-8 mb-5">
# 		for _, item in ipairs({
# 			{ "Paint.NET", "https://www.getpaint.net/", [[
# 				Replaced by Pinta, Krita and GIMP. Pinta is an open-source fork of an old version of PDN, so it should be
# 				more-or-less a direct replacement (as long as you install an up-to-date version). However, I’ve found Krita to be
# 				more suitable for my occasional needs, and I can always fall back to GIMP for more advanced things.
# 			]] },
# 			{ "Logitech G-Hub", "https://www.logitechg.com/en-us/innovation/g-hub.html", [[
# 				It <a href="https://www.reddit.com/r/LogitechG/comments/gmuogw/logitech_g_hub_for_linux/">doesn’t look to be
# 				coming anytime soon</a>, but there are some <a href="https://github.com/libratbag/piper">open-source
# 				alternatives</a>. Personally, I just use the on-board profile on my mouse and plug it into a Windows machine
# 				whenever I need to change anything (which is once in a blue moon anyway).
# 			]] },
# 			{ "ScreenToGif", "https://www.screentogif.com/", [[
# 				KDE Plasma’s screenshotting utility, <a href="https://apps.kde.org/spectacle/">Spectacle</a>, provides rectangular
# 				region screen recording which is sufficient for my needs. <a href="https://github.com/phw/peek">Peek</a> provides
# 				a more ScreenToGif-like functionality, but as of <time>2025-01-09<time> does not support recording on Plasma. The
# 				last similar utility I know of is <a href="https://github.com/SeaDve/Kooha">Kooha</a>, but it doesn't work either.
# 			]] },
# 			{ "HWiNFO", "https://www.hwinfo.com/", [[
# 				The functionality I needed — checking temperatures — was filled in by various taskbar-based extensions/widgets.
# 				These were <a href="https://extensions.gnome.org/extension/120/system-monitor/">System Monitor</a> +
# 				<a href="https://extensions.gnome.org/extension/841/freon/">Freon</a> on GNOME (Zorin Core) and System monitor
# 				Sensors on KDE. Honestly, taskbar-based monitoring graphs are one of my favourite Linux features to date.
# 			]] },
# 			{ "VSDC Video Editor", "https://www.videosoftdev.com/free-video-editor", [[
# 				Replaced completely by <a href="https://kdenlive.org/">Kdenlive</a>.
# 			]] },
# 			{ "Foxit PDF Reader", "https://www.foxit.com/pdf-reader/", [[
# 				Replaced completely by <a href="https://okular.kde.org/">Okular</a>.
# 			]] },
# 		}) do
			<li class="my-3"><a class="font-bold underline" href="$(item[2])">$(item[1])</a>: $(item[3])</li>
# 		end
		</ul>
		<hr>
		<p>
			And last but not least, the complete list of things that I’ve stumbled upon that needed some fixing. In general, these
			are things that didn’t or don’t work as expected on Linux compared to Windows (10) and are in no particular order.
			I’ve tried to detail what I’ve attempted and what worked for each issue.
		</p>
		<p>
			You may notice that this list is fairly long. However, do not take this as an indication that the Linux experience is
			janky; the positives far outweigh any negatives.
		</p>

# local ZORIN_LITE = '<li class="inline-block py-0.5 px-1 rounded-sm text-2xs text-gray-100 bg-[#15a6f0]">Zorin 16 Lite</li>'
# local ZORIN_CORE = '<li class="inline-block py-0.5 px-1 rounded-sm text-2xs text-gray-100 bg-[#15a6f0]">Zorin 16 Core</li>'
# local FEDORA_KDE = '<li class="inline-block py-0.5 px-1 rounded-sm text-2xs text-gray-100 bg-[#3c6eb4]">Fedora/KDE</li>'
# local ALL = { ZORIN_CORE, ZORIN_LITE, FEDORA_KDE }
#
# local function Issue(number, title, resolved, systems, ...)
# 	return {
# 		number = number,
# 		title = title,
# 		resolved = resolved,
# 		systems = systems,
# 		paragraphs = {...},
# 	}
# end
#
# -- Current Largest Issue #: 40
# local issues = {
# 	Issue(8, "(Some) Flatpaks don’t use the system cursor theme", false, ALL, [[
# 		Initially, this was caused by the Flatpaks not having the permissions to read the cursor files. The fix was simple:
# 		just <a href="https://github.com/flatpak/flatpak/issues/709#issuecomment-741883444">grant them the permissions to access
# 		cursors</a>. However, that does not fix some Flatpaks, notably the stock Minecraft Launcher. I’m guessing that it has
# 		something to do with the Launcher being designed primarily for Ubuntu/GNOME.
# 	]], [[
# 		Either way, none of the apps I use are affected anymore (I use <a href="https://prismlauncher.org/">Prism Launcher</a>
# 		for Minecraft).
# 	]]),
# 	Issue(20,  "Spotify doesn’t let me specify the offline download location", false, ALL, [[
# 		I’m pretty sure the Flatpak version of Spotify has a bit of trouble with this. At some point I got it working, but I don’t
# 		remember which packaging I was using. Nowadays, I just use the default download location (with the Flatpak packaging).
# 	]]),
# 	Issue(24, "The ‘Recent’ tab in the file explorer is sub-par", false, ALL, [[
# 		My gripes with it on GNOME were that it <a href="https://askubuntu.com/questions/1240286/how-to-show-folders-on-nautilus-recent-list">
# 		1) doesn’t show folders and 2) doesn’t show up in the ‘Save File’ dialog</a>.
# 	]], [[
# 		KDE’s Dolphin file manager has neither issue. However, I’ve found that Dolphin is a bit unreliable in how it tracks which
# 		items were accessed (i.e. the list of folders in <code>recentlyused:/</code> isn’t the same as the list of folders in
# 		<code>recentlyused:/locations/</code>; the same goes for files) and it does not seem to sort by access frequency at all.
# 		Furthermore, occasionally, it takes really long to load the list of recently used files/folders.
# 	]], [[
# 		I have become used to simply not using the ‘Recent’ tab.
# 	]]),
# 	Issue(30, "Pressing the power button while the PC is locked doesn’t put it to sleep", false, { FEDORA_KDE }, [[
# 		This bug has been reported <a href="https://bugs.kde.org/show_bug.cgi?id=392798">here</a>.
# 	]]),
# 	Issue(37, "The icons of certain apps have black backgrounds/are rendered wrong", false, { FEDORA_KDE }, [[
# 		This has been reported <a href="https://bugs.kde.org/show_bug.cgi?id=448234">here</a>. The bug has been marked as RESOLVED
# 		UPSTREAM (QtSvg, the renderer to blame, was/is getting improvements), but as of <time>2025-01-08</time>, some icons
# 		are still mis-rendered.
# 	]]),
# 	Issue(38, "<code>os-prober</code> does not detect Windows 10", false, { FEDORA_KDE }, [[
# 		I have a copy of Windows on a separate 128 GB SSD for when I have no other option but to deal with a Windows-only app.
# 		However, <code>os-prober</code> does not detect it and so it is not added to the GRUB boot menu automatically, which means
# 		I cannot programmatically reboot into Windows.
# 	]], [[
# 		The internet <a href="https://www.google.com/search?q=os-prober+windows+on+different+drive">is littered with many similar
# 		questions</a>, many of which have never been resolved. <code>grub-mount</code>ing the Windows EFI partition works without
# 		issues, but whether it’s mounted or not changes nothing. The most common solution seems to be adding a menu entry
# 		manually, which is what I ended up doing anyway. I added the following to <code>/etc/grub.d/40_custom</code> (remember to
# 		replace <code>848F-AF37</code> with your own UUID):
# 	]], [[
#<pre><code>menuentry 'Windows Boot Manager' {
#	search.fs_uuid 848F-AF37 root hd0,gpt1
#	chainloader /EFI/Microsoft/Boot/bootmgfw.efi
#}</code></pre>
# 	]], [[
# 		Credit goes to <a href="https://bbs.archlinux.org/viewtopic.php?pid=1805919#p1805919">these</a>
# 		<a href="https://bbs.archlinux.org/viewtopic.php?pid=2022765#p2022765">two</a> posts. Of course, don’t forget to run
# 		<code>sudo grub2-mkconfig -o /etc/grub2.cfg</code> to apply changes.
# 	]]),
# 	Issue(1, "PC wakes up immediately after being suspended", true, ALL, [[
# 		See <a href="https://www.reddit.com/r/gigabyte/comments/mxqvja/b550i_aorus_pro_ax_f13h_instantly_wakes_from_sleep/">this
# 		Reddit post</a>. The solution is to
# 		<a href="https://www.reddit.com/r/gigabyte/comments/p5ewjn/b550i_pro_ax_f13_bios_sleep_issue_on_linux/">
# 		“disable GPP0 wakeup”</a>, whatever that means.
# 	]]),
# 	Issue(2, "WiFi adapter isn’t being detected", true, { ZORIN_CORE }, [[
# 		Zorin didn’t see my WiFi adapter; see
# 		<a href="https://forum.zorin.com/t/wifi-is-not-showing-no-wifi-adapter-found-error-in-zorin/428/12">this post</a> for a
# 		possibly related occurrence. Nevertheless, things started working sometime later when I swapped out my GPU. Perhaps it was
# 		some sort of bizarre hardware conflict?
# 	]]),
# 	Issue(3, "Colours are rendered incorrectly sometimes", true, { ZORIN_CORE, FEDORA_KDE }, [[
# 		For example, my signature red, <span style="color: #ff3232">#FF3232</span>, gets rendered as
# 		<span style="color: #ff093a">#FF093A</span>. Certain applications display it correctly, but others don’t.
# 	]], [[
# 		I spent a non-negligible amount of time trying to figure this out. The closest that Google got me to the solution
# 		was <a href="https://www.reddit.com/r/linuxquestions/comments/i2mkms/why_do_colours_look_wrong_in_linux_compared_to/">this
# 		Reddit post</a>. I tried fiddling around with monitor settings, the NVIDIA control panel, different GPUs, and even
# 		different monitors to no avail. Some faint memory told me that I had a similar issue under Windows 10 and fixed it then by
# 		changing some setting about the color format or whatnot, but that didn’t work here.
# 	]], [[
# 		This took me a while to figure out and it had nothing to do with the monitor or the GPU. First, I narrowed the issue down
# 		to only Electron apps, like VS Code and Discord. Then, I found out that Linux has this setting called ‘Device Color
# 		Profiles’ and my monitor had a default profile applied. I just removed it and the colours started rendering correctly
# 		after a restart.
# 	]]),
# 	Issue(4, "Bluetooth doesn’t work on my laptop", true, { ZORIN_CORE, ZORIN_LITE }, [[
# 		I just needed to <a href="https://fosspost.org/fix-bluetooth-rtl8761b-problem-on-linux-ubuntu-22-04/">point Linux to the
# 		correct firmware</a>.
# 	]]),
# 	Issue(5,  "My secondary disk is mounted under <code>/media</code> and has an unmount button.", true, { ZORIN_CORE }, [[
# 		Setting the mount point to a folder under <code>/mnt</code> wasn’t a hard fix. However, I wasn’t able to hide the unmount
# 		button only for that disk without hiding the disk itself, so I just disabled the ‘Removable Drives’ menu in the system
# 		tray.
# 	]], "Fedora, on the other hand, was smart enough to not prompt me with an ‘unmount’ button in the first place."),
# 	Issue(6, "Desktop notifications show up top centre instead of bottom right", true, { ZORIN_CORE }, [[
# 		<a href="https://ubuntuhandbook.org/index.php/2018/05/change-notification-position-ubuntu-18-04/">Install</a>
# 		the <a href="https://extensions.gnome.org/extension/708/panel-osd/">Panel OSD extension</a>.
# 	]],
# 		"Not an issue under KDE."
# 	),
# 	Issue(7, "Can’t open WebP images", true, { ZORIN_CORE, ZORIN_LITE },
# 		"<a href=\"https://askubuntu.com/a/1346951\">Install aruiz/webp-pixbuf-loader</a>.",
# 		"Not an issue under Fedora/KDE."
# 	),
# 	Issue(9, "Black screen on laptop wakeup", true, { ZORIN_LITE }, [[
# 		My laptop screen occasionally remains off after waking up from sleep. I’m pretty sure something
# 		about how it’s put to sleep triggers it, but I haven’t been able to figure out what exactly.
# 	]], [[
# 		A possibly related bug might be <a href="https://bugs.launchpad.net/ubuntu/+source/xubuntu-default-settings/+bug/1303736">
# 		this one</a>. At first, I used
# 		<a href="https://bugs.launchpad.net/ubuntu/+source/xubuntu-default-settings/+bug/1303736/comments/11">this workaround</a>,
# 		but the last time I used Zorin, just closing and re-opening the lid worked to fix it basically every time.
# 	]]),
# 	Issue(10, "No Power Off/Restart buttons on the lock screen (only Suspend)", true, ALL, [[
# 		I found out this is Linux’s stricter equivalent of Windows’ “other users may lose unsaved work” prompt and can’t really
# 		be “fixed”.
# 	]]),
# 	Issue(11, "Audio occasionally breaks (turns into static)", true, { ZORIN_CORE }, [[
# 		This stopped happening at some point and thus became a non-issue. Nevertheless, when it happened, I found that restarting
# 		PulseAudio fixed it. However, restarting PulseAudio broke Spotify and other apps that depended on it, so I made a
# 		little script to restart everything:
# 	]], [[
#<pre><code class="language-bash"># Audio breaks sometimes and resetting PulseAudio seems to fix it.
#&#35; Spotify also needs a restart to work after PulseAudio is restarted.
#function restartpulse() {
#	pulseaudio --kill
#	pkill -x spotify
#	nohup spotify > /dev/null 2>&1 &
#	disown $!
#}</code></pre>
# 	]]),
# 	Issue(12, "The login screen uses different system settings", true, ALL, [[
# 		This mostly affects things like mouse speed, cursor icon, background, theme and so on. It happens because the login screen
# 		is ran under a different user. To change the mouse speed for GDM (the login manager in Ubuntu, Zorin, etc.), see
# 		<a href="https://www.reddit.com/r/gnome/comments/qvcxpt/is_there_a_way_to_change_the_mouse_sensitivity_in/">this Reddit
# 		post</a>. To change other things such as the GDM background, see
# 		<a href="https://www.linuxuprising.com/2021/05/how-to-change-gdm3-login-screen-greeter.html">this article</a>. In KDE,
# 		these settings can be changed in System Settings.
# 	]]),
# 	Issue(13, "Can’t change the audio output device from the system tray menu", true, { ZORIN_CORE }, [[
# 		Install the <a href="https://extensions.gnome.org/extension/906/sound-output-device-chooser/">Sound Input & Output
# 		Device Chooser extension</a>.
# 	]], [[
# 		Not an issue under Fedora/KDE.
# 	]]),
# 	Issue(14, "No “Open In Code” context action in the file explorer", true, ALL, {
# 		'Nautilus (Zorin Core): Install <a href="https://github.com/harry-cpp/code-nautilus">this extension</a>.',
# 		'Thunar (Zorin Lite): <a href="https://docs.xfce.org/xfce/thunar/custom-actions">Add a custom action</a>.',
# 		'Dolphin (Fedora/KDE): Install an extension from the software store.',
# 	}),
# 	Issue(15, "The file explorer doesn’t understand <code>.code-workspace</code> files", true, { ZORIN_CORE, ZORIN_LITE }, [[
# 		<a href="https://unix.stackexchange.com/a/564888">Register a custom MIME type</a>. My <code>x-code-workspace.xml</code>
# 		file looked like this:
# 	]], [[
#<pre><code class="language-xml">&lt;?xml version=&quot;1.0&quot;?&gt;
#&lt;mime-info xmlns=&quothttp://www.freedesktop.org/standards/shared-mime-info&quot&gt;
#	&lt;mime-type type=&quot;application/x-code-workspace&quot;&gt;
#		&lt;comment&gt;VS Code Workspace&lt;/comment&gt;
#		&lt;glob pattern=&quot;*.code-workspace&quot;/&gt;
#	&lt;/mime-type&gt;
#&lt;/mime-info&gt;</code></pre>
# 	]], "Fedora/KDE is not affected."),
# 	Issue(16, "Discord and VS Code have ugly topbars", true, ALL, [[
# 		VS Code can hide the system topbar by changing the <code>window.titleBarStyle</code> setting. Discord, of course, doesn’t
# 		have such setting, but it’s honestly not that bad anyway.
# 	]]),
# 	Issue(17, "Discord doesn’t display the notifications badge on the taskbar icon", true, ALL, [[
# 		Looks like an <a href="https://github.com/flathub/com.discordapp.Discord/issues/228">issue with Discord</a>. As of
# 		<time>2024-03-17</time>, on Fedora/KDE, using <a href="https://github.com/RPM-Outpost/discord">the RPM packaging of
# 		Discord</a> and <a href="https://github.com/Vencord/Vesktop/issues/298#issuecomment-1980029514">installing
# 		<code>libunity</code></a> fixes this issue. I haven’t verified it myself but it looks like
# 		<a href="https://github.com/flathub/com.discordapp.Discord/pull/368">it should work in the Flatpak packaging too</a>. I
# 		dunno about GNOME.
# 	]]),
# 	Issue(18, "Discord<wbr>/Spotify<wbr>/etc. don’t automatically open on boot", true, ALL, [[
# 		Tweak the "Startup Applications" system setting.
# 	]]),
# 	Issue(19, "Spotify doesn’t save volume", true, ALL, [[
# 		This fixed itself at some point.
# 	]]),
# 	Issue(21, "Spotify exits if it’s closed (instead of sitting in the icon area)", true, ALL, [[
# 		This is on Spotify’s end and
# 		<a href="https://community.spotify.com/t5/Desktop-Linux/Cannot-minimize-to-tray-on-Linux/td-p/1703131">has been requested
# 		many times</a>. There are also <a href="https://www.addictivetips.com/ubuntu-linux-tips/spotify-system-tray-linux/">many
# 		</a> <a href="https://www.maketecheasier.com/minimize-spotify-to-system-tray-linux/">articles</a> with "solutions" that
# 		either don’t work at all or are more inconvenient to set up and use the convenience issue they are fixing. For a while, I
# 		simply moved Spotify into another workspace which worked quite well. However, it looks like Spotify finally decided to fix
# 		this, and as of a few months ago, Spotify does have a system tray icon it can minimize to.
# 	]]),
# 	Issue(22, "Spotify cannot open links in the app", true, ALL, [[
# 		Clicking on a Spotify link launches a new broken instance instead of redirecting the existing one.
# 	]], [[
# 		In the past, solved this using <a href="https://gist.github.com/wandernauta/6800547">sp</a>, a
# 		<a href="https://technex.us/2022/05/how-to-make-a-launcher-for-spotify-in-linux-that-works-with-spotify-links/">custom
# 		Spotify launcher</a> (requires editing Spotify’s <code>.desktop</code> file) and a
# 		<a href="https://github.com/relisher/spotify-desktop-ify">Firefox extension</a>.
# 	]], [[
# 		Nowadays, I find that using <a href="https://addons.mozilla.org/en-US/firefox/addon/spotify-desktop-ify/">this extension
# 		</a> in conjunction with <a href="https://addons.mozilla.org/en-CA/firefox/addon/blacklist-autoclose/">this one</a> (to
# 		close opened tabs) is sufficient. It still leaves Firefox focused, but it’s good enough for me.
# 	]]),
# 	Issue(23, "Image thumbnails have ugly white borders in Nautilus", true, { ZORIN_CORE }, [[
# 		I found <a href="https://ubuntugenius.wordpress.com/2011/10/14/how-to-change-white-border-around-image-video-thumbnails-to-drop-shadow-in-ubuntus-file-manager-nautilus/">
# 		this article</a>, but doing what it says doesn’t work. Another answer
# 		<a href="https://answers.launchpad.net/cover-thumbnailer/+question/186685">here</a> involves recompiling Nautilus, which
# 		is too much effort for thumbnail borders. I eventually got used to it.
# 	]], [[
# 		This is no longer an issue after I switched to Dolphin (Fedora KDE’s file manager) which is better anyway.
# 	]]),
# 	Issue(25, "Folders don’t preview their contents in their icon.", true, { ZORIN_CORE, ZORIN_LITE }, [[
# 		See <a href="https://askubuntu.com/questions/992947/how-to-preview-images-in-folders-icons">this question</a>.
# 		One often-suggested solution is <a href="https://github.com/flozz/cover-thumbnailer">flozz/cover-thumbnailer</a>, but I
# 		have never tried it myself.
# 	]], [[
# 		This issue was resolved when I moved to Fedora; Dolphin doesn’t only preview folder icons, but also animates them (both
# 		for folder contents and for videos) when you hover over them.
# 	]]),
# 	Issue(26, "Thunar (Zorin Lite file manager) doesn’t show the size of the current selection", true, { ZORIN_LITE}, [[
# 		<a href="https://forum.zorin.com/t/can-thunar-show-file-count-for-folders/3443">Enable the statusbar</a>.
# 	]]),
# 	Issue(27, "No “copy file path” context option in the file explorer", true, { ZORIN_CORE, ZORIN_LITE }, [[
# 		<a href="https://askubuntu.com/a/225676">The clipboard is context-sensitive</a>; no fix is required. Additionally, Dolphin
# 		does have this menu option.
# 	]]),
# 	Issue(28, "NVENC breaks on suspend", true, { ZORIN_CORE, ZORIN_LITE }, [[
# 		If something was using NVENC when the computer went to sleep, NVENC would break until the next reboot. Apparently, this
# 		was a pretty common issue — see <a href="https://bbs.archlinux.org/viewtopic.php?id=272472">this question</a> and
# 		<a href="https://www.reddit.com/r/linux_gaming/comments/uul5ns/obs_error_failed_to_open_nvenc_codec_after_pc/">this Reddit
# 		post</a>. As mentioned in the linked issue, this caused issues with OBS and Sunshine.
# 	]], [[
# 		Initially, I
# 		<a href="https://blog.christophersmart.com/2016/05/11/running-scripts-before-and-after-suspend-with-systemd/">set up a
# 		script</a> that <code>pkill -x obs</code>’d before every suspend. However, if I recall correctly, I ended up fixing the
# 		whole problem using <a href="https://askubuntu.com/a/1309807">these steps</a>. Additionally, I don’t recall having this
# 		issue on Fedora at all. OBS still breaks if it’s recording during a system suspension, but that’s a separate and much more
# 		minor issue.
# 	]]),
# 	Issue(29, "Black screen after logging out", true, { FEDORA_KDE }, [[
# 		Probably-related reports/posts/questions are
# 		<a href="https://forum.manjaro.org/t/black-screen-when-using-switch-user-or-logout/85738">this one</a>,
# 		<a href="https://www.reddit.com/r/kde/comments/zg1qfq/fix_to_black_screen_after_logout_with_sddm_wayland/">this one</a>,
# 		<a href="https://discussion.fedoraproject.org/t/fedora-36-kde-spin-no-monitor-output-of-sddm-after-logout/76139">this
# 			one</a>,
# 		<a href="https://github.com/sddm/sddm/issues/1733">this one</a> and
# 		<a href="https://www.reddit.com/r/Fedora/comments/zaslud/anyone_else_on_kde_spin_have_sddm_break_on_logout/">this one</a>.
# 		For me, <a href="https://www.reddit.com/r/Fedora/comments/zaslud/anyone_else_on_kde_spin_have_sddm_break_on_logout/">
# 		making SDDM use X11 instead of Wayland</a> fixed the issue. However, from the looks of the other reports, other
# 		workarounds may work as well.
# 	]]),
# 	Issue(31, "The screen doesn’t turn off immediately after locking", true, { FEDORA_KDE }, [[
# 		This bug was reported <a href="https://bugs.kde.org/show_bug.cgi?id=348529">here</a> and has been fixed since I created
# 		this issue. There is now a dedicated ‘When Locked’ chooser for screen turn-off times.
# 	]]),
# 	Issue(32, "WINE applications have crackly audio", true, { FEDORA_KDE }, [[
# 		This bug has been reported as <a href="https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3098">
# 		pipewire/pipewire#3098</a>. I used the workaround described
# 		<a href="https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3098#note_1823699">here</a> and
# 		<a href="https://discourse.nixos.org/t/pipewire-crackling-in-wine-proton/29131/2">here</a>; that is, creating
# 		<code>~/.config/pipewire/pipewire-pulse.conf.d/20-pulse-properties.conf</code> with the following content:
# 	]], [[
#<pre><code class="no-highlight">pulse.properties = {
#	pulse.min.req     = 512/48000
#	pulse.min.frag    = 512/48000
#	pulse.min.quantum = 512/48000
#}</code></pre>
# 	]], [[
# 		Note that I used <code>512</code> instead of <code>256</code> as the latter still caused issues. Also, remember to
# 		<code>systemctl --user restart pipewire pipewire-pulse</code> to apply changes (or just restart the entire PC).
# 	]], [[
# 		This issue is no longer occuring.
# 	]]),
# 	Issue(33, "Discord doesn’t stream audio when screen-sharing", true, ALL, [[
# 		This is a
# 		<a href="https://www.reddit.com/r/linux_gaming/comments/15i9wka/whats_the_best_solution_to_discord_screenshare/">rather
# 		well-known limitation</a> of the official Discord client on Linux, and is mostly Discord’s fault. The solution is to use
# 		one of the many <a href="https://github.com/maltejur/discord-screenaudio">alternate</a>
# 		<a href="https://github.com/Vencord/Vesktop">clients</a> or to use
# 		<a href="https://github.com/IceDBorn/pipewire-screenaudio">this Firefox extension</a>, open Discord in the browser and
# 		stream from there.
# 	]]),
# 	Issue(34, "Launching certain applications (e.g. NVIDIA X Server Settings, some WINE apps) turns off the blue light filter",
# 		true, ALL, [[
# 		This seems to have been reported <a href="https://bugs.launchpad.net/ubuntu/+source/gnome-shell/+bug/1728342">here</a>.
# 		Strangely, that bug report had been filed against GNOME, not KDE. Nevertheless, the symptoms appeared identical to what I
# 		was experiencing. Either way, I cannot reproduce this any longer.
# 	]]),
# 	Issue(35, "Dolphin hides <code>.old</code> and <code>.bak</code> files", true, { FEDORA_KDE }, [[
# 		As pointed out by
# 		<a href="https://forum.manjaro.org/t/is-it-possible-to-change-the-definition-of-a-hidden-file-in-dolphin/149923">this
# 		question post</a>, this is a side effect of <a href="https://bugs.kde.org/show_bug.cgi?id=3212">this feature request</a>
# 		being merged. As mentioned on the feature request page, the behaviour can be reverted by disassociating <code>.old</code>
# 		and <code>.bak</code> files from the <code>application/x-trash</code> mimetype, creating a new one (e.g.
# 		<code>application/x-backup</code>) and associating the file extensions with it.
# 	]], [[
# 		Also, see <a href="https://discuss.kde.org/t/hidden-and-backup-files-in-dolphin/6129">this discussion post</a>.
# 	]]),
# 	Issue(36, "Can’t fine-tune the time and date format in KDE", true, { FEDORA_KDE }, [[
# 		KDE uses the current locale to determine the date and time format and I wasn’t able to manually set it to ISO 8601.
# 		Thankfully, this has been asked about and answered <a href="https://superuser.com/questions/1162283/use-iso-time-and-date-format-in-kde-5">
# 		here</a> — the solution is to set the locale to <code>en_SE</code>.
# 	]], [[
# 		This is the only time I’ve seen KDE fail in terms of configurability.
# 	]], [[
# 		On a related note, Nextcloud also has this problem. Setting Nextcloud’s locale to <code>en_SE</code> works, but causes
# 		relative time (e.g. “a day ago”) to be shown in Swedish.
# 	]]),
# 	Issue(39, "The GRUB boot menu is occasionally skipped when restarting", true, { FEDORA_KDE }, [[
# 		Oftentimes, when rebooting my PC, the GRUB menu doesn’t come up at all despite the fact that I’ve explicitly enabled it
# 		and gave it a long timeout in <code>/etc/default/grub</code>. This issue frustrated me quite a lot since I wasn’t able to
# 		consistently reproduce it; sometimes the menu would be skipped (especially after using the PC for a while) and other times
# 		it wouldn’t.
# 	]], [[
# 		After some digging around in the generated GRUB config file, I found out that this is the result of Fedora making
# 		<a href="https://fedoraproject.org/wiki/Changes/HiddenGrubMenu">this change</a>; for single-boot systems (GRUB thinks my
# 		system is single-boot; see <a href="#38">#38</a>), the GRUB menu is automatically skipped after a "successful boot",
# 		which, according to <a href="https://hansdegoede.livejournal.com/19081.html">this FAQ</a>, is defined as a boot lasting
# 		more than 2 minutes.
# 	]], [[
# 		The solution (i.e. disabling this feature) is given by <a href="https://discussion.fedoraproject.org/t/unset-menu-auto-hide-is-how-to-force-grub2-boot-menu-visibility-on-every-boot-for-kernel-parameters/76631/2">
# 		this answer</a>: <code>sudo grub2-editenv - unset menu_auto_hide</code>. I just wish it was better documented.
# 	]]),
# 	Issue(40, "Can’t limit the max battery charge level", true, { FEDORA_KDE }, [[
# 		Under Windows, max battery charge levels are often controlled by proprietary apps that aren’t available on Linux.
# 		With some battery models, KDE allows limiting the charge level in ‘Power Management > Advanced Power Settings’.
# 		However, for others, you’ll have to resort to less official methods such as a <a href="https://github.com/frederik-h/acer-wmi-battery">custom driver</a>.
# 	]], [[
# 		For my Acer Nitro 5, I was able to get the limit working with <a href="https://github.com/Diman119/acer-wmi-battery/tree/dkms">this repo</a>
# 		(pointed to by <a href="https://www.brenobaptista.com/posts/battery-charging-threshold-acer-linux">this blog</a>). Then,
# 		to get nicer control and proper persistence across reboots, I:
# 	]], {
# 		"Created a file named <code>/etc/acer-wmi-battery</code>.",
# 		"Created a simple oneshot systemd service that runs on boot and copies the contents of the above file to the device file.",
# 		"Wrote a custom <code>healthmode</code> shell function that writes to the above file and then manually runs the systemd service."
# 	}),
# }


# local function makeParagragh(val)
# 	-- List
# 	if type(val) == "table" then
		<ul class="mt-3 text-sm pl-10 list-disc">
# 		for _, item in ipairs(val) do
			<li>$(item)</li>
# 		end
		</ul>

# 	-- Code block
# 	elseif val:find("^<pre") then
		$(val)

# 	-- Ordinary paragraph
# 	else
		<p class="mt-3 mx-0 mb-0 text-sm">$(val)</p>
# 	end
# end


# local buff = {}
# local seen, numSeen = {}, 0

	<ul class="list-none text-gray-300">
# 	for _, issue in ipairs(issues) do
# 		local status = issue.resolved and "RESOLVED" or "ONGOING"
# 		local statusColor = issue.resolved and "accent-blue" or "accent-red"
# 		local statusTitle = issue.resolved
# 			and "This issue has been fixed or a workaround exists"
# 			or "This issue is still occuring"
#
# 		-- Verify we don't have duplicate numbers
# 		if seen[issue.number] then
# 			error("issue with duplicate number: " .. issue.number, 0)
# 		end
# 		seen[issue.number] = true
# 		numSeen = numSeen + 1

		<li id="$(issue.number)" class="py-3 px-4 mb-3 bg-gray-700 target:bg-gray-600 text-gray-300 rounded-md"
			title="Click for details">
			<details class="overflow-hidden">
				<summary>
					<span class="float-right ml-3 text-xs md:text-sm">
						<span class="text-$(statusColor)" title="$(statusTitle)">$(status)</span>
						|
						<a href="#$(issue.number)" class="text-gray-300 no-underline inline-block min-w-6 md:min-w-8 text-center"
							title="Click to copy link">#$(issue.number)</a>
					</span>
					$(issue.title)
				</summary>
				<ul class="text-sm md:ml-6 mt-1 mb-4">$(table.concat(issue.systems, " "))</ul>

# 				for _, paragraph in ipairs(issue.paragraphs) do
# 					makeParagragh(paragraph)
# 				end
			</details>
		</li>
# 	end
#
# 	-- Check that we haven't skipped any numbers
# 	for num = 1, numSeen do
# 		if not seen[num] then
# 			error("no issue with number: " .. num, 0)
# 		end
# 	end
	</ul>
	</main>

	<script>
		// Open the details of the current target. This script is too small and doesn't have enough re-use potential to justify
		// putting it into a separate file.
		// https://stackoverflow.com/a/37033774
		function openTarget() {
			let hash = location.hash.substring(1);
			if (!hash) { return }

			let details = document.getElementById(hash)?.getElementsByTagName("details")[0]
			if (details) {
				details.open = true
			}
		}
		window.addEventListener("hashchange", openTarget);
		window.addEventListener("load", openTarget);
		openTarget();
	</script>
</body>
</html>
