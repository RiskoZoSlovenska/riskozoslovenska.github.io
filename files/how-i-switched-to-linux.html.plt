<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	$(head{ name = "How I Switched To Linux", desc = "Epic story." })
	<script src="./assets/scripts/code-blocks.js" type="module"></script>
</head>

<body>
	<div id="sidebar-insert"></div>

	<main class="article-main">
		<h1>How I Switched To Linux</h1>
		<figure class="mx-auto md:m-0 md:ml-5 md:float-right">
			<img src="./assets/images/ntfs.png" width="364" height="149" alt="Screenshot of six files with the same name on Windows 7">
			<figcaption>
				I stumbled upon this while clearing out my old Win 7 laptop. And yes, those are all unique and in the same folder.
			</figcaption>
		</figure>
		<p>
			I’ve grown up on Windows 7 and 10, and for the most part, I’ve had no issues with them. However, recently
			I’ve been lucky enough to be in a community where Linux was practically everyone’s daily driver, and it sort
			of began to rub off on me. At some point, I got bored of Windows and finally decided that I should try
			Linux. And so I did.
		</p>
		<p>
			I spent a few days trying out different distributions. I wanted something practical: something less
			spoonfeed-y than Windows, but nothing that would be a nightmare to get into or troubleshoot. My trial
			process was neither systematic nor robust — I tried out only a small handful of distributions, and judged
			mostly by first impressions — but in the end, two of them caught my eye: <a href="https://getsol.us/">Solus</a>
			and <a href="https://zorin.com/os/">Zorin</a>. In the end, I decided to go for Zorin, mostly because it’s
			Ubuntu-based and therefore there’s an abundance of both apps and support for it.
		</p>
		<figure class="horizontal-centered">
			<img src="./assets/images/zorin.png" width="1366" height="768" alt="Screenshot of the Zorin OS 16 desktop">
			<figcaption>Random but authentic screenshot I took while triaging Zorin.</figcaption>
		</figure>
		<p>
			It took me a moment to appreciate GNOME. After spending a few days trying and failing to theme it to look
			like Windows 10 (I really liked sharp corners), I gave up and just rolled with it. It didn't take all that
			long for me to warm up to it. The filesystem structure was a bit new to me, but it wasn’t anything that a
			little bit of learning couldn't remedy. I found a new workflow in a matter of days. Zorin still has a few
			annoyances which simply aren’t present on Windows (see below), but also has its own benefits, which are too
			numerous to list here and have already been documented thoroughly elsewhere on the internet.
		</p>
		<p>
			The switch was far from painless, however. I hit countless issues and roadblocks, some of which I’ve
			resolved only thanks to the help of some friends. Following is a list of all the problems I’ve encountered,
			past and present, as well as all the solutions I’ve attempted. This list may seem dauntingly long, but it
			was — and still is — completely worth it.
		</p>
