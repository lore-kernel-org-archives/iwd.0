Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4021C9E8
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586437; cv=none; b=hLdxQb02qXl1Lu6BI0qFBvXSbRxFUz/vrFaY7VaaSeZ2qN/SAFRyIoYmDN8tUD5nIzhsfEnnb0GOu8dxeHst6InNDv/+4/0xxyAc2/vHnRNLuRnCcLDQm1DVSPE1kDeQ2T1OOjk0Y7NYzEyPS8MoGI7YJHsh6bbEsOx6FH4cBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586437; c=relaxed/simple;
	bh=33vYsInShERMT0dRxkOvTTkk+q7e9RbMgK6gKunVgBE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=P98+Jpstj91xJIRE0wQ9Abwmg+CDv90gwUIvBGppjdxah0MzPg0NjiYZM6mVfb+afoocSusU2B7HzdehjrXqwrcDxZz+zWxXIn+Pvve3xOw9A4OMdafYSSO4N+nTyrpKsad+HH5kLRuLBX6ZGQOWq3SGc2GGRRXBe0Sv6OLoqTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f679788fd1so52563417b3.2
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 08:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586434; x=1741191234;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MduL4tpVj6lJHJ6f4JwvW60SCMTcEQQFpvWip1sAg+I=;
        b=tiFSaXpwUK0Nhcp9Vrz2kdmIrkVwkMS5uHL7wdAZR/h0rYeG0HKD8XC4uHy3Ybksc+
         WCSQRSCsUVfVG8NtySyWkN7LrJEs3rZ9JQBZw8C8TxDvSVBXQuVXfK0GMy5eGv3DitYs
         gHW+pACysTTdDTAT9RznnU8xeutx5GSTUw2flm3on+EK+TNm4NrOjjjampXp9qG/JqpR
         fjLcKrrK2MS9tVbZOVilizfkiKw07ZcZLBSUet/5alzb89bqciC0NsQxTJCdaZfsl6lz
         Od/rjixcWmhXNmTAZvemCUJpPlbuQqIQs23S0PV1umX9fXCYTezMbNVLz/miEuzsQtyU
         XpYQ==
X-Gm-Message-State: AOJu0YzfNsCfRLmtQHG2Dx1t9sFd5sY56wKDOSoyY9Ypfpdr50baPlT1
	H/cqJN9sWiSL/pS3m+FE9FKZhdRm/PzVT9DSIsMPZGKVFD4i2MfPq7Uoaw==
X-Gm-Gg: ASbGncuHu2ip01FZu3wqqcEMsynbCh9GfHNWE93roAu2x3SEDOlB5/kqnMG18FGDwHi
	RSgkkun3zB/OV+IwOnxnPZj0a+vnQmBmj7+LmMlCtBt1TEWdmCmN60cga8eBHQ6Rp+OoU1y8sFh
	Yi/OLZAzdO6H3RiW2/bWExJ7X+lZQLCWhGJsPS1ZNOiyYabDGM8phvQDsHOecJwuYTZRr+T5zr+
	QOAlZpAtmjGtBqSX0HJzkX7jshXCXzKlE44480bg0N1hBtZr7Kt8TgwVpWQb92NkGmjHlNqycKc
	bTD460jd2UTJD0GcNMmz0dKTnWzpu+mUnJPlCUS8Ak6hSjbyFcTA63QDSem3T/PgAVgGqA==
X-Google-Smtp-Source: AGHT+IHSjJpopwSjtYHduHAcYzH09snyhAiIGyWUYiM2XfLqnYq3C6+IeJrtLWh1VH729iDDlbIKrg==
X-Received: by 2002:a05:690c:4b88:b0:6f5:3bb1:7b7f with SMTP id 00721157ae682-6fbcc36463fmr199261257b3.26.1740586433294;
        Wed, 26 Feb 2025 08:13:53 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd11858b6csm10577767b3.97.2025.02.26.08.13.53
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 08:13:53 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e53a91756e5so5830379276.1
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 08:13:53 -0800 (PST)
X-Received: by 2002:a05:6902:3389:b0:e58:1565:b542 with SMTP id
 3f1490d57ef6-e5e245b028cmr15562145276.1.1740586432031; Wed, 26 Feb 2025
 08:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Wed, 26 Feb 2025 09:13:41 -0700
