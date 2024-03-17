<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "How I Switched to Linux", desc = "A short re-telling of my adventure and a record of overcome challenges." })
	<script src="./assets/scripts/code-blocks.js" type="module"></script>
</head>

<body>
	<div id="sidebar-insert"></div>

	<main class="article-main">
		<h1>How I Switched to Linux</h1>
		<figure class="mx-auto md:m-0 md:ml-5 md:float-right">
			<img src="./assets/images/ntfs.png" width="364" height="149" alt="Screenshot of six files with the same name on Windows 7">
			<figcaption>
				I stumbled upon this while clearing out my old Win 7 laptop. And yes, those are all unique and in the same folder.
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
			the glacial pace at which it moved became more and more apparent as time moved on. Zorin is built upon Ubuntu LTS,
			meaning that it only gets a new release when a new LTS comes out: once every two years. That’s an abysmally long time,
			especially in the world of software. Zorin’s tendency to be constantly behind began to be irritating, and so I started
			looking for something new.
		</p>
		<p>
			Shortly before I started considering switching distros, a friend of mine took the plunge and swapped out Windows 10
			for <a href="https://fedoraproject.org/workstation/">Fedora Workstation</a>. Furthermore,
			<a href="https://fedoraproject.org/">Fedora</a> cropped up often in online discussions and was ultimately recommended
			to me by another friend. Needless to say, it caught my attention. After a bit of research, I decided that it was
			exactly what I was looking for: it was up-to-date, widely-supported and still user-friendly. I also considered
			<a href="https://archlinux.org/">Arch</a>, <a href="https://endeavouros.com/">EndeavourOS</a> or Solus, but I didn’t
			want to make anything more difficult than it needed to be nor did I want to risk things with rolling releases. In
			short, Fedora was a perfect match.
		</p>
		<p>
			Next, I needed to pick a desktop environment. GNOME was an obvious candidate, but
			<a href="https://kde.org/plasma-desktop/">KDE</a> caught my eye thanks to its reputation as being heavily
			configurable, pretty and lightweight. I also wanted to try out <a href="https://fedoraproject.org/spins/cinnamon/">
			Cinnamon</a>, but the moment I booted up a Fedora KDE LiveCD, I knew that this was the one. KDE greeted me with the
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
			Zorin did for me (or let me do with a single click). I also set X11 as the default window system since I didn’t want
			to deal with yet another thing that could make stuff break. Just like on Zorin, a few residual issues remain, but
			otherwise, the process went very smoothly.
		</p>
		<p>
			There were some hiccups, but despite that, Linux, Fedora, KDE and the things around them are phenomenal pieces of
			software; ditching Windows is probably one of the best decisions I’ve ever made. It’s been and continues to be a wild
			ride that never fails to teach me something new. If you, dear reader, are on Windows and are getting bored of it, why
			not try something new? Linux won’t disappoint.
		</p>
		<hr>
		<p>
			Here follows a list of Windows-specific software I have (or haven’t) found Linux alternatives to, in case someone
			might find it useful.
		</p>
		<ul class="list-disc pl-8 mb-5">
# 		for _, item in ipairs({
# 			{ "Paint.NET", "https://www.getpaint.net/", [[
# 				Replaced by GIMP. I only do minor edits/make memes so GIMP is a bit overkill, but it gets the job done if I do a
# 				bit of Googling.
# 			]] },
# 			{ "Logitech G-Hub", "https://www.logitechg.com/en-us/innovation/g-hub.html", [[
# 				It <a href="https://www.reddit.com/r/LogitechG/comments/gmuogw/logitech_g_hub_for_linux/">doesn’t look to be
# 				coming anytime soon</a>, but there are some <a href="https://github.com/libratbag/piper">open-source
# 				alternatives</a>. Personally, I just use the on-board profile on my mouse and plug it into a Windows machine
# 				whenever I need to change anything (which is once in a blue moon anyway).
# 			]] },
# 			{ "ScreenToGif", "https://www.screentogif.com/", [[
# 				No alternative found. As of this writing, <a href="https://github.com/phw/peek">Peek</a> is discontinued and
# 				<a href="https://github.com/SeaDve/Kooha">Kooha</a> doesn’t work (at least not KDE).
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
			You may notice that this list is fairly long and includes a non-negligible amount of items marked as "ongoing".
			However, do not take this as an indication that the Linux experience is janky; the positives far outweigh any
			drawbacks.
		</p>