# 		local function Issue(id, desc, steps)
# 			return {
# 				id = id,
# 				desc = desc,
# 				steps = steps,
# 			}
# 		end
# 
# 		local unresolvedIssues = {
# 			Issue("black-screen-on-wakeup", [[
# 				My laptop screen occassionally remains off after waking up from sleep. I'm pretty sure something
# 				about how it's put to sleep triggers it, but I haven't been able to figure out what exactly.
# 			]], {
# 				'Possibly caused by <a href="https://bugs.launchpad.net/ubuntu/+source/xubuntu-default-settings/+bug/1303736">this bug</a>.',
# 				'I’m currently using <a href="https://bugs.launchpad.net/ubuntu/+source/xubuntu-default-settings/+bug/1303736/comments/11">this</a> workaround.',
# 				'Sometimes, just closing and re-opening the lid works',
# 			}),
# 
# 			Issue("discord-badge", "Discord doesn’t display the notifications badge on the taskbar icon.",
# 			{
# 				'Looks like an <a href="https://github.com/flathub/com.discordapp.Discord/issues/228">issue with Discord</a>.',
# 			}),
# 
# 			Issue("spotify-exit-on-close", '<a href="https://community.spotify.com/t5/Desktop-Linux/Cannot-minimize-to-tray-on-Linux/td-p/1703131">Spotify exits if it’s closed (instead of sitting in the icon area)</a>.',
# 			{
# 				'<a href="https://www.addictivetips.com/ubuntu-linux-tips/spotify-system-tray-linux/">Article with meh solutions</a>.',
# 				'<a href="https://www.maketecheasier.com/minimize-spotify-to-system-tray-linux/">Another one</a>.',
# 				[[I moved Spotify into another workspace, where it’s both accessible and completely out of my way,
# 				thus eliminating the need for minimizing it to the tray.]],
# 			}),
# 
# 			Issue("spotify-links", [[
# 				Spotify cannot open links in the app. Clicking on a Spotify link launches a new broken instance
# 				instead of redirecting the existing one.
# 			]], {
# 				'Install <a href="https://gist.github.com/wandernauta/6800547">sp</a>.',
# 				'Create a custom Spotify launcher similar to <a href="https://technex.us/2022/05/how-to-make-a-launcher-for-spotify-in-linux-that-works-with-spotify-links/">this one</a>.',
# 				'Edit your Spotify’s <code>.desktop</code> file to use the custom launcher.',
# 				[[
# 					To disable Spotify links opening in the browser, install an extension, such as 
# 					<a href="https://github.com/relisher/spotify-desktop-ify">this one</a>. However, I can't get
# 					Firefox to automatically close the tab that clicking on a link opens, meaning I still have to
# 					interact with the browser when opening Spotify links.
# 				]]
# 			}),
# 
# 			Issue("image-borders", '<a href="https://ubuntugenius.wordpress.com/2011/10/14/how-to-change-white-border-around-image-video-thumbnails-to-drop-shadow-in-ubuntus-file-manager-nautilus/">Image thumbnails have ugly white borders in Nautilus</a>.',
# 			{
# 				'The solution mentioned above doesn’t really work, might have to <a href="https://answers.launchpad.net/cover-thumbnailer/+question/186685">recompile Nautilus</a>.',
# 				'As I’m too lazy/don’t care enough to go ahead and recompile stuff, I just got used to it. It’s not that bad.',
# 			}),
# 
# 			Issue("recents-tab", [[
# 				<ol class="linux-issue-desc">
# 					<li><a href="https://askubuntu.com/questions/1240286/how-to-show-folders-on-nautilus-recent-list">The ‘Recent’ tab in Nautilus doesn’t show folders</a>.</li>
# 					<li>The ‘Recent’ tab in Nautilus doesn’t show up in the ‘Save As’ dialog.</li>
# 				</ol>
# 			]], {
# 				'No other file explorers play as nicely with (non-Lite) Zorin, so those aren’t an option.',
# 				[[
# 					Despite having used the "Recent Places" (or whatever it was called) feature extensively in
# 					Windows 7, I’ve mostly gotten used to not having it.
# 				]],
# 			}),
# 
# 			Issue("folder-previews", '<a href="https://askubuntu.com/questions/992947/how-to-preview-images-in-folders-icons">Folders don’t preview their contents in their icon</a>.',
# 			{
# 				[[
# 					<a href="https://github.com/flozz/cover-thumbnailer">flozz/cover-thumbnailer</a>.
# 					Apparently not the best (can’t say for sure as I haven’t used it), especially for Nautilus, but
# 					it could work for some people.
# 				]],
# 				'I personally have gotten used to no previews.',
# 			}),
# 		}
#
# 		local resolvedIssues = {
# 			Issue("colors-are-wrong", [[
# 				Colors are somehow… wrong. Too much contrast or something.
# 				For example, my signature red, <span style="color: #ff3232">#FF3232</span>,
# 				gets rendered as <span style="color: #ff093a">#FF093A</span>.
# 			]], {
# 				[[
# 					Possibly related
# 					<a href="https://www.reddit.com/r/linuxquestions/comments/i2mkms/why_do_colours_look_wrong_in_linux_compared_to/">Reddit post</a>
# 					and <a href="https://gitlab.freedesktop.org/drm/amd/-/issues/476">issue</a>.
# 				]],
# 				'Tried fiddling around with monitor settings, to no avail.',
# 				'Tried switching monitors — no difference.',
# 				'Tried switching GPUs — no difference.',
# 				'I recall a Fedora LiveCD didn’t have this issue. Could something be messed up with my installation?',
# 				[[
# 					Some faint memory tells me that I had this issue on Windows 10 too and fixed it via	some Radeon
# 					(I had an AMD card at that time) setting about color formats or something. Changing a similar
# 					setting under NVIDIA’s control panel had no effect.
# 				]],
# 				[[
# 					Tweaked some NVIDIA settings, mainly the gamma setting, and while the colors still aren’t
# 					perfectly correct, they’re close enough for me to not be bothered by it.
# 				]],
# 				'Perhaps it’s all just a matter of viewing angle and I just need a taller monitor stand?',
# 				[[
# 					This took me a while to figure out, and it had nothing to do with the monitor or the GPU. First,
# 					I narrowed the issue down to only Electron apps, like VS Code and Discord. Then, I found out
# 					that Zorin (or Ubuntu?) has this setting called ‘Device Color Profiles’, and my monitor had some
# 					default profile applied. I just removed it and colors started being correct.
# 				]],
# 			}),
# 
# 			Issue("laptop-bluetooth", 'Bluetooth doesn’t work on my laptop.',
# 			{
# 				'<a href="https://fosspost.org/fix-bluetooth-rtl8761b-problem-on-linux-ubuntu-22-04/">Force Linux to use the correct firmware</a>.',
# 			}),
# 
# 			Issue("wake-on-suspend", '<a href="https://www.reddit.com/r/gigabyte/comments/mxqvja/b550i_aorus_pro_ax_f13h_instantly_wakes_from_sleep/">PC wakes up immediately after being put into suspend</a>.',
# 			{
# 				'<a href="https://www.reddit.com/r/gigabyte/comments/p5ewjn/b550i_pro_ax_f13_bios_sleep_issue_on_linux/">“Disable GPP0 wakeup”</a> (I don’t actually know what that means, but it works).',
# 			}),
# 
# 			Issue("no-wifi-adapter", 'WiFi adapter isn’t being detected.',
# 			{
# 				'<a href="https://forum.zorin.com/t/wifi-is-not-showing-no-wifi-adapter-found-error-in-zorin/428/12">Possibly related post</a>.',
# 				'Started working when I swapped out my ancient GPU for a newer one. Perhaps it was some sort of bizarre hardware conflict?',
# 			}),
# 
# 			Issue("audio-breaks", 'Audio occasionally breaks (turns into static).',
# 			{
# 				table.concat({
# 					'Restarting PulseAudio fixes this. However, when PulseAudio is restarted, some apps (Spotify',
# 					'in my case) need to be restarted as well. I made a quick Bash function for this:',
# 					'<pre class="has-code"><code class="language-bash"># Audio breaks sometimes and resetting PulseAudio seems to fix it.',
# 					'# Spotify also needs a restart to work after PulseAudio is restarted.',
#					'function restartpulse() {',
#					'	pulseaudio --kill',
#					'	pkill -x spotify',
#					'	nohup spotify > /dev/null 2>&1 &',
#					'	disown $!',
#					'}</code></pre>',
# 				}, "\n"),
# 				'At some point, this stopped happening.',
# 			}),
# 
# 			Issue("obs-nvenc-breaks",  [[
# 				<a href="https://bbs.archlinux.org/viewtopic.php?id=272472">OBS NVENC breaks if the</a>
# 				<a href="https://www.reddit.com/r/linux_gaming/comments/uul5ns/obs_error_failed_to_open_nvenc_codec_after_pc/">PC suspends while OBS is open</a>.
# 			]], {
# 				'<code>pkill -x obs</code> <a href="https://blog.christophersmart.com/2016/05/11/running-scripts-before-and-after-suspend-with-systemd/">before every suspend</a>.',
# 			}),
# 
# 			Issue("sunshine-nvenc-breaks",  [[
# 				When using <a href="https://github.com/LizardByte/Sunshine">Sunshine</a> to stream, if the computer
# 				goes to sleep while streaming, Sunshine will fail to use NVENC upon waking up. This problem is most
# 				likely related to the <a href="#obs-nvenc-breaks">aforementioned issue with OBS</a>.
# 			]], {
# 				'I wasn’t able to get Sunshine to stop after a suspend and then start up again.',
# 				[[
# 					<a href="https://askubuntu.com/a/1309807">This fix</a> resolved the issue. Note that step 3 was
# 					already done, perhaps thanks to Zorin?
# 				]],
# 			}),
# 
# 			Issue("flatpak-cursor-theme",  'Flatpaks don’t use the system cursor theme.',
# 			{
# 				'<a href="https://github.com/flatpak/flatpak/issues/709#issuecomment-741883444">Grant Flatpaks permissions to access cursors</a>.',
# 			}),
# 
# 			Issue("disk-mount",  'Secondary disk is mounted in <code>/media</code> and has an unmount button.',
# 			{
# 				'Set the mount point to <code>~/data1</code>.',
# 				'Apparently the mount button can be hidden from the Disks app, but that also hides the disk itself.',
# 				[[
# 					“Fixed” this by disabling the little ‘Removable Drives’ menu in the taskbar. Ejecting from
# 					Nautilus is convenient enough for me to have practically never used that menu.
# 				]],
# 			}),
# 
# 			Issue("lock-screen-buttons",  'No Power Off/Restart buttons on the lock screen (only Suspend).',
# 			{
# 				[[
# 					This is Linux’s stricter equivalent of Windows’ “other users may lose unsaved work” prompt and
# 					is actually probably for the better. Either way, it can’t really be “fixed”.
# 				]],
# 			}),
# 
# 			Issue("login-mouse-speed",  [[
# 				Mouse sensitivity is inconsistent between the lockscreen and the actual desktop. IIRC this happens
# 				only after boot and before the first login.
# 			]], {
# 				'The login screen is ran under a different user and thus has different settings.',
# 				'<a href="https://www.reddit.com/r/gnome/comments/qvcxpt/is_there_a_way_to_change_the_mouse_sensitivity_in/">Modify the GDM user’s setting</a>.',
# 				'Additionally, to change things such as the GDM background, see <a href="https://www.linuxuprising.com/2021/05/how-to-change-gdm3-login-screen-greeter.html">this</a> article.',
# 			}),
# 
# 			Issue("notification-position",  'Desktop notifications show up top centre instead of bottom right.',
# 			{
# 				[[
# 					<a href="https://ubuntuhandbook.org/index.php/2018/05/change-notification-position-ubuntu-18-04/">Install</a>
# 					the <a href="https://extensions.gnome.org/extension/708/panel-osd/">Panel OSD extension</a>.
# 				]],
# 			}),
# 
# 			Issue("no-webp",  'Can’t open WebP images.',
# 			{
# 				'<a href="https://askubuntu.com/a/1346951">Install aruiz/webp-pixbuf-loader</a>.',
# 			}),
# 
# 			Issue("no-sound-chooser",  'Can’t change the audio output device from the taskbar.',
# 			{
# 				'Install the <a href="https://extensions.gnome.org/extension/906/sound-output-device-chooser/">Sound Input & Output Device Chooser</a> extension.',
# 			}),
# 
# 			Issue("no-open-in-code",  'No “Open In Code” context action in Nautilus/Thunar.',
# 			{
# 				'Nautilus: <a href="https://github.com/harry-cpp/code-nautilus">Install an extension</a>.',
# 				'Thunar: <a href="https://docs.xfce.org/xfce/thunar/custom-actions">Add a custom action</a>.',
# 			}),
# 
# 			Issue("no-code-workspace",  'VS Code doesn’t understand <code>.code-workspace</code> files.',
# 			{
# 				'<a href="https://unix.stackexchange.com/a/564888">Register a custom MIME type</a>.',
# 			}),
# 
# 			Issue("ugly-chromium",  'The context menu in Chromium doesn’t respect the theme (and Chromium looks terrible in general).',
# 			{
# 				'Switch to Firefox (which is better anyway).',
# 			}),
# 
# 			Issue("ugly-topbars",  'Discord and VS Code topbars are ugly.',
# 			{
# 				'Change the <code>window.titleBarStyle</code> setting in VS Code.',
# 				'Unfortunately, Discord doesn’t have such a setting. However, I’ve gotten completely used to it anyway.',
# 			}),
# 
# 			Issue("no-auto-open",  'Discord/Spotify/etc. doesn’t automatically open after booting.',
# 			{
# 				'Tweak the "Startup Applications" system setting.',
# 			}),
# 
# 			Issue("spotify-download-path",  'Spotify doesn’t let me specify the offline download location.',
# 			{
# 				[[
# 					This fixed itself somehow and I’m not sure how. Probably was an issue only with a specific
# 					packaging of Spotify that I switched away from.
# 				]],
# 			}),
# 
# 			Issue("spotify-volume-not-saving",  'Spotify doesn’t save volume.',
# 			{
# 				'Fixed itself at some point.',
# 			}),
# 
# 			Issue("thunar-no-file-sizes",  [[
# 				Thunar doesn’t display the size of the currently selected files/folders in the bottom right corner
# 				like other file managers do.
# 			]], {
# 				'<a href="https://forum.zorin.com/t/can-thunar-show-file-count-for-folders/3443">Enable the statusbar</a>.',
# 			}),
# 
# 			Issue("no-copy-file-path",  'No “copy file path” context option in Nautilus.',
# 			{
# 				'<a href="https://askubuntu.com/a/225676">The clipboard is context-sensitive</a>; no fix is required.',
# 			}),
# 
# 			Issue("no-hwinfo",  'No <a href="https://www.hwinfo.com/">HWInfo</a>.',
# 			{
# 				[[
# 					The functionality I wanted was filled in by extensions, <a href="https://extensions.gnome.org/extension/120/system-monitor/">some of which</a>
# 					were built-in and <a href="https://extensions.gnome.org/extension/841/freon/">some of which</a> I needed to install. The end result is even
# 					better than what I had originally wanted.
# 				]],
# 			}),
# 
# 			Issue("no-g-hub",  'No <a href="https://www.logitechg.com/en-us/innovation/g-hub.html">Logitech G Hub</a>.',
# 			{
# 				'<a href="https://www.reddit.com/r/LogitechG/comments/gmuogw/logitech_g_hub_for_linux/">Probably isn’t coming any time soon</a>,',
# 				'…but there are some <a href="https://github.com/libratbag/piper">open source alternatives</a>,',
# 				'…but I don’t really need it anymore.',
# 			}),
# 
# 			Issue("kdenlive-blurry-rendering",  [[
# 				Rendering a project in <a href="https://kdenlive.org/en/">Kdenlive</a> produces blurry output (even
# 				when rendering to a lossless format).
# 			]], {
# 				[[
# 					See <a href="https://forum.kde.org/viewtopic.php?f=272&t=120227">this post</a> and use
# 					desired/up-to-date values. For me, those were <code>pix_fmt=yuv444p</code> and
# 					<code>mlt_image_format=rgb</code> (not <code>rgb24</code>, that's probably old — see the
# 					<a href="https://www.mltframework.org/plugins/ProducerColor/#mlt_image_format">MLT docs</a>).
# 				]],
# 			}),
# 		}
# 
# 		local buff = {}
# 
		<ul class="list-['→_'] pl-5 md:pl-10 text-gray-300">