X-Gmail-Original-Message-ID: <CADXxVSKD-YKOxt+=b919QWFHnU7QcSWnEwfb8xU-JGn=xVrbbg@mail.gmail.com>
X-Gm-Features: AQ5f1Jq0kQUEV_6AmsbDSCYewoiOp859wM24ed1hxDys1caqsL2bBO0Vj6_UPZg
Message-ID: <CADXxVSKD-YKOxt+=b919QWFHnU7QcSWnEwfb8xU-JGn=xVrbbg@mail.gmail.com>
Subject: Does a AP get blacklisted if it fails auth too many times?
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I have an embedded linux device with silabs wf200 chipset with IWD
3.2.  I got logs remotely after the fact so I didn't get to debug this
one in person.

Every now and then wifi will drop off and usually reconnected.  On
this particular one it disconnected, tried to reconnect, failed, and
then never tried again.

[26031.615261] wfx-spi spi0.0: all retries were not consumed: 8 != 0
[26031.822647] wfx-spi spi0.0: all retries were not consumed: 8 != 0
[26031.929170] wfx-spi spi0.0: all retries were not consumed: 8 != 0
[26031.938767] wfx-spi spi0.0: all retries were not consumed: 8 != 0
[26032.133636] wlan0: authenticate with 9a:47:32:d9:93:fa
[26032.250466] wfx-spi spi0.0: hardware request JOIN (0x0b) on vif 0
returned status 1
[26032.258413] wlan0: Connection to AP 9a:47:32:d9:93:fa lost
[26032.268316] wlan0: send auth to 9a:47:32:d9:93:fa (try 1/3)
[26032.277139] wlan0: send auth to 9a:47:32:d9:93:fa (try 2/3)
[26032.288661] wlan0: send auth to 9a:47:32:d9:93:fa (try 3/3)
[26032.296460] wlan0: authentication with 9a:47:32:d9:93:fa timed out
[26084.536843] wlan0: authenticate with 9a:47:32:d9:93:fa
[26084.653608] wfx-spi spi0.0: hardware request JOIN (0x0b) on vif 0
returned status 1
[26084.666977] wlan0: Connection to AP 9a:47:32:d9:93:fa lost
[26084.677162] wlan0: send auth to 9a:47:32:d9:93:fa (try 1/3)
[26084.693950] wlan0: send auth to 9a:47:32:d9:93:fa (try 2/3)
[26084.705232] wlan0: send auth to 9a:47:32:d9:93:fa (try 3/3)
[26084.715456] wlan0: authentication with 9a:47:32:d9:93:fa timed out

From the logs maybe the driver got in a bad state and couldn't
connect.  Although it was able to still do full scans and get results
from iwctl get networks (shown way below)

I did have debug logging for iwd going on this device.  Here is the
iwd log for around that time.  The network I'm trying to connect to is
revelotest1 BSS 9a:47:32:d9:93:fa

