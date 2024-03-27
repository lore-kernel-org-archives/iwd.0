Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874B13B2B9
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564619; cv=none; b=p4c+wzUXluQ/ujkcff4wh/bJTdG1/uGzOWgfcJzVlGtpcyiRT8kTnoVpNYxz48HS1sF9apKAbkpOgXyJRMb0btPpYthW5on8M8UMNcdHHw20hD+SuAZxjAaM0GniDaTC1Q2Wpk4ZaZVEtT8u+RTvwALtsA1p1Zpgh13cNEjcoX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564619; c=relaxed/simple;
	bh=lF32+DhsfATbC0NOk4kAxhZPVLjY5lbShPmrH7MYSMc=;
	h=MIME-Version:Message-Id:Date:From:To:Subject:Content-Type; b=LZ14hYhdSDhmEC0DKRo9FrGTVpHrYgYDG02wo1hcN6Eug2jj1sjfEb6AvhB8cQtp1R3CgEUNyEUoTpJ1iRwzL1gJ6b6KzRsSY/OXjU+r3VrlLXCK/NSOnMmYFpE7ZADMn20NJ7SM0xBvoTONl7XjpaUxD7SYJSSpbEWtVtzdVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=svenstaro.org; spf=pass smtp.mailfrom=svenstaro.org; dkim=pass (2048-bit key) header.d=svenstaro.org header.i=@svenstaro.org header.b=05vQdtIw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyGGTBJs; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=svenstaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenstaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenstaro.org header.i=@svenstaro.org header.b="05vQdtIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyGGTBJs"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id ABB073200922
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 14:36:53 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Wed, 27 Mar 2024 14:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenstaro.org;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1711564613; x=1711651013; bh=4GEjjiT/I8AZOnxiS9coodjaPjw1K4Ru
	vT/L3kVwV10=; b=05vQdtIwKOtBVw1Mh7RM2d4gWTjzKoy4wDhqWFPQiuWvEVuq
	8oVm5i0LVMWxnA8FcUcXwNzYWB39a2Jj1miBjdDRr11ypJ9AvmdVOI/wAmJo5mTq
	9zn8ylwJQFQiVNtIC38Culv/MXLHdq8bkAdZEXd0dStAjNv47/rAUHUltPVHpWGK
	gbNcgDv2ko0izag/mOhzlc1VfcyM2seP6B6tYTdCfesdgRvorgjOoG4aWT0L8N3q
	SIXsBM0jrhncTpiF5p6gjcIbCsEgjfXWWa3kJj+K33aDLomG96Dy2wS13XgYwiWt
	vzXIsxqY0rD9NgTs2LcRERVpGtPQO6vJB5fNZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1711564613; x=1711651013; bh=4GEjjiT/I8AZOnxiS9coodjaPjw1K4RuvT/
	L3kVwV10=; b=HyGGTBJsuxryRDo0MSQE/ffDZ/LbfFhcmbJYRznFwwZAT1W65+M
	3wlBG1bNp9oOFoL1uFWkpA4Ai5Etca5f8wBFZED/R6hQOf0jUZXtIGuhajBRkvoZ
	gLmnzICn1Ltpsr3KGZ1ipJuwzPczgKrBr1L0ysn90azj8vaboimcv9SBllyb8Euc
	Acw+IkpEpFpI0n7pTVR9Ks1BkIh3WQSljf9T688yYHiKf2rTd2NM954zh8GDjhQx
	mj6E+7dXYlK99zjUs5fETvSW+i+0FJUjNRROPtiSZIulHLwytWjZVapJIPmnDlnn
	9yX50EaZ8RIz3Yr4Npx/XaXWOUykJKh2Gxw==
X-ME-Sender: <xms:RGcEZnVf-quDsj-reyThCSOqOkKeLyQsOGCFS-OOe2Kcwet2dMk14w>
    <xme:RGcEZvneL-kwOjwIK04Fn3SUKNHkf2P47l_rYFQDh5iwhiymdslaW1Gqb6zaEQNjk
    MZ2L1nECeHz7NkQaK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfufhvvghnqdfjvghnughrihhkucfjrggrshgvfdcuoehmrghi
    lhhinhhglhhishhtshesshhvvghnshhtrghrohdrohhrgheqnecuggftrfgrthhtvghrnh
    epvedthffhfeeggfdtffettdduvdfhuddujedtjeektdehhfdtkedtgeffffffgfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrihhlih
    hnghhlihhsthhssehsvhgvnhhsthgrrhhordhorhhg