# local ZORIN_LITE = '<span class="py-0.5 px-1 rounded text-2xs text-gray-100 bg-[#15a6f0]">Zorin 16 Lite</span>'
# local ZORIN_CORE = '<span class="py-0.5 px-1 rounded text-2xs text-gray-100 bg-[#15a6f0]">Zorin 16 Core</span>'
# local FEDORA_KDE = '<span class="py-0.5 px-1 rounded text-2xs text-gray-100 bg-[#3c6eb4]">Fedora/KDE</span>'
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
# local issues = {
# 	Issue(8, "(Some) Flatpaks don’t use the system cursor theme", false, ALL, [[
# 		This is caused by the Flatpaks not having the permissions to read the cursor files. The fix should be simple: just
# 		<a href="https://github.com/flatpak/flatpak/issues/709#issuecomment-741883444">grant Flatpaks the permissions to access
# 		cursors</a>. However, certain Flatpaks, such as Discord or the Minecraft launcher, still fail to work on Fedora/KDE (at
# 		least). I’m going to guess that it has something to do with these apps mainly being designed for Ubuntu and related
# 		distros.
# 	]]),
# 	Issue(20,  "Spotify doesn’t let me specify the offline download location.", false, ALL, [[
# 		I’m pretty sure the Flatpak version of Spotify has a bit of trouble with this. At some point I got it working, but I don’t
# 		remember which packaging I was using. Nowadays, I just use the default download location.
# 	]]),
# 	Issue(17, "Discord doesn’t display the notifications badge on the taskbar icon", false, ALL, [[
# 		Looks like an <a href="https://github.com/flathub/com.discordapp.Discord/issues/228">issue with Discord</a>.
# 	]]),
# 	Issue(24, "The ‘Recent’ tab in the file explorer is sub-par", false, ALL, [[
# 		By sub-par I mean that it <a href="https://askubuntu.com/questions/1240286/how-to-show-folders-on-nautilus-recent-list">1)
# 		doesn’t show folders and 2) doesn’t show up in the ‘Save File’ dialog</a>.
# 	]], [[
# 		1) is less of an issue on Fedora as Dolphin has both a ‘Recent Files’ and a ‘Recent Locations’ tabs. However, the
# 		folders in this tab seem to be sorted solely by when and not by how frequently they were accessed, which limits
# 		its convenience. 2) remains unresolved. Nevertheless, I have mostly become accustomed to this one particular
# 		limitation.
# 	]]),
# 	Issue(30, "Pressing the power button while the PC is locked doesn’t put it to sleep", false, { FEDORA_KDE }, [[
# 		This bug has been reported <a href="https://bugs.kde.org/show_bug.cgi?id=392798">here</a>.
# 	]]),
# 	Issue(31, "The screen doesn’t turn off after locking", false, { FEDORA_KDE }, [[
# 		This bug has been reported <a href="https://bugs.kde.org/show_bug.cgi?id=348529">here</a> and appears to be actively being
# 		worked on as of this writing. There are also workarounds involving scripts but I honestly can’t be bothered.
# 	]]),
# 	Issue(32, "WINE applications have crackle-y audio", false, { FEDORA_KDE }, [[
# 		This bug has been reported as <a href="https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3098">
# 		pipewire/pipewire#3098</a>. I’m currently using the workaround described
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
# 		Note that I’m using <code>512</code> instead of <code>256</code> as the latter still caused issues. Also, remember to
# 		<code>systemctl --user restart pipewire pipewire-pulse</code> to apply changes (or just restart the entire PC).
# 	]]),
# 	Issue(34,
# 		"Launching certain applications (e.g. NVIDIA X Server Settings, certain WINE ones) turns off the blue light filter",
# 		false, ALL, [[
# 		This seems to have been reported <a href="https://bugs.launchpad.net/ubuntu/+source/gnome-shell/+bug/1728342">here</a>.
# 		Strangely, that bug report was filed against Ubuntu, which uses GNOME, not KDE. Nevertheless, the symptoms appear
# 		identical to what I’m experiencing and the problem is probably caused by the same underlying issue in both cases.
# 	]]),
# 	Issue(37, "The icons of certain apps have black backgrounds/are rendered wrong", false, { FEDORA_KDE }, [[
# 		This has been reported <a href="https://bugs.kde.org/show_bug.cgi?id=448234">here</a>.
# 	]]),
# 	Issue(36, "Can’t fine-tune the time and date format in KDE", true, { FEDORA_KDE }, [[
# 		KDE uses the current locale to determine the date and time format and I wasn’t able to manually set it to ISO 8601.
# 		Thankfully, this has been asked about and answered <a href="https://superuser.com/questions/1162283/use-iso-time-and-date-format-in-kde-5">
# 		here</a> — the solution is to set the locale to <code>en_SE</code>.
# 	]], [[
# 		This is the only time I’ve seen KDE fail in terms of configurability.
# 	]], [[
# 		On a related note, Nextcloud also has this problem. Setting Nextcloud’s locale to <code>en_SE</code> works, but causes
# 		relative time to be shown in Swedish.
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
# 	Issue(33, "Discord doesn’t stream audio when screen-sharing", true, ALL, [[
# 		This is a
# 		<a href="https://www.reddit.com/r/linux_gaming/comments/15i9wka/whats_the_best_solution_to_discord_screenshare/">rather
# 		well-known limitation</a> of the official Discord client on Linux, and is mostly Discord’s fault. The solution is to use
# 		one of the many <a href="https://github.com/maltejur/discord-screenaudio">alternate</a>
# 		<a href="https://github.com/Vencord/Vesktop">clients</a> or to use
# 		<a href="https://github.com/IceDBorn/pipewire-screenaudio">this Firefox extension</a>, open Discord in the browser and
# 		stream from there.
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
#<pre class="has-code"><code class="language-bash"># Audio breaks sometimes and resetting PulseAudio seems to fix it.
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
#<pre class="has-code"><code class="language-xml">&lt;?xml version=&quot;1.0&quot;?&gt;
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
				<div class="text-sm md:ml-6 mt-1 mb-4">$(table.concat(issue.systems, " "))</div>

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