2025-02-26 02:47:01.329447721  src/netdev.c:netdev_mlme_notify() MLME
notification Notify CQM(64)
2025-02-26 02:47:01.329770143  src/station.c:station_beacon_lost()
Beacon lost event
2025-02-26 02:47:01.329947975
src/station.c:station_roam_timeout_rearm() Arming new roam timer for 2
seconds
2025-02-26 02:47:01.440552878  src/netdev.c:netdev_mlme_notify() MLME
notification Notify CQM(64)
2025-02-26 02:47:01.440830477  src/station.c:station_beacon_lost()
Beacon lost event
2025-02-26 02:47:01.441000477
src/station.c:station_roam_timeout_rearm() Keeping current roam
timeout of 1 seconds
2025-02-26 02:47:01.541937273  src/netdev.c:netdev_mlme_notify() MLME
notification Notify CQM(64)
2025-02-26 02:47:01.542215872  src/station.c:station_beacon_lost()
Beacon lost event
2025-02-26 02:47:01.542512674
src/station.c:station_roam_timeout_rearm() Keeping current roam
timeout of 1 seconds
2025-02-26 02:47:01.645978105  src/netdev.c:netdev_mlme_notify() MLME
notification Notify CQM(64)
2025-02-26 02:47:01.646257162  src/station.c:station_beacon_lost()
Beacon lost event
2025-02-26 02:47:01.646567212
src/station.c:station_roam_timeout_rearm() Keeping current roam
timeout of 1 seconds
2025-02-26 02:47:01.668631723  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-02-26 02:47:01.674153005  src/netdev.c:netdev_mlme_notify() MLME
notification Del Station(20)
2025-02-26 02:47:01.687597237  src/netdev.c:netdev_mlme_notify() MLME
notification Deauthenticate(39)
2025-02-26 02:47:01.687841678  src/netdev.c:netdev_deauthenticate_event()
2025-02-26 02:47:01.688012386  src/netdev.c:netdev_mlme_notify() MLME
notification Disconnect(48)
2025-02-26 02:47:01.688159725  src/netdev.c:netdev_disconnect_event()
2025-02-26 02:47:01.688303774  Received Deauthentication event,
reason: 4, from_ap: false
2025-02-26 02:47:01.688714507  src/station.c:station_disconnect_event() 2
2025-02-26 02:47:01.688978568  event: disconnect-info, reason: 4
2025-02-26 02:47:01.689138238  src/station.c:station_disassociated() 2
2025-02-26 02:47:01.689283036  src/station.c:station_reset_connection_state() 2
2025-02-26 02:47:01.690701399  src/station.c:station_roam_state_clear() 2
2025-02-26 02:47:01.690893561  event: state, old: connected, new: disconnected
2025-02-26 02:47:01.691203944  event: state, old: disconnected, new:
autoconnect_quick
2025-02-26 02:47:01.694117944  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 20
2025-02-26 02:47:01.699737619  src/wiphy.c:wiphy_radio_work_next()
Starting work item 20
2025-02-26 02:47:01.702752969  src/wiphy.c:wiphy_reg_notify()
Notification of command Reg Change(36)
2025-02-26 02:47:01.702938299  src/wiphy.c:wiphy_update_reg_domain()
New reg domain country code for (global) is XX
2025-02-26 02:47:01.706590745  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-02-26 02:47:01.706876550  src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
2025-02-26 02:47:01.709542694  src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
2025-02-26 02:47:01.709821293
src/station.c:station_quick_scan_triggered() Quick scan triggered for
wlan0
2025-02-26 02:47:01.751569310  src/network.c:network_connect()
2025-02-26 02:47:01.751830413  src/network.c:network_connect_psk()
ask_passphrase: false
2025-02-26 02:47:01.751991999  src/scan.c:scan_cancel() Trying to
cancel scan id 20 for wdev 1
2025-02-26 02:47:01.753564867  src/scan.c:scan_cancel() Scan has been
triggered, wait for it to complete
2025-02-26 02:47:01.753814514  src/netdev.c:netdev_cqm_rssi_update()
2025-02-26 02:47:01.753977225  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 21
2025-02-26 02:47:01.754134687  event: connect-info, ssid: revelotest1,
bss: 9a:47:32:d9:93:fa, signal: -34, load: 26/255
2025-02-26 02:47:01.754274028  event: state, old: autoconnect_quick,
new: connecting
2025-02-26 02:47:01.864521643  src/scan.c:scan_notify() Scan
notification New Scan Results(34)
2025-02-26 02:47:01.864801741  src/wiphy.c:wiphy_radio_work_done()
Work item 20 done
2025-02-26 02:47:01.864979323  src/wiphy.c:wiphy_radio_work_next()
Starting work item 21
2025-02-26 02:47:02.009581253  src/netdev.c:netdev_mlme_notify() MLME
notification New Station(19)
2025-02-26 02:47:02.010964584  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-02-26 02:47:02.034701855  src/netdev.c:netdev_mlme_notify() MLME
notification Del Station(20)
2025-02-26 02:47:02.036876826  src/netdev.c:netdev_mlme_notify() MLME
notification Authenticate(37)
2025-02-26 02:47:02.037139762  src/netdev.c:netdev_authenticate_event()
2025-02-26 02:47:02.039299237  src/netdev.c:netdev_mlme_notify() MLME
notification Connect(46)
2025-02-26 02:47:02.039639821  src/netdev.c:netdev_connect_event()
2025-02-26 02:47:02.039804739  src/netdev.c:netdev_connect_event()
aborting and ignore_connect_event not set, proceed
2025-02-26 02:47:02.040064593  event: connect-timeout, reason: 2
2025-02-26 02:47:02.040238717  src/wiphy.c:wiphy_radio_work_done()
Work item 21 done
2025-02-26 02:47:02.041621673  src/station.c:station_connect_cb() 2, result: 2
2025-02-26 02:47:02.041831497  event: connect-failed, status: 1
2025-02-26 02:47:02.042199907  src/station.c:station_reset_connection_state() 2
2025-02-26 02:47:02.042519579  src/station.c:station_roam_state_clear() 2
2025-02-26 02:47:02.042691746  event: state, old: connecting, new: disconnected
2025-02-26 02:47:02.044709130  event: state, old: disconnected, new:
autoconnect_quick
2025-02-26 02:47:02.044958236  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 22
2025-02-26 02:47:02.045111324  src/wiphy.c:wiphy_radio_work_next()
Starting work item 22
2025-02-26 02:47:02.056545628  src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
2025-02-26 02:47:02.059107755  src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
2025-02-26 02:47:02.059460461
src/station.c:station_quick_scan_triggered() Quick scan triggered for
wlan0
2025-02-26 02:47:02.070527979  src/station.c:station_dbus_disconnect()
2025-02-26 02:47:02.070770878  event: state, old: autoconnect_quick,
new: disconnected
2025-02-26 02:47:02.206536789  src/scan.c:scan_notify() Scan
notification New Scan Results(34)
2025-02-26 02:47:02.210468459  src/station.c:station_print_scan_bss()
Processing BSS '94:a6:7e:f1:9e:70' with SSID: WSLS_TG4, freq: 2452,
rank: 591, strength: -5800, data_rate: 72.2, load: 11/255, clients: 1
2025-02-26 02:47:02.210747516  src/station.c:station_print_scan_bss()
Processing BSS 'bc:df:58:d0:56:a1' with SSID: WSLS_TG1, freq: 2412,
rank: 492, strength: -4400, data_rate: 72.2
2025-02-26 02:47:02.210918516  src/station.c:station_print_scan_bss()
Processing BSS '18:a6:f7:32:9f:bb' with SSID: WSLS_TG9, freq: 2462,
rank: 295, strength: -6900, data_rate: 43.3
2025-02-26 02:47:02.211067855  src/station.c:process_network() No
remaining BSSs for SSID: revelotest1 -- Removing network
2025-02-26 02:47:02.211211153  src/wiphy.c:wiphy_radio_work_done()
Work item 22 done
2025-02-26 02:47:02.214858683  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-02-26 02:47:53.273674272  src/agent.c:agent_register() agent
register called
2025-02-26 02:47:53.275422430  src/agent.c:agent_register() agent
:1.442 path /agent/18104
2025-02-26 02:47:53.276943102  src/station.c:station_dbus_scan() Scan
called from DBus
2025-02-26 02:47:53.278129272  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 23
2025-02-26 02:47:53.279593624  src/wiphy.c:wiphy_radio_work_next()
Starting work item 23
2025-02-26 02:47:53.285734548  src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
2025-02-26 02:47:53.287541776  src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
2025-02-26 02:47:53.287797588
src/station.c:station_dbus_scan_triggered() station_scan_triggered: 0
2025-02-26 02:47:53.287960299
src/station.c:station_dbus_scan_triggered() Scan triggered for wlan0
subset 0
2025-02-26 02:47:53.300304631  src/agent.c:agent_disconnect() agent
:1.442 disconnected
2025-02-26 02:47:53.301569657  src/agent.c:agent_free() agent free 0xe02f30
2025-02-26 02:47:53.444513698  src/scan.c:scan_notify() Scan
notification New Scan Results(34)
2025-02-26 02:47:53.444787840  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-02-26 02:47:53.447270445  src/station.c:station_print_scan_bss()
Processing BSS '94:a6:7e:f1:9e:70' with SSID: WSLS_TG4, freq: 2452,
rank: 591, strength: -5800, data_rate: 72.2, load: 11/255, clients: 1
2025-02-26 02:47:53.448551592  src/station.c:process_network() No
remaining BSSs for SSID: WSLS_TG9 -- Removing network
2025-02-26 02:47:53.448798865  src/station.c:process_network() No
remaining BSSs for SSID: WSLS_TG1 -- Removing network
2025-02-26 02:47:53.449548766  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 24
2025-02-26 02:47:53.449765630  src/wiphy.c:wiphy_radio_work_done()
Work item 23 done
2025-02-26 02:47:53.451549655  src/wiphy.c:wiphy_radio_work_next()
Starting work item 24
2025-02-26 02:47:53.463891946  src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
2025-02-26 02:47:53.466144607  src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
2025-02-26 02:47:53.469009868
src/station.c:station_dbus_scan_triggered() station_scan_triggered: 0
2025-02-26 02:47:53.470125097
src/station.c:station_dbus_scan_triggered() Scan triggered for wlan0
subset 1
2025-02-26 02:47:54.184541045  src/scan.c:scan_notify() Scan
notification New Scan Results(34)
2025-02-26 02:47:54.188511663  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-02-26 02:47:54.188805675  src/station.c:station_print_scan_bss()
Processing BSS '9a:47:32:d9:93:fa' with SSID: revelotest1, freq: 2457,
rank: 591, strength: -3300, data_rate: 72.2, load: 34/255, clients: 12
2025-02-26 02:47:54.188967969  src/station.c:station_add_seen_bss()
Added new Network "revelotest1" security psk
2025-02-26 02:47:54.189122015  src/station.c:process_network() No
remaining BSSs for SSID: WSLS_TG4 -- Removing network
2025-02-26 02:47:54.189268938  src/wiphy.c:wiphy_radio_work_done()
Work item 24 done
2025-02-26 02:47:54.238608276  src/network.c:network_connect()
2025-02-26 02:47:54.241611005  src/network.c:network_connect_psk()
ask_passphrase: false
2025-02-26 02:47:54.241874774  src/netdev.c:netdev_cqm_rssi_update()
2025-02-26 02:47:54.242038567  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 25
2025-02-26 02:47:54.242192072  src/wiphy.c:wiphy_radio_work_next()
Starting work item 25
2025-02-26 02:47:54.242513285  event: connect-info, ssid: revelotest1,
bss: 9a:47:32:d9:93:fa, signal: -33, load: 34/255
2025-02-26 02:47:54.242706072  event: state, old: disconnected, new: connecting
2025-02-26 02:47:54.413439566  src/netdev.c:netdev_mlme_notify() MLME
notification New Station(19)
2025-02-26 02:47:54.438023673  src/netdev.c:netdev_mlme_notify() MLME
notification Del Station(20)
2025-02-26 02:47:54.440510027  src/netdev.c:netdev_mlme_notify() MLME
notification Authenticate(37)
2025-02-26 02:47:54.440783169  src/netdev.c:netdev_authenticate_event()
2025-02-26 02:47:54.443580072  src/netdev.c:netdev_mlme_notify() MLME
notification Connect(46)
2025-02-26 02:47:54.443814140  src/netdev.c:netdev_connect_event()
2025-02-26 02:47:54.443977892  src/netdev.c:netdev_connect_event()
aborting and ignore_connect_event not set, proceed
2025-02-26 02:47:54.444119108  event: connect-timeout, reason: 2
2025-02-26 02:47:54.444272404  src/wiphy.c:wiphy_radio_work_done()
Work item 25 done
2025-02-26 02:47:54.444750787  src/station.c:station_connect_cb() 2, result: 2
2025-02-26 02:47:54.444935367  event: connect-failed, status: 1
2025-02-26 02:47:54.445083123  src/station.c:station_reset_connection_state() 2
2025-02-26 02:47:54.445236461  src/station.c:station_roam_state_clear() 2
2025-02-26 02:47:54.447150621  event: state, old: connecting, new: disconnected
2025-02-26 02:47:54.447761680  event: state, old: disconnected, new:
autoconnect_quick
2025-02-26 02:47:54.447971004  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 26
2025-02-26 02:47:54.448125300  src/wiphy.c:wiphy_radio_work_next()
Starting work item 26
2025-02-26 02:47:54.460641133  src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
2025-02-26 02:47:54.466634717  src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
2025-02-26 02:47:54.467777231
src/station.c:station_quick_scan_triggered() Quick scan triggered for
wlan0
2025-02-26 02:47:54.473604731  src/station.c:station_dbus_disconnect()
2025-02-26 02:47:54.473847839  event: state, old: autoconnect_quick,
new: disconnected
2025-02-26 02:47:54.611529576  src/scan.c:scan_notify() Scan
notification New Scan Results(34)
2025-02-26 02:47:54.611823463  src/station.c:station_print_scan_bss()
Processing BSS '9a:47:32:d9:93:fa' with SSID: revelotest1, freq: 2457,
rank: 591, strength: -3500, data_rate: 72.2, load: 37/255, clients: 12
2025-02-26 02:47:54.614098035  src/wiphy.c:wiphy_radio_work_done()
Work item 26 done
2025-02-26 02:47:54.616712275  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-02-26 02:47:58.381879699  src/agent.c:agent_register() agent
register called
2025-02-26 02:47:58.383827059  src/agent.c:agent_register() agent
:1.443 path /agent/18105
2025-02-26 02:47:58.405900235  src/agent.c:agent_disconnect() agent
:1.443 disconnected
2025-02-26 02:47:58.406170127  src/agent.c:agent_free() agent free
0xdfc1982025-02-26 02:47:58.381879699  src/agent.c:agent_register()
agent register called
2025-02-26 02:47:58.383827059  src/agent.c:agent_register() agent
:1.443 path /agent/18105
2025-02-26 02:47:58.405900235  src/agent.c:agent_disconnect() agent
:1.443 disconnected
2025-02-26 02:47:58.406170127  src/agent.c:agent_free() agent free 0xdfc198