X-ME-Proxy: <xmx:RGcEZjb-ob6Qpe1d3Ln0uMsivszHwYp7PW2eXXPR8MsPD_5qeIib_A>
    <xmx:RGcEZiUtCSgpZJVxKR3XhLPEbc3zXUzkuy55XRV5gObZdvSRRmcnfg>
    <xmx:RGcEZhk71zqdq8WLSUBTWQy_4VWvZ5bwOYJWJdjMeilQ6MiEZlAzeQ>
    <xmx:RGcEZvc7rxYNPcXdi7oxrvNVf-XFLxFpwVN-FaBiLy8d5jdrr4tW9A>
    <xmx:RWcEZvSXaRsDKH8j5vZ50So_4EChpZmdVoZzJE7Q5PYoAp2hdXKVfA>
Feedback-ID: i6bf14966:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 995F11700093; Wed, 27 Mar 2024 14:36:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <699c79ff-0082-4602-9bb8-475722563c46@app.fastmail.com>
Date: Wed, 27 Mar 2024 19:36:02 +0100
From: "Sven-Hendrik Haase" <mailinglists@svenstaro.org>
To: iwd@lists.linux.dev
Subject: iwd picking worse network despite better one available
Content-Type: text/plain

Hello,

I've spent a good chunk of my evening looking into why iwd doesn't select the network I want it to select. I have a network "Home" with two APs. iwd seems to strongly prefer the AP that is further away and that has worse strength as measured by iwd.

From some testing, I believe it has to do with the AP rather than the wifi adapter. I tested a wifi adapter using mt7921e and one using iwlwifi and the result is the same in both cases. The APs are both pretty modern: The one iwd doesn't like is a FRITZ!Box 7590 AX while the one it likes is a FRITZ!Repeater 6000. From the log it seems that iwd is unable to perform a proper data rate estimation and then falls back to some default. At any rate, the rank would indicate that the estimated data rate plays an important role. If I use the developer mode to force roaming to the AP I want (named "better" in the log) then I'm able to use it perfectly well with a good data rate.

As such I think this is a bug _somewhere_ but I'm not exactly sure where. I searched the configuration options but it seems it's not possible to turn off the data rate estimations for the ranking. I'd be perfectly happy to just go by signal strength. However, I suppose it would be better to actually fix the core problem in iwd.

Log is here:

Mar 27 16:01:55 cypher systemd[1]: Starting Wireless service...
Mar 27 16:01:55 cypher iwd[30930]: Wireless daemon version 2.16
Mar 27 16:01:55 cypher iwd[30930]: src/main.c:main() Using configuration directory /etc/iwd
Mar 27 16:01:55 cypher iwd[30930]: src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
Mar 27 16:01:55 cypher systemd[1]: Started Wireless service.
Mar 27 16:01:55 cypher iwd[30930]: src/main.c:nl80211_appeared() Found nl80211 interface
Mar 27 16:01:55 cypher iwd[30930]: src/module.c:iwd_modules_init()
Mar 27 16:01:55 cypher iwd[30930]: station: Network configuration is disabled.
Mar 27 16:01:55 cypher iwd[30930]: src/wsc.c:wsc_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap.c:__eap_method_enable()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-wsc.c:eap_wsc_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-md5.c:eap_md5_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-tls.c:eap_tls_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-ttls.c:eap_ttls_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-mschapv2.c:eap_mschapv2_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-sim.c:eap_sim_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-aka.c:eap_aka_prime_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-aka.c:eap_aka_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-peap.c:eap_peap_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-gtc.c:eap_gtc_init()
Mar 27 16:01:55 cypher iwd[30930]: src/eap-pwd.c:eap_pwd_init()
Mar 27 16:01:55 cypher iwd[30930]: src/manager.c:manager_wiphy_dump_callback() New wiphy phy0 added (0)
Mar 27 16:01:55 cypher iwd[30930]: src/manager.c:manager_wiphy_dump_done()
Mar 27 16:01:55 cypher iwd[30930]: src/manager.c:manager_filtered_wiphy_dump_done()
Mar 27 16:01:55 cypher iwd[30930]: Wiphy: 0, Name: phy0
Mar 27 16:01:55 cypher iwd[30930]:         Permanent Address: redacted
Mar 27 16:01:55 cypher iwd[30930]:         2.4GHz Band:
Mar 27 16:01:55 cypher iwd[30930]:                 Bitrates (non-HT):
Mar 27 16:01:55 cypher iwd[30930]:                          1.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                          2.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                          5.5 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         11.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                          6.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                          9.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         12.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         18.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         24.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         36.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         48.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         54.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                 HT Capabilities:
Mar 27 16:01:55 cypher iwd[30930]:                         HT40
Mar 27 16:01:55 cypher iwd[30930]:                         Short GI for 20Mhz
Mar 27 16:01:55 cypher iwd[30930]:                         Short GI for 40Mhz
Mar 27 16:01:55 cypher iwd[30930]:                 HT RX MCS indexes:
Mar 27 16:01:55 cypher iwd[30930]:                         0-15
Mar 27 16:01:55 cypher iwd[30930]:                 HE Capabilities
Mar 27 16:01:55 cypher iwd[30930]:                         Interface Types: ap
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE RX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE TX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Interface Types: station
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE RX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE TX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:         5GHz Band:
Mar 27 16:01:55 cypher iwd[30930]:                 Bitrates (non-HT):
Mar 27 16:01:55 cypher iwd[30930]:                          6.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                          9.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         12.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         18.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         24.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         36.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         48.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         54.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                 HT Capabilities:
Mar 27 16:01:55 cypher iwd[30930]:                         HT40
Mar 27 16:01:55 cypher iwd[30930]:                         Short GI for 20Mhz
Mar 27 16:01:55 cypher iwd[30930]:                         Short GI for 40Mhz
Mar 27 16:01:55 cypher iwd[30930]:                 HT RX MCS indexes:
Mar 27 16:01:55 cypher iwd[30930]:                         0-15
Mar 27 16:01:55 cypher iwd[30930]:                 VHT Capabilities:
Mar 27 16:01:55 cypher iwd[30930]:                         160 Mhz operation
Mar 27 16:01:55 cypher iwd[30930]:                         Short GI for 80Mhz
Mar 27 16:01:55 cypher iwd[30930]:                         Short GI for 160 and 80 + 80 Mhz
Mar 27 16:01:55 cypher iwd[30930]:                         Max RX MCS: 0-9 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max TX MCS: 0-9 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                 HE Capabilities
Mar 27 16:01:55 cypher iwd[30930]:                         Interface Types: ap
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE RX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE TX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Interface Types: station
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE RX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE TX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE RX <= 160MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE TX <= 160MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:         6GHz Band:
Mar 27 16:01:55 cypher iwd[30930]:                 Bitrates (non-HT):
Mar 27 16:01:55 cypher iwd[30930]:                          6.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                          9.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         12.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         18.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         24.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         36.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         48.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                         54.0 Mbps
Mar 27 16:01:55 cypher iwd[30930]:                 HE Capabilities
Mar 27 16:01:55 cypher iwd[30930]:                         Interface Types: ap
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE RX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE TX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Interface Types: station
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE RX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE TX <= 80MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE RX <= 160MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:                         Max HE TX <= 160MHz MCS: 0-11 for NSS: 2
Mar 27 16:01:55 cypher iwd[30930]:         Ciphers: BIP-CMAC-256 BIP-GMAC-256 BIP-GMAC-128 CCMP-256
Mar 27 16:01:55 cypher iwd[30930]:                  GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
Mar 27 16:01:55 cypher iwd[30930]:                  TKIP
Mar 27 16:01:55 cypher iwd[30930]:         Supported iftypes: station ap p2p-client p2p-go
Mar 27 16:01:55 cypher iwd[30930]: src/manager.c:manager_interface_dump_done()
Mar 27 16:01:55 cypher iwd[30930]: src/manager.c:manager_create_interfaces() creating wlan0
Mar 27 16:01:55 cypher iwd[30930]: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is DE
Mar 27 16:01:55 cypher iwd[30930]: src/manager.c:manager_config_notify() Notification of command New Interface(7)
Mar 27 16:01:55 cypher iwd[30930]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Mar 27 16:01:55 cypher iwd[30930]: src/manager.c:manager_new_station_interface_cb()
Mar 27 16:01:55 cypher iwd[30930]: src/netdev.c:netdev_create_from_genl() Created interface wlan0[6 5]
Mar 27 16:01:55 cypher iwd[30930]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Mar 27 16:01:55 cypher iwd[30930]: src/netdev.c:netdev_set_4addr() netdev: 6 use_4addr: 0
Mar 27 16:01:55 cypher iwd[30930]: src/netdev.c:netdev_initial_up_cb() Interface 6 initialized
Mar 27 16:01:55 cypher iwd[30930]: event: state, old: disconnected, new: autoconnect_quick
Mar 27 16:01:55 cypher iwd[30930]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
Mar 27 16:01:55 cypher iwd[30930]: src/wiphy.c:wiphy_radio_work_next() Starting work item 1
Mar 27 16:01:55 cypher iwd[30930]: src/rrm.c:rrm_add_frame_watches()
Mar 27 16:01:55 cypher iwd[30930]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Mar 27 16:01:55 cypher iwd[30930]: src/manager.c:manager_config_notify() Notification of command Set Interface(6)
Mar 27 16:01:55 cypher iwd[30930]: src/scan.c:scan_notify() Scan notification Trigger Scan(33)
Mar 27 16:01:55 cypher iwd[30930]: src/scan.c:scan_request_triggered() Active scan triggered for wdev 5
Mar 27 16:01:55 cypher iwd[30930]: src/station.c:station_quick_scan_triggered() Quick scan triggered for wlan0
Mar 27 16:01:55 cypher iwd[30930]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Mar 27 16:01:55 cypher iwd[30930]: src/scan.c:scan_notify() Scan notification New Scan Results(34)
Mar 27 16:01:55 cypher iwd[30930]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Mar 27 16:01:55 cypher iwd[30930]: wiphy_estimate_data_rate() failed
Mar 27 16:01:55 cypher iwd[30930]: wiphy_estimate_data_rate() failed
Mar 27 16:01:55 cypher iwd[30930]: src/station.c:station_add_seen_bss() Processing BSS 'worse:2d' with SSID: Home, freq: 2412, rank: 469, strength: -7100, data_rate: 68.8
Mar 27 16:01:55 cypher iwd[30930]: src/station.c:station_add_seen_bss() Added new Network "Home" security psk
Mar 27 16:01:55 cypher iwd[30930]: src/station.c:station_add_seen_bss() Processing BSS 'better:f1' with SSID: Home, freq: 2462, rank: 16, strength: -4700, data_rate: 2.0
Mar 27 16:01:55 cypher iwd[30930]: src/station.c:station_add_seen_bss() Processing BSS 'better:f0' with SSID: Home, freq: 5180, rank: 16, strength: -5500, data_rate: 2.0
Mar 27 16:01:55 cypher iwd[30930]: src/station.c:station_add_seen_bss() Processing BSS 'worse:2e' with SSID: Home, freq: 5180, rank: 13, strength: -9000, data_rate: 2.0
Mar 27 16:01:55 cypher iwd[30930]: src/station.c:station_autoconnect_start()
Mar 27 16:01:55 cypher iwd[30930]: src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
Mar 27 16:01:55 cypher iwd[30930]: src/station.c:station_autoconnect_next() autoconnect: Trying SSID: Home
Mar 27 16:01:55 cypher iwd[30930]: src/station.c:station_autoconnect_next() autoconnect: 'worse:2d' freq: 2412, rank: 469, strength: -7100
Mar 27 16:01:55 cypher iwd[30930]: src/wiphy.c:wiphy_select_akm() Network is WPA3-Personal...
Mar 27 16:01:55 cypher iwd[30930]: src/netdev.c:netdev_cqm_rssi_update()
Mar 27 16:01:55 cypher iwd[30930]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
Mar 27 16:01:55 cypher iwd[30930]: event: connect-info, ssid: Home, bss: worse:2d, signal: -71, load: 127/255