# 			for _, issue in ipairs(unresolvedIssues) do
			<li class="my-10 marker:italic marker:font-bold" id="$(issue.id)">
				<div class="italic font-bold underline mb-1">
					<a class="text-inherit-color hofoac:text-inherit-color" href="#$(issue.id)">Ongoing:</a>
				</div>
				<p class="mb-3 leading-none">$(issue.desc)</p>
				<div class="italic font-bold underline">Notes/Things Tried:</div>
				<ul class="list-disc pl-8">
# 					for _, step in ipairs(issue.steps) do
					<li class="my-1">$(step)</li>
# 					end					
				</ul>
			</li>
# 			end
# 
# 
# 			for _, issue in ipairs(resolvedIssues) do
			<li class="my-10 marker:italic marker:font-bold brightness-[65%]" id="$(issue.id)">
				<div class="italic font-bold underline mb-1">
					<a class="text-inherit-color hofoac:text-inherit-color" href="#$(issue.id)">Resolved:</a>
				</div>
				<p class="mb-3 leading-none">$(issue.desc)</p>
				<div class="italic text-sm font-bold underline">Notes/Steps Taken:</div>
				<ul class="list-disc pl-8">
# 					for _, step in ipairs(issue.steps) do
					<li class="my-1">$(step)</li>
# 					end					
				</ul>
			</li>
# 			end
		</ul>
	</main>
</body>
</html>