After that if it is disconnected and thinks it should be connected (we
had provisioned a network).  It will run full scans ever 1.5min



2025-02-26 02:49:28.575265828  src/agent.c:agent_register() agent
register called
2025-02-26 02:49:28.577004280  src/agent.c:agent_register() agent
:1.444 path /agent/18171
2025-02-26 02:49:28.579123765  src/station.c:station_dbus_scan() Scan
called from DBus
2025-02-26 02:49:28.580534630  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 27
2025-02-26 02:49:28.580785944  src/wiphy.c:wiphy_radio_work_next()
Starting work item 27
2025-02-26 02:49:28.586812229  src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
2025-02-26 02:49:28.587090786  src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
2025-02-26 02:49:28.587256288
src/station.c:station_dbus_scan_triggered() station_scan_triggered: 0
2025-02-26 02:49:28.587599038
src/station.c:station_dbus_scan_triggered() Scan triggered for wlan0
subset 0
2025-02-26 02:49:28.608125923  src/agent.c:agent_disconnect() agent
:1.444 disconnected
2025-02-26 02:49:28.608550069  src/agent.c:agent_free() agent free 0xdfc198
2025-02-26 02:49:28.743072742  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-02-26 02:49:28.744575043  src/scan.c:scan_notify() Scan
notification New Scan Results(34)
2025-02-26 02:49:28.749885085  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:85' with SSID: WSLS_TG2, freq: 2437,
rank: 663, strength: -6500, data_rate: 81.0, load: 20/255, clients: 1
2025-02-26 02:49:28.751628786  src/station.c:station_add_seen_bss()
Added new Network "WSLS_TG2" security psk
2025-02-26 02:49:28.756468402  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:45:95' with SSID: SWAMP-DEVICES, freq:
2412, rank: 532, strength: -6100, data_rate: 65.0, load: 36/255,
clients: 0
2025-02-26 02:49:28.756833646  src/station.c:station_add_seen_bss()
Added new Network "SWAMP-DEVICES" security psk
2025-02-26 02:49:28.757024183  src/station.c:station_print_scan_bss()
Processing BSS 'bc:df:58:d0:56:a1' with SSID: WSLS_TG1, freq: 2412,
rank: 492, strength: -4400, data_rate: 72.2
2025-02-26 02:49:28.757185311  src/station.c:station_add_seen_bss()
Added new Network "WSLS_TG1" security psk
2025-02-26 02:49:28.757497485  src/station.c:station_print_scan_bss()
Processing BSS '88:da:1a:7e:61:ec' with SSID: L2402080530A64, freq:
2412, rank: 443, strength: -5700, data_rate: 65.0
2025-02-26 02:49:28.757690480  src/station.c:station_add_seen_bss()
Added new Network "L2402080530A64" security psk
2025-02-26 02:49:28.757860438  src/station.c:station_print_scan_bss()
Processing BSS '88:da:1a:7e:67:94' with SSID: L24019805308EF, freq:
2412, rank: 443, strength: -5700, data_rate: 65.0
2025-02-26 02:49:28.758012984  src/station.c:station_add_seen_bss()
Added new Network "L24019805308EF" security psk
2025-02-26 02:49:28.760202036  src/station.c:station_print_scan_bss()
Processing BSS '00:23:a7:d1:58:e0' with SSID: L24019805307D3, freq:
2412, rank: 443, strength: -5800, data_rate: 65.0
2025-02-26 02:49:28.761742494  src/station.c:station_add_seen_bss()
Added new Network "L24019805307D3" security psk
2025-02-26 02:49:28.763637409  src/station.c:station_print_scan_bss()
Processing BSS 'a0:36:bc:61:1d:88' with SSID: WSLS_TG3, freq: 2437,
rank: 443, strength: -6500, data_rate: 65.0
2025-02-26 02:49:28.764595718  src/station.c:station_add_seen_bss()
Added new Network "WSLS_TG3" security psk
2025-02-26 02:49:28.766526082  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:57:98' with SSID: SWAMP-MOBILE, freq:
2462, rank: 319, strength: -6700, data_rate: 39.0, load: 27/255,
clients: 0
2025-02-26 02:49:28.766868582  src/station.c:station_add_seen_bss()
Added new Network "SWAMP-MOBILE" security 8021x
2025-02-26 02:49:28.771470630  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:57:97' with SSID: SWAMP, freq: 2462, rank:
319, strength: -6700, data_rate: 39.0, load: 27/255, clients: 0
2025-02-26 02:49:28.771737106  src/station.c:station_add_seen_bss()
Added new Network "SWAMP" security 8021x
2025-02-26 02:49:28.771917188  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:57:94' with SSID: SWAMP_GUEST, freq: 2462,
rank: 319, strength: -6800, data_rate: 39.0, load: 27/255, clients: 0
2025-02-26 02:49:28.772065110  src/station.c:station_add_seen_bss()
Added new Network "SWAMP_GUEST" security open
2025-02-26 02:49:28.772219114  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:57:95' with SSID: SWAMP-DEVICES, freq:
2462, rank: 319, strength: -7000, data_rate: 39.0, load: 27/255,
clients: 0
2025-02-26 02:49:28.772530788  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:29:e5:05' with SSID: WSLS_TG2, freq: 2437,
rank: 221, strength: -7500, data_rate: 27.0, load: 26/255, clients: 2
2025-02-26 02:49:28.775113827  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a9:1f:15' with SSID: SWAMP-DEVICES, freq:
2437, rank: 212, strength: -7300, data_rate: 26.0, load: 38/255,
clients: 0
2025-02-26 02:49:28.779197043  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a9:1f:18' with SSID: SWAMP-MOBILE, freq:
2437, rank: 106, strength: -7800, data_rate: 13.0, load: 38/255,
clients: 0
2025-02-26 02:49:28.779545708  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a9:1f:17' with SSID: SWAMP, freq: 2437, rank:
106, strength: -7800, data_rate: 13.0, load: 38/255, clients: 0
2025-02-26 02:49:28.779739494  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a9:1f:14' with SSID: SWAMP_GUEST, freq: 2437,
rank: 106, strength: -7800, data_rate: 13.0, load: 38/255, clients: 0
2025-02-26 02:49:28.782107919  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:4d:58' with SSID: SWAMP-MOBILE, freq:
2462, rank: 106, strength: -7900, data_rate: 13.0, load: 44/255,
clients: 0
2025-02-26 02:49:28.786455487  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:4d:57' with SSID: SWAMP, freq: 2462, rank:
106, strength: -7900, data_rate: 13.0, load: 44/255, clients: 0
2025-02-26 02:49:28.786719839  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:4d:54' with SSID: SWAMP_GUEST, freq: 2462,
rank: 106, strength: -7900, data_rate: 13.0, load: 44/255, clients: 0
2025-02-26 02:49:28.787010643  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:4d:55' with SSID: SWAMP-DEVICES, freq:
2462, rank: 53, strength: -8000, data_rate: 6.5, load: 44/255,
clients: 0
2025-02-26 02:49:28.787204596  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a9:50:95' with SSID: SWAMP-DEVICES, freq:
2462, rank: 16, strength: -8600, data_rate: 2.0, load: 43/255,
clients: 0
2025-02-26 02:49:28.787507398  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:87:d5' with SSID: SWAMP-DEVICES, freq:
2437, rank: 16, strength: -8600, data_rate: 2.0, load: 37/255,
clients: 0
2025-02-26 02:49:28.790087937  src/station.c:station_print_scan_bss()
Processing BSS '9a:47:32:d9:93:fa' with SSID: revelotest1, freq: 2457,
rank: 591, strength: -3500, data_rate: 72.2, load: 37/255, clients: 12
2025-02-26 02:49:28.791660430  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 28




