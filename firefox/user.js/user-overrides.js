// ============================================================================
// Settings
// ============================================================================
user_pref("extensions.pocket.enabled", false);
user_pref("browser.preferences.moreFromMozilla", false);
user_pref("identity.fxaccounts.enabled", false);
user_pref("extensions.update.enabled", false);
user_pref("browser.tabs.closeWindowWithLastTab", false);

user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

user_pref("svg.context-properties.content.enabled", true);

user_pref("network.proxy.socks", "127.0.0.1");
user_pref("network.proxy.socks_port", 1080);
user_pref("network.proxy.type", 1);

// ============================================================================
// Arkenfox Overrides
// ============================================================================
// * 0401 - 0402
user_pref("browser.safebrowsing.malware.enabled", true);
user_pref("browser.safebrowsing.phishing.enabled", true);
user_pref("browser.safebrowsing.downloads.enabled", false);
// * 0602
user_pref("network.dns.disablePrefetch", false);
user_pref("network.dns.disablePrefetchFromHTTPS", false);
//* 0705 - 0706
user_pref("network.proxy.failover_direct", false);
user_pref("network.proxy.allow_bypass", false);
//* 0710 - 0712
user_pref("network.trr.mode", 3);
user_pref("network.trr.uri", "https://223.5.5.5/dns-query");
user_pref("network.trr.custom_uri", "https://223.5.5.5/dns-query");
//* 0807 - 0815
user_pref("browser.urlbar.clipboard.featureGate", false);
user_pref("browser.urlbar.recentsearches.featureGate", false);
user_pref("browser.urlbar.suggest.engines", false);
//* 0820
user_pref("layout.css.visited_links_enabled", false);
//* 0830
user_pref("browser.search.separatePrivateDefault", false);
user_pref("browser.search.separatePrivateDefault.ui.enabled", false);
//* 0906
user_pref("network.http.windows-sso.enabled", false);
//* 1001
user_pref("browser.cache.disk.enable", true);
//* 1002
user_pref("browser.privatebrowsing.forceMediaMemoryCache", false);
//* 1006
user_pref("browser.shell.shortcutFavicons", true);
//* 1223 DEBUG MITM
user_pref("security.cert_pinning.enforcement_level", 2);
//* 1244
user_pref("dom.security.https_only_mode_pbm", true);
//* 2615
user_pref("permissions.default.shortcuts", 2);
//* 2651
user_pref("browser.download.useDownloadDir", true);
//* 2660
user_pref("extensions.enabledScopes", 1);
////* 2811
user_pref("privacy.clearOnShutdown.siteSettings", true);
user_pref("privacy.clearOnShutdown_v2.siteSettings", true);
//* 4001
user_pref("privacy.fingerprintingProtection.pbmode", true);
//* 4501
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.resistFingerprinting.pbmode", true);
//* 4504
// user_pref("privacy.resistFingerprinting.letterboxing", true);
//* 4505
// user_pref("privacy.resistFingerprinting.exemptedDomains", "*.example.invalid");
//* 4520
user_pref("webgl.disabled", true);
//* 5001
// user_pref("browser.privatebrowsing.autostart", true);
//* 5002
user_pref("browser.cache.memory.enable", false);
user_pref("browser.cache.memory.capacity", 0);
//* 5003
user_pref("signon.rememberSignons", false);
//* 5004 - 5005
user_pref("permissions.memory_only", true);
user_pref("security.nocertdb", true);
//* 5007 - 5008
user_pref("browser.sessionstore.max_tabs_undo", 0);
user_pref("browser.sessionstore.resume_from_crash", false);
//* 5009
user_pref("browser.download.forbid_open_with", true);
//* 5010 - 5011
user_pref("browser.urlbar.suggest.history", true);
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.openpage", true);
user_pref("browser.urlbar.suggest.topsites", false);
// user_pref("browser.urlbar.maxRichResults", 0);
user_pref("browser.urlbar.autoFill", false);
//* 5014
user_pref("browser.taskbar.lists.enabled", false);
user_pref("browser.taskbar.lists.frequent.enabled", false);
user_pref("browser.taskbar.lists.recent.enabled", false);
user_pref("browser.taskbar.lists.tasks.enabled", false);
//* 5019
user_pref("browser.pagethumbnails.capturing_disabled", true);
//* 5020
user_pref("alerts.useSystemBackend.windows.notificationserver.enabled", false);
//* 5021
user_pref("keyword.enabled", true);
//* 5501 - 5510
//user_pref("mathml.disabled", true);
//user_pref("svg.disabled", true);
//user_pref("gfx.font_rendering.graphite.enabled", false);
//user_pref("javascript.options.asmjs", false);
//user_pref("javascript.options.ion", false);
//user_pref("javascript.options.baselinejit", false);
//user_pref("javascript.options.jit_trustedprincipals", true);
//user_pref("javascript.options.wasm", false);
//user_pref("gfx.font_rendering.opentype_svg.enabled", false);
//user_pref("media.eme.enabled", false);
//user_pref("browser.eme.ui.enabled", false);
user_pref("network.dns.disableIPv6", true);
// user_pref("network.http.referer.XOriginPolicy", 2);
//* 7002
user_pref("permissions.default.geo", 2);
user_pref("permissions.default.camera", 0);
user_pref("permissions.default.microphone", 0);
user_pref("permissions.default.desktop-notification", 1);
user_pref("permissions.default.xr", 2);
//* 7013
user_pref("dom.event.clipboardevents.enabled", false);
//* 7014
user_pref("extensions.systemAddon.update.enabled", false);
user_pref("extensions.systemAddon.update.url", "");
//* 7015
user_pref("privacy.donottrackheader.enabled", true);
//* final
user_pref("_user.js.parrot", "SUCCESS: Include Overrides");