I'm also running some additional logging that grabs iwctl get networks logs:

2025-02-26 02:46:23.181503912  iwctl get networks result stdout:
2025-02-26 02:46:23.182461346
Available networks
2025-02-26 02:46:23.182715243
--------------------------------------------------------------------------------
2025-02-26 02:46:23.182879203        Network name
Security            Signal
2025-02-26 02:46:23.183025251
--------------------------------------------------------------------------------
2025-02-26 02:46:23.183165134    >   revelotest1
psk                 -3400
2025-02-26 02:46:23.183300559        WSLS_TG4
psk                 -5800
2025-02-26 02:46:23.183537835        WSLS_TG1
psk                 -4400
2025-02-26 02:46:23.183691839        WSLS_TG9
psk                 -6900


2025-02-26 02:47:58.399205071  iwctl get networks result stdout:
2025-02-26 02:47:58.400313135
Available networks
2025-02-26 02:47:58.400757818
--------------------------------------------------------------------------------
2025-02-26 02:47:58.400927027        Network name
Security            Signal
2025-02-26 02:47:58.401077740
--------------------------------------------------------------------------------
2025-02-26 02:47:58.401217956        revelotest1
psk                 -3500

2025-02-26 02:49:33.724233554  iwctl get networks result stdout:
2025-02-26 02:49:33.725276883
Available networks
2025-02-26 02:49:33.725729732
--------------------------------------------------------------------------------
2025-02-26 02:49:33.725900773        Network name
Security            Signal
2025-02-26 02:49:33.726051987
--------------------------------------------------------------------------------
2025-02-26 02:49:33.726197618        revelotest1
psk                 -3600
2025-02-26 02:49:33.726414440        WSLS_TG2
psk                 -6500
2025-02-26 02:49:33.726769896        WSLS_TG4
psk                 -6000
2025-02-26 02:49:33.726966931        SWAMP-DEVICES
psk                 -6100
2025-02-26 02:49:33.727126434        WSLS_TG1
psk                 -4400
2025-02-26 02:49:33.727281313        WSLS_TG3
psk                 -6500
2025-02-26 02:49:33.727610358        L24019805308EF
psk                 -5700
2025-02-26 02:49:33.727784316        L24019805307D3
psk                 -5800
2025-02-26 02:49:33.727935321        L2402080530A64
psk                 -5700
2025-02-26 02:49:33.728078952        SWAMP-MOBILE
8021x               -6700
2025-02-26 02:49:33.728218752        SWAMP
8021x               -6700
2025-02-26 02:49:33.729241586        SWAMP_GUEST
open                -6800
2025-02-26 02:49:33.729621286


Is there some blacklist that occurs with enough failures?  This device
ended up sitting like this for a couple hours before it got restarted
- after the restart IWD immediately reconnected to the AP.

We also do have connman going although we are doing the connecting
through iwd either through dbus or iwctl commands.

2025-02-26 02:47:01.745048187  connmand[2131]: wlan0 {del} address
10.3.8.177/23 label wlan0
2025-02-26 02:47:01.759563783  connmand[2131]: Interface wlan0 [ wifi
] state is association
2025-02-26 02:47:01.762461246  connmand[2131]: ipconfig state 2
ipconfig method 1
2025-02-26 02:47:01.769285712  connmand[2131]: Interface wlan0 [ wifi
] state is configuration
2025-02-26 02:47:01.785074332  connmand[2131]: ipconfig state 3
ipconfig method 1
2025-02-26 02:47:02.050964651  connmand[2131]: Interface wlan0 [ wifi
] error "invalid-key"
2025-02-26 02:47:02.053646583  connmand[2131]: Interface wlan0 [ wifi
] state is failure
2025-02-26 02:47:02.066800968  connmand[2131]: ipconfig state 7
ipconfig method 1
2025-02-26 02:47:54.216771085
2025-02-26 02:47:54.217227599  (connmand:2131): GLib-CRITICAL **:
02:47:54.215: g_ascii_strcasecmp: assertion 's1 != NULL' failed
2025-02-26 02:47:54.245456278  connmand[2131]: Interface wlan0 [ wifi
] state is association
2025-02-26 02:47:54.248591599  connmand[2131]: ipconfig state 2
ipconfig method 1
2025-02-26 02:47:54.258633408  connmand[2131]: Interface wlan0 [ wifi
] state is configuration
2025-02-26 02:47:54.267982302  connmand[2131]: ipconfig state 3
ipconfig method 1
2025-02-26 02:47:54.453669827  connmand[2131]: Interface wlan0 [ wifi
] error "invalid-key"
2025-02-26 02:47:54.457083997  connmand[2131]: Interface wlan0 [ wifi
] state is failure
2025-02-26 02:47:54.465434009  connmand[2131]: ipconfig state 7
ipconfig method 1


Thanks
Bryce
