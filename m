Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86C3E0C47
	for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938626; cv=none; b=s7wRL9TUvwrEtolZwr+sb01Nd9utq6uGOX7MvHmdYliP8HIEDn4HUmS15sqZ9/Hhz3UGD1d5CsnEf/7+0dRWFrUxYEhS5RbA3xous3hDoeVQuhWQZQPMKBUoVOW8Kln3U1bf5UJntlvkP1xPp2sIkYcYjtn9PYfqRvlUpTJ0g8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938626; c=relaxed/simple;
	bh=pVGf1RZFTsiaIZVjkRgIozE1hwxQR0Lw4hFdXOKMJXc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=G6Sy9F+NLLLQEvjBWIurIZyTPhY8wQss7161gpxKkR/EFhr9xxkHeOgdtZDNG9Dc2V1/tKpAhiOgI5yvroXQj1Cl3cy71GnywaNGJxGoT6yCbjNI/FfMEIzoAjsTI05G8+B+Jg9gw0OEnRNydoAS13JorsXYEgoyPZBValRj5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64937edbc9eso1385472d50.2
        for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 09:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938611; x=1774543411;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQduuqyM5QOGOaPG1t25wJcCaEOAU2zU+IFLaYN+Bxk=;
        b=ZZ8jtikkvpPANcf/eZM0NyCnyHFQ+P6717uq14R0t6CiqYDIkIl+xjEgPzYwc6IfV7
         1N+6Pkw0MIue/n4IhA8wbefV7u8LXyz14f173H+yvj5AM2nbspjI1aTTXxOVCnwLik/p
         yXveuJcR3Bsc022FwkNkV/3uMAGv2BQ0xCRAKJF5bgJjXn9/Ctria/MRL9t+y4E+BT1T
         O9wMyDyM/BVHz9f6wAM1MaG8QDkB4YrVVeZjTnk5aj2rGd0/9b3edPa/DYNsZAhhv2uo
         Kl0V3e1mllFVfr29X4ZoCfVt1DHaz1g9RVeE0JfwtIAJDEDVaj5hxz2TNwwqhP/2RG3w
         IWmw==
X-Gm-Message-State: AOJu0Yym/qP/73VCFf21SkR3maALSrCUNh38m4ulVXrXnMp1Yrc5cbld
	CXptKrx6zvo9NviGxVCiOoFm+fmI/foDKXLCgEUslwkgvDo1sbCgG3WhEAtWTw==
X-Gm-Gg: ATEYQzyCeaFQvcX/+OvJ2erG0wHrpB6opY82ldMngi/dsJgCBq5jmJQEowRoRWsTym9
	1QxiBI7KLiYRqEh3la7QomH4bkbe/Y2CYeJhufuI5NEc7jpzTisYsqguaPfM5M9ZxIgve+aKwHu
	adrnsDVakE9GGNaZtIeaND5N5U6iKdwHlZg0zUzrrnVaXHGJU/mYGpxigUFeX/gCmzNw6NoeF4h
	YMY2ZGBXpmhOWbTp8ktdS8Hzk5LcOtUzaIluVNlZQnR/YzEozLcHUDDr2pPdNwgqhFTXUaA/Lnb
	aJtyNwf9c2fn6u4ASW54B2Gn3F8gs5ccuYCEEmDG/RS8Psl2BPw9mzwVPHAFX0GQxZm5KkYVzLF
	Vz3ZjFdY6CtaTYlEp06z6dYjliTcVgZg4HYkNBwHurEPAYIRP36zyNXHxXbCweB1meq6fP/Vuvu
	oyiktqz+5DCNsfuj5vu9zcBYwprUopWr0ooTpcxhmSljUCAzrueg1sWabDGAuxmQ==
X-Received: by 2002:a05:690c:c119:b0:797:f005:2dc0 with SMTP id 00721157ae682-79a71c88395mr69409607b3.50.1773938608719;
        Thu, 19 Mar 2026 09:43:28 -0700 (PDT)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com. [74.125.224.48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713f31b8sm41963667b3.18.2026.03.19.09.43.27
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 09:43:27 -0700 (PDT)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64e8ae85700so1415455d50.1
        for <iwd@lists.linux.dev>; Thu, 19 Mar 2026 09:43:27 -0700 (PDT)
X-Received: by 2002:a53:dd08:0:b0:64e:71a4:95bb with SMTP id
 956f58d0204a3-64eaa82e4edmr79642d50.64.1773938605131; Thu, 19 Mar 2026
 09:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Thu, 19 Mar 2026 10:43:14 -0600
X-Gmail-Original-Message-ID: <CADXxVS+V8Zbn+WV=G1eJ7pqipHNmhjd67pNM62vu8Lr_RkuVnw@mail.gmail.com>
X-Gm-Features: AaiRm51R40zKV3zc2T8nr-oWMaJdNDQtWhjvd-Ebwc_Df3G8V0XhHAQm7op91T4
Message-ID: <CADXxVS+V8Zbn+WV=G1eJ7pqipHNmhjd67pNM62vu8Lr_RkuVnw@mail.gmail.com>
Subject: On WPA3 successful reconnect with wrong password after a forget network
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,
We ran into this edge case issue on only wpa3. If we forget a network
and reconnect to the same network with an the incorrect password, it
will connect anyways.  wpa1 and wpa2 don't reconnect.  This is on IWD
3.10.

Trimmed it down to this reproducible oneliner, Added a sleep to make
sure everything was cleared out, but it isn't needed.

iwctl --passphrase "correctpassword" station wlan0 connect
"revelotest_wpa3" && iwctl known-networks revelotest_wpa3 forget &&
sleep 60 && iwctl --passphrase "wrongpassword" station wlan0 connect
"revelotest_wpa3"

My guess is that it skipped the check due to the "Skipping SAE by
using PMKSA cache"?

Revelo-238494033:/opt/iprf# date
Thu Mar 19 16:32:08 UTC 2026
Revelo-238494033:/opt/iprf# iwctl --passphrase "correctpassword"
station wlan0 conne
ct "revelotest_wpa3" && iwctl known-networks revelotest_wpa3 forget && sleep 60
&& iwctl --passphrase "wrongpassword" station wlan0 connect "revelotest_wpa3"
[ 3671.744438] wlan0: authenticate with 92:83:c4:51:d9:07 (local
address=10:ca:bf:d8:a9:42)
[ 3671.764074] wlan0: send auth to 92:83:c4:51:d9:07 (try 1/3)
[ 3671.780636] wlan0: authenticated
[ 3671.787540] wlan0: associate with 92:83:c4:51:d9:07 (try 1/3)
[ 3671.806248] wlan0: RX AssocResp from 92:83:c4:51:d9:07 (capab=0x431
status=0 aid=1)
[ 3671.830095] cc33xx: HE Disabled
[ 3671.838378] wlan0: associated
[ 3671.884213] cc33xx: Association complete.
[ 3674.859826] wlan0: deauthenticating from 92:83:c4:51:d9:07 by local
choice (Reason: 3=DEAUTH_LEAVING)
s6-rc: info: service wlan0-ipc: stopping
s6-rc: info: service wlan0-ipc successfully stopped
[ 3734.986744] wlan0: authenticate with 92:83:c4:51:d9:07 (local
address=10:ca:bf:d8:a9:42)
[ 3734.996162] wlan0: send auth to 92:83:c4:51:d9:07 (try 1/3)
[ 3735.011860] wlan0: authenticated
[ 3735.016545] wlan0: associate with 92:83:c4:51:d9:07 (try 1/3)
[ 3735.026471] wlan0: RX AssocResp from 92:83:c4:51:d9:07 (capab=0x431
status=0 aid=1)
[ 3735.042411] cc33xx: HE Disabled
[ 3735.047578] wlan0: associated
[ 3735.078918] cc33xx: Association complete.
s6-rc: info: service wlan0-ipc: starting
s6-rc: info: service wlan0-ipc successfully started
Revelo-238494033:/opt/iprf# date
Thu Mar 19 16:33:20 UTC 2026
Revelo-238494033:/opt/iprf# ping google.com
PING google.com (142.251.16.101): 56 data bytes
64 bytes from 142.251.16.101: seq=0 ttl=106 time=45.481 ms


Here is the iwd with debug between those times above:

2026-03-19 16:32:11.994810194  src/agent.c:agent_register() agent
register called
2026-03-19 16:32:11.995138635  src/agent.c:agent_register() agent
:1.69 path /agent/25512
2026-03-19 16:32:11.995280632  src/network.c:network_connect()
2026-03-19 16:32:11.995996237  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:11.996014939  src/network.c:network_connect_psk()
ask_passphrase: true
2026-03-19 16:32:11.996028992  src/agent.c:agent_request_passphrase()
agent 0x1239da8 owner :1.69 path /agent/25512
2026-03-19 16:32:11.996041231  src/agent.c:agent_send_next_request()
send request to :1.69 /agent/25512
2026-03-19 16:32:12.000296406  src/agent.c:agent_receive_reply() agent
0x1239da8 request id 1025
2026-03-19 16:32:12.000339555  src/network.c:passphrase_callback() result 0
2026-03-19 16:32:12.000351054  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:12.000362592  src/network.c:network_generate_sae_pt()
Generating PT for Group 19
2026-03-19 16:32:12.015718354  src/network.c:network_generate_sae_pt()
Generating PT for Group 20
2026-03-19 16:32:12.052851727
src/netconfig.c:netconfig_load_settings() netconfig: Hostname
'Revelo-238494033' will be sent in DHCP requests
2026-03-19 16:32:12.052986234  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:12.052999852  src/pmksa.c:pmksa_cache_get() Returning
entry with PMKID: 92c8499ef9c6ddb8f49d8b883b060964
2026-03-19 16:32:12.053012570
src/network.c:network_set_handshake_secrets_psk() Authenticator is SAE
H2E capable
2026-03-19 16:32:12.053024634  src/netdev.c:netdev_connect_common()
Skipping SAE by using PMKSA cache
2026-03-19 16:32:12.053793862  src/netdev.c:netdev_cqm_rssi_update()
2026-03-19 16:32:12.053821098  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 14
2026-03-19 16:32:12.053832861  src/wiphy.c:wiphy_radio_work_next()
Starting work item 14
2026-03-19 16:32:12.053846435  event: connect-info, ssid:
revelotest_wpa3, bss: 92:83:c4:51:d9:07, signal: -32, load: 122/255
2026-03-19 16:32:12.053857853  event: state, old: autoconnect_full,
new: connecting
2026-03-19 16:32:12.053869652  src/scan.c:scan_periodic_stop()
Stopping periodic scan for wdev 1
2026-03-19 16:32:12.125599088  src/netdev.c:netdev_mlme_notify() MLME
notification New Station(19)
2026-03-19 16:32:12.135283108  src/netdev.c:netdev_mlme_notify() MLME
notification Authenticate(37)
2026-03-19 16:32:12.135335356  src/netdev.c:netdev_authenticate_event()
2026-03-19 16:32:12.167983673  src/netdev.c:netdev_unicast_notify()
Unicast notification Control Port Frame(129)
2026-03-19 16:32:12.168036711  src/netdev.c:netdev_control_port_frame_event()
2026-03-19 16:32:12.190032852  src/netdev.c:netdev_link_notify() event
16 on ifindex 12
2026-03-19 16:32:12.193618871  src/netdev.c:netdev_mlme_notify() MLME
notification Associate(38)
2026-03-19 16:32:12.193653946  src/netdev.c:netdev_associate_event()
2026-03-19 16:32:12.193666320  src/netdev.c:netdev_mlme_notify() MLME
notification Connect(46)
2026-03-19 16:32:12.193776090  src/netdev.c:netdev_connect_event()
2026-03-19 16:32:12.193791228  src/netdev.c:netdev_connect_event()
aborting and ignore_connect_event not set, proceed
2026-03-19 16:32:12.193803752  src/netdev.c:netdev_connect_event()
expect_connect_failure not set, proceed
2026-03-19 16:32:12.193814590  src/netdev.c:parse_request_ies()
2026-03-19 16:32:12.193826954  src/netdev.c:netdev_connect_event()
Request / Response IEs parsed
2026-03-19 16:32:12.193837517  src/netdev.c:netdev_get_oci()
2026-03-19 16:32:12.194171568  src/netdev.c:netdev_get_oci_cb()
Obtained OCI: freq: 2417, width: 1, center1: 2417, center2: 0
2026-03-19 16:32:12.194237614  src/eapol.c:eapol_start()
2026-03-19 16:32:12.194295066  src/station.c:station_handshake_event()
Handshaking
2026-03-19 16:32:12.194440772  src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=12
2026-03-19 16:32:12.199590419  src/netdev.c:netdev_mlme_notify() MLME
notification Control Port TX Status(139)
2026-03-19 16:32:12.207721990  src/netdev.c:netdev_unicast_notify()
Unicast notification Control Port Frame(129)
2026-03-19 16:32:12.208198391  src/netdev.c:netdev_control_port_frame_event()
2026-03-19 16:32:12.211197588  src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=12
2026-03-19 16:32:12.212690815  src/netdev.c:netdev_set_gtk()
ifindex=12 key_idx=1
2026-03-19 16:32:12.213893781  src/netdev.c:netdev_set_igtk()
ifindex=12 key_idx=4
2026-03-19 16:32:12.213921097  src/station.c:station_handshake_event()
Setting keys
2026-03-19 16:32:12.213932490  src/network.c:network_sync_settings()
2026-03-19 16:32:12.213943804  src/netdev.c:netdev_set_tk() ifindex=12 key_idx=0
2026-03-19 16:32:12.217946543  src/netdev.c:netdev_new_group_key_cb()
ifindex: 12, err: 0
2026-03-19 16:32:12.217991667  src/netdev.c:try_handshake_complete()
ptk_installed: 0, gtk_installed: 1, igtk_installed: 0
2026-03-19 16:32:12.224577808
src/netdev.c:netdev_new_group_management_key_cb() ifindex: 12, err: 0
2026-03-19 16:32:12.225200945  src/netdev.c:try_handshake_complete()
ptk_installed: 0, gtk_installed: 1, igtk_installed: 1
2026-03-19 16:32:12.231289987  src/netdev.c:netdev_mlme_notify() MLME
notification Control Port TX Status(139)
2026-03-19 16:32:12.241958631  src/netdev.c:netdev_set_station_cb()
2026-03-19 16:32:12.242003630  src/netdev.c:try_handshake_complete()
ptk_installed: 1, gtk_installed: 1, igtk_installed: 1
2026-03-19 16:32:12.242015794  src/netdev.c:try_handshake_complete()
nhs->complete: 0
2026-03-19 16:32:12.242027822  src/netdev.c:try_handshake_complete()
Invoking handshake_event()
2026-03-19 16:32:12.242040260
src/handshake.c:handshake_state_cache_pmksa() Caching PMKSA for
92:83:c4:51:d9:07
2026-03-19 16:32:12.242052929  src/pmksa.c:pmksa_cache_put() Adding
entry with PMKID: 92c8499ef9c6ddb8f49d8b883b060964
2026-03-19 16:32:12.242132713  src/netdev.c:netdev_connect_ok()
2026-03-19 16:32:12.242145811  src/station.c:station_connect_cb() 12, result: 0
2026-03-19 16:32:12.242156785  src/station.c:station_connect_ok()
2026-03-19 16:32:12.246457569  event: state, old: connecting, new:
connecting (netconfig)
2026-03-19 16:32:12.246499609  src/wiphy.c:wiphy_radio_work_done()
Work item 14 done
2026-03-19 16:32:12.249582540  src/netdev.c:netdev_link_notify() event
16 on ifindex 12
2026-03-19 16:32:12.419283354
src/netconfig.c:netconfig_event_handler() l_netconfig event 0
2026-03-19 16:32:12.419338927
src/netconfig-commit.c:netconfig_commit_print_addrs() installing
address: 10.1.252.26
2026-03-19 16:32:12.764554470  resolvconf: /lib/resolvconf/lglxc a wlan0.dns
2026-03-19 16:32:13.275698489  resolvconf: /lib/resolvconf/lglxc a wlan0.domain
2026-03-19 16:32:13.838269838  event: state, old: connecting
(netconfig), new: connected
2026-03-19 16:32:13.855690037  src/agent.c:agent_disconnect() agent
:1.69 disconnected
2026-03-19 16:32:13.858853112  src/agent.c:agent_free() agent free 0x1239da8
2026-03-19 16:32:13.973265319  src/agent.c:agent_register() agent
register called
2026-03-19 16:32:13.973307858  src/agent.c:agent_register() agent
:1.70 path /agent/25679
2026-03-19 16:32:13.978271704  Error loading
/run/flash_sync/activity_files/iwd//revelotest_wpa3.psk
2026-03-19 16:32:13.978322168  src/station.c:station_reset_connection_state() 12
2026-03-19 16:32:13.978333721  src/station.c:station_roam_state_clear() 12
2026-03-19 16:32:13.978345675
src/netconfig.c:netconfig_event_handler() l_netconfig event 2
2026-03-19 16:32:13.978358303
src/netconfig-commit.c:netconfig_commit_print_addrs() removing
address: 10.1.252.26
2026-03-19 16:32:14.824441314  resolve: /sbin/resolvconf exited with
status (36096).
2026-03-19 16:32:15.192915760  resolve: /sbin/resolvconf exited with
status (36096).
2026-03-19 16:32:15.201143354  event: state, old: connected, new: disconnecting
2026-03-19 16:32:15.288279580  src/netdev.c:netdev_mlme_notify() MLME
notification Del Station(20)
2026-03-19 16:32:15.288332298  src/agent.c:agent_disconnect() agent
:1.70 disconnected
2026-03-19 16:32:15.288344946  src/netdev.c:netdev_mlme_notify() MLME
notification Deauthenticate(39)
2026-03-19 16:32:15.288356210  src/netdev.c:netdev_deauthenticate_event()
2026-03-19 16:32:15.288367733  src/netdev.c:netdev_link_notify() event
16 on ifindex 12
2026-03-19 16:32:15.288378837  src/agent.c:agent_free() agent free 0x1237c60
2026-03-19 16:32:15.288391170  src/netdev.c:netdev_mlme_notify() MLME
notification Disconnect(48)
2026-03-19 16:32:15.288402054  src/netdev.c:netdev_disconnect_event()
2026-03-19 16:32:15.288414007  src/wiphy.c:wiphy_reg_notify()
Notification of command Reg Change(36)
2026-03-19 16:32:15.288425576  src/station.c:station_disconnect_cb()
12, success: 1
2026-03-19 16:32:15.293964876  event: state, old: disconnecting, new:
disconnected
2026-03-19 16:32:15.294043600  event: state, old: disconnected, new:
autoconnect_quick
2026-03-19 16:32:15.294057988  src/scan.c:scan_periodic_start()
Starting periodic scan for wdev 1
2026-03-19 16:32:15.294091229  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 15
2026-03-19 16:32:15.294103247  src/wiphy.c:wiphy_radio_work_next()
Starting work item 15
2026-03-19 16:32:15.316632873  src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
2026-03-19 16:32:15.319342803  src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
2026-03-19 16:32:15.319391661  src/scan.c:scan_periodic_triggered()
Periodic scan triggered for wdev 1
2026-03-19 16:32:16.612572435  src/scan.c:scan_notify() Scan
notification New Scan Results(34)
2026-03-19 16:32:16.613642078  invalid HE capabilities for 5c:e9:31:0d:a3:7c
2026-03-19 16:32:16.615144664  src/scan.c:scan_periodic_rearm() Arming
periodic scan timer: 10
2026-03-19 16:32:16.615177774  src/station.c:station_print_scan_bss()
Processing BSS 'd8:47:32:d9:93:f7' with SSID: , freq: 2427, rank: 591,
strength: -2100, data_rate: 72.2, load: 54/255, clients: 0
2026-03-19 16:32:16.615189953  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:16.615251080  src/station.c:station_print_scan_bss()
Processing BSS '9a:47:32:d9:93:fa' with SSID: revelotest1, freq: 2427,
rank: 591, strength: -2200, data_rate: 72.2, load: 53/255, clients: 17
2026-03-19 16:32:16.615268222  src/station.c:station_print_scan_bss()
Processing BSS '92:83:c4:51:d9:07' with SSID: revelotest_wpa3, freq:
2417, rank: 591, strength: -3200, data_rate: 72.2, load: 61/255,
clients: 1
2026-03-19 16:32:16.615284390  src/station.c:station_print_scan_bss()
Processing BSS '94:a6:7e:f1:9e:70' with SSID: WSLS_TG4, freq: 2447,
rank: 591, strength: -4400, data_rate: 72.2, load: 11/255, clients: 1
2026-03-19 16:32:16.615300613  src/station.c:station_print_scan_bss()
Processing BSS 'f0:2f:74:c5:2d:78' with SSID: WSLS_TG5, freq: 2462,
rank: 591, strength: -5300, data_rate: 72.2, load: 55/255, clients: 1
2026-03-19 16:32:16.615315826  src/station.c:station_print_scan_bss()
Processing BSS 'a0:36:bc:61:1d:88' with SSID: WSLS_TG3, freq: 2447,
rank: 492, strength: -2600, data_rate: 72.2
2026-03-19 16:32:16.615331949  src/station.c:station_print_scan_bss()
Processing BSS '94:83:c4:51:d9:07' with SSID: revelotest_wpa, freq:
2417, rank: 492, strength: -3200, data_rate: 72.2, load: 82/255,
clients: 1
2026-03-19 16:32:16.615524983  src/station.c:station_print_scan_bss()
Processing BSS '9a:83:c4:51:d9:07' with SSID: revelotest_wpa3mixed,
freq: 2417, rank: 492, strength: -3200, data_rate: 72.2, load: 75/255,
clients: 0
2026-03-19 16:32:16.615682452  src/station.c:station_print_scan_bss()
Processing BSS '9e:83:c4:51:d9:07' with SSID: revelotest_wpamixed,
freq: 2417, rank: 492, strength: -3200, data_rate: 72.2, load: 89/255,
clients: 0
2026-03-19 16:32:16.615860799  src/station.c:station_print_scan_bss()
Processing BSS 'd8:ec:5e:99:0e:6c' with SSID: Revelotest4, freq: 2457,
rank: 492, strength: -3400, data_rate: 72.2
2026-03-19 16:32:16.615967195  src/station.c:station_add_seen_bss()
Added new Network "Revelotest4" security psk
2026-03-19 16:32:16.616115880  src/station.c:station_print_scan_bss()
Processing BSS 'de:ec:5e:99:0e:6c' with SSID: , freq: 2457, rank: 492,
strength: -3400, data_rate: 72.2
2026-03-19 16:32:16.616170718  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:16.617018345  src/station.c:station_print_scan_bss()
Processing BSS '18:a6:f7:32:9f:bb' with SSID: WSLS_TG9, freq: 2437,
rank: 492, strength: -3900, data_rate: 72.2
2026-03-19 16:32:16.617037443  src/station.c:station_print_scan_bss()
Processing BSS '96:83:c4:51:d9:07' with SSID: revelotest_wpa2, freq:
2417, rank: 492, strength: -5200, data_rate: 72.2, load: 64/255,
clients: 0
2026-03-19 16:32:16.617052876  src/station.c:station_print_scan_bss()
Processing BSS 'bc:df:58:d0:56:a1' with SSID: WSLS_TG1, freq: 2412,
rank: 492, strength: -5300, data_rate: 72.2
2026-03-19 16:32:16.617084591  src/station.c:station_print_scan_bss()
Processing BSS '5c:e9:31:0d:a3:7c' with SSID: RF_FARM_WIFI, freq:
2462, rank: 492, strength: -5300, data_rate: 72.2
2026-03-19 16:32:16.617100359  src/station.c:station_print_scan_bss()
Processing BSS '28:ee:52:6c:29:87' with SSID: WSLS_TG6, freq: 2457,
rank: 492, strength: -5400, data_rate: 72.2
2026-03-19 16:32:16.617116467  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:97' with SSID: SWAMP, freq: 2412, rank:
492, strength: -5700, data_rate: 72.2, load: 107/255, clients: 0
2026-03-19 16:32:16.617132690  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:98' with SSID: SWAMP-MOBILE, freq:
2412, rank: 492, strength: -5700, data_rate: 72.2, load: 105/255,
clients: 0
2026-03-19 16:32:16.617148988  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:95' with SSID: SWAMP-DEVICES, freq:
2412, rank: 492, strength: -5700, data_rate: 72.2, load: 107/255,
clients: 0
2026-03-19 16:32:16.617165166  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:94' with SSID: SWAMP_GUEST, freq: 2412,
rank: 492, strength: -5800, data_rate: 72.2, load: 105/255, clients: 0
2026-03-19 16:32:16.617181094  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:85' with SSID: WSLS_TG2, freq: 2462,
rank: 492, strength: -6000, data_rate: 72.2, load: 77/255, clients: 1
2026-03-19 16:32:16.617193457  src/station.c:station_add_seen_bss()
Added new Network "WSLS_TG2" security psk
2026-03-19 16:32:16.617208240  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:83' with SSID: , freq: 2462, rank: 492,
strength: -6000, data_rate: 72.2
2026-03-19 16:32:16.617219838  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:16.617273621  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:87' with SSID: , freq: 2462, rank: 492,
strength: -6100, data_rate: 72.2
2026-03-19 16:32:16.617286425  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:16.617301873  src/station.c:station_print_scan_bss()
Processing BSS '88:da:1a:7e:61:ec' with SSID: L2402080530A64, freq:
2412, rank: 443, strength: -3300, data_rate: 65.0
2026-03-19 16:32:16.617314416  src/station.c:station_add_seen_bss()
Added new Network "L2402080530A64" security psk
2026-03-19 16:32:16.617330469  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:14' with SSID: SWAMP_GUEST, freq: 2462,
rank: 443, strength: -5300, data_rate: 65.0, load: 70/255, clients: 0
2026-03-19 16:32:16.617346632  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:19' with SSID: SWAMP-Revelo, freq:
2462, rank: 443, strength: -6100, data_rate: 65.0, load: 70/255,
clients: 0
2026-03-19 16:32:16.617359280  src/station.c:station_add_seen_bss()
Added new Network "SWAMP-Revelo" security psk
2026-03-19 16:32:16.617593299  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:18' with SSID: SWAMP-MOBILE, freq:
2462, rank: 443, strength: -6100, data_rate: 65.0, load: 70/255,
clients: 0
2026-03-19 16:32:16.617723227  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:17' with SSID: SWAMP, freq: 2462, rank:
443, strength: -6200, data_rate: 65.0, load: 70/255, clients: 0
2026-03-19 16:32:16.617839311  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:15' with SSID: SWAMP-DEVICES, freq:
2462, rank: 354, strength: -6600, data_rate: 52.0, load: 70/255,
clients: 0
2026-03-19 16:32:16.618559926  src/station.c:station_print_scan_bss()
Processing BSS 'c4:41:1e:ac:62:b9' with SSID: WSLS_TG7, freq: 2432,
rank: 295, strength: -6800, data_rate: 43.3
2026-03-19 16:32:16.618579178  src/station.c:station_print_scan_bss()
Processing BSS '30:fb:10:e9:77:60' with SSID: L1402480534721, freq:
2412, rank: 177, strength: -7100, data_rate: 26.0
2026-03-19 16:32:16.618595611  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:0e:d4' with SSID: SWAMP_GUEST, freq: 2462,
rank: 177, strength: -7700, data_rate: 21.7, load: 50/255, clients: 0
2026-03-19 16:32:16.618610389  src/station.c:station_print_scan_bss()
Processing BSS '48:b4:24:9e:20:87' with SSID: , freq: 2437, rank: 13,
strength: -8800, data_rate: 2.0
2026-03-19 16:32:16.618622177  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:16.618636845  src/station.c:station_print_scan_bss()
Processing BSS '48:b4:24:9e:20:83' with SSID: , freq: 2437, rank: 13,
strength: -8800, data_rate: 2.0
2026-03-19 16:32:16.618648434  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:16.618659242  src/station.c:station_autoconnect_start()
2026-03-19 16:32:16.618670816  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:16.618683244
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa3
2026-03-19 16:32:16.618696917
src/station.c:station_autoconnect_next() autoconnect:
'92:83:c4:51:d9:07' freq: 2417, rank: 591, strength: -3200
2026-03-19 16:32:16.618710291
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.618722579
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG4
2026-03-19 16:32:16.618736227
src/station.c:station_autoconnect_next() autoconnect:
'94:a6:7e:f1:9e:70' freq: 2447, rank: 591, strength: -4400
2026-03-19 16:32:16.618749560
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.618761899
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest1
2026-03-19 16:32:16.618775472
src/station.c:station_autoconnect_next() autoconnect:
'9a:47:32:d9:93:fa' freq: 2427, rank: 591, strength: -2200
2026-03-19 16:32:16.618788855
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.618801109
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG5
2026-03-19 16:32:16.618814762
src/station.c:station_autoconnect_next() autoconnect:
'f0:2f:74:c5:2d:78' freq: 2462, rank: 591, strength: -5300
2026-03-19 16:32:16.618828090
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.618839679  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:16.618852357
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa3mixed
2026-03-19 16:32:16.618865910
src/station.c:station_autoconnect_next() autoconnect:
'9a:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:16.618879198
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.618891447
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG6
2026-03-19 16:32:16.618905135
src/station.c:station_autoconnect_next() autoconnect:
'28:ee:52:6c:29:87' freq: 2457, rank: 492, strength: -5400
2026-03-19 16:32:16.618918443
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.618930756
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG2
2026-03-19 16:32:16.618944360
src/station.c:station_autoconnect_next() autoconnect:
'c8:e3:06:2b:57:85' freq: 2462, rank: 492, strength: -6000
2026-03-19 16:32:16.618957693
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.618970026
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP_GUEST
2026-03-19 16:32:16.618983614
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:94' freq: 2412, rank: 492, strength: -5800
2026-03-19 16:32:16.618996983
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619009371
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG1
2026-03-19 16:32:16.619023064
src/station.c:station_autoconnect_next() autoconnect:
'bc:df:58:d0:56:a1' freq: 2412, rank: 492, strength: -5300
2026-03-19 16:32:16.619036322
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619048786
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
RF_FARM_WIFI
2026-03-19 16:32:16.619076267
src/station.c:station_autoconnect_next() autoconnect:
'5c:e9:31:0d:a3:7c' freq: 2462, rank: 492, strength: -5300
2026-03-19 16:32:16.619090935
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619103299
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP
2026-03-19 16:32:16.619116957
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:97' freq: 2412, rank: 492, strength: -5700
2026-03-19 16:32:16.619130410
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619143158
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpamixed
2026-03-19 16:32:16.619156766
src/station.c:station_autoconnect_next() autoconnect:
'9e:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:16.619170115
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619182483
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP-DEVICES
2026-03-19 16:32:16.619196036
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:95' freq: 2412, rank: 492, strength: -5700
2026-03-19 16:32:16.619209309
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619221618
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG9
2026-03-19 16:32:16.619235226
src/station.c:station_autoconnect_next() autoconnect:
'18:a6:f7:32:9f:bb' freq: 2437, rank: 492, strength: -3900
2026-03-19 16:32:16.619248489
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619260888
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa2
2026-03-19 16:32:16.619785238
src/station.c:station_autoconnect_next() autoconnect:
'96:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -5200
2026-03-19 16:32:16.619803261
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619816149
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa
2026-03-19 16:32:16.619830062
src/station.c:station_autoconnect_next() autoconnect:
'94:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:16.619843600
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619855144  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:16.619867342
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG3
2026-03-19 16:32:16.619880830
src/station.c:station_autoconnect_next() autoconnect:
'a0:36:bc:61:1d:88' freq: 2447, rank: 492, strength: -2600
2026-03-19 16:32:16.619894219
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619906572
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP-MOBILE
2026-03-19 16:32:16.619920205
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:98' freq: 2412, rank: 492, strength: -5700
2026-03-19 16:32:16.619933553
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619945897
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
Revelotest4
2026-03-19 16:32:16.619959495
src/station.c:station_autoconnect_next() autoconnect:
'd8:ec:5e:99:0e:6c' freq: 2457, rank: 492, strength: -3400
2026-03-19 16:32:16.619973003
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.619985466
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
L2402080530A64
2026-03-19 16:32:16.619999065
src/station.c:station_autoconnect_next() autoconnect:
'88:da:1a:7e:61:ec' freq: 2412, rank: 443, strength: -3300
2026-03-19 16:32:16.620012423
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.620024826
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP-Revelo
2026-03-19 16:32:16.620038409
src/station.c:station_autoconnect_next() autoconnect:
'd8:54:a2:a8:6d:19' freq: 2462, rank: 443, strength: -6100
2026-03-19 16:32:16.620051798
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.620082664
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG7
2026-03-19 16:32:16.620097237
src/station.c:station_autoconnect_next() autoconnect:
'c4:41:1e:ac:62:b9' freq: 2432, rank: 295, strength: -6800
2026-03-19 16:32:16.620110660
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.620123068
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
L1402480534721
2026-03-19 16:32:16.620136571
src/station.c:station_autoconnect_next() autoconnect:
'30:fb:10:e9:77:60' freq: 2412, rank: 177, strength: -7100
2026-03-19 16:32:16.620149925
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:16.620161383  src/wiphy.c:wiphy_radio_work_done()
Work item 15 done
2026-03-19 16:32:26.616437004  src/scan.c:scan_periodic_timeout() 1
2026-03-19 16:32:26.616491636  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 16
2026-03-19 16:32:26.616503760  src/wiphy.c:wiphy_radio_work_next()
Starting work item 16
2026-03-19 16:32:26.638601273  src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
2026-03-19 16:32:26.638653186  src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
2026-03-19 16:32:26.638666009  src/scan.c:scan_periodic_triggered()
Periodic scan triggered for wdev 1
2026-03-19 16:32:27.846425757  lglxc-dhcpd-6: restarting
2026-03-19 16:32:27.850255342  lglxc-dhcpd-4: restarting
2026-03-19 16:32:27.935957019  src/scan.c:scan_notify() Scan
notification New Scan Results(34)
2026-03-19 16:32:27.940338599  invalid HE capabilities for 5c:e9:31:0d:a3:7c
2026-03-19 16:32:27.947682191  src/scan.c:scan_periodic_rearm() Arming
periodic scan timer: 20
2026-03-19 16:32:27.954270951  src/station.c:station_print_scan_bss()
Processing BSS '92:83:c4:51:d9:07' with SSID: revelotest_wpa3, freq:
2417, rank: 591, strength: -3200, data_rate: 72.2, load: 61/255,
clients: 1
2026-03-19 16:32:27.954326038  src/station.c:station_print_scan_bss()
Processing BSS '94:a6:7e:f1:9e:70' with SSID: WSLS_TG4, freq: 2447,
rank: 591, strength: -4400, data_rate: 72.2, load: 13/255, clients: 1
2026-03-19 16:32:27.954343101  src/station.c:station_print_scan_bss()
Processing BSS 'f0:2f:74:c5:2d:78' with SSID: WSLS_TG5, freq: 2462,
rank: 591, strength: -5200, data_rate: 72.2, load: 48/255, clients: 1
2026-03-19 16:32:27.954359334  src/station.c:station_print_scan_bss()
Processing BSS '9a:47:32:d9:93:fa' with SSID: revelotest1, freq: 2427,
rank: 492, strength: -2200, data_rate: 72.2, load: 65/255, clients: 17
2026-03-19 16:32:27.954375067  src/station.c:station_print_scan_bss()
Processing BSS 'd8:47:32:d9:93:f7' with SSID: , freq: 2427, rank: 492,
strength: -2200, data_rate: 72.2, load: 65/255, clients: 0
2026-03-19 16:32:27.954386690  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:27.954401628  src/station.c:station_print_scan_bss()
Processing BSS 'a0:36:bc:61:1d:88' with SSID: WSLS_TG3, freq: 2447,
rank: 492, strength: -2600, data_rate: 72.2
2026-03-19 16:32:27.954417866  src/station.c:station_print_scan_bss()
Processing BSS '94:83:c4:51:d9:07' with SSID: revelotest_wpa, freq:
2417, rank: 492, strength: -3200, data_rate: 72.2, load: 80/255,
clients: 1
2026-03-19 16:32:27.954434249  src/station.c:station_print_scan_bss()
Processing BSS '9a:83:c4:51:d9:07' with SSID: revelotest_wpa3mixed,
freq: 2417, rank: 492, strength: -3200, data_rate: 72.2, load: 79/255,
clients: 0
2026-03-19 16:32:27.954450412  src/station.c:station_print_scan_bss()
Processing BSS '96:83:c4:51:d9:07' with SSID: revelotest_wpa2, freq:
2417, rank: 492, strength: -3200, data_rate: 72.2, load: 74/255,
clients: 0
2026-03-19 16:32:27.954465594  src/station.c:station_print_scan_bss()
Processing BSS 'd8:ec:5e:99:0e:6c' with SSID: Revelotest4, freq: 2457,
rank: 492, strength: -3400, data_rate: 72.2
2026-03-19 16:32:27.954480263  src/station.c:station_print_scan_bss()
Processing BSS 'de:ec:5e:99:0e:6c' with SSID: , freq: 2457, rank: 492,
strength: -3400, data_rate: 72.2
2026-03-19 16:32:27.954491966  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:27.954506894  src/station.c:station_print_scan_bss()
Processing BSS '18:a6:f7:32:9f:bb' with SSID: WSLS_TG9, freq: 2437,
rank: 492, strength: -4000, data_rate: 72.2
2026-03-19 16:32:27.954521892  src/station.c:station_print_scan_bss()
Processing BSS '28:ee:52:6c:29:87' with SSID: WSLS_TG6, freq: 2457,
rank: 492, strength: -4200, data_rate: 72.2
2026-03-19 16:32:27.959190778  src/station.c:station_print_scan_bss()
Processing BSS '9e:83:c4:51:d9:07' with SSID: revelotest_wpamixed,
freq: 2417, rank: 492, strength: -4600, data_rate: 72.2, load:
109/255, clients: 0
2026-03-19 16:32:27.959244210  src/station.c:station_print_scan_bss()
Processing BSS 'f0:b4:d2:8c:a2:f1' with SSID: WSLS_TG8, freq: 2422,
rank: 492, strength: -5300, data_rate: 72.2, load: 64/255, clients: 1
2026-03-19 16:32:27.959257154  src/station.c:station_add_seen_bss()
Added new Network "WSLS_TG8" security psk
2026-03-19 16:32:27.959272296  src/station.c:station_print_scan_bss()
Processing BSS '5c:e9:31:0d:a3:7c' with SSID: RF_FARM_WIFI, freq:
2462, rank: 492, strength: -5300, data_rate: 72.2
2026-03-19 16:32:27.961645809  src/station.c:station_print_scan_bss()
Processing BSS 'bc:df:58:d0:56:a1' with SSID: WSLS_TG1, freq: 2412,
rank: 492, strength: -5400, data_rate: 72.2
2026-03-19 16:32:27.961690943  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:97' with SSID: SWAMP, freq: 2412, rank:
492, strength: -5600, data_rate: 72.2, load: 95/255, clients: 0
2026-03-19 16:32:27.961707776  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:98' with SSID: SWAMP-MOBILE, freq:
2412, rank: 492, strength: -5600, data_rate: 72.2, load: 95/255,
clients: 0
2026-03-19 16:32:27.961724023  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:94' with SSID: SWAMP_GUEST, freq: 2412,
rank: 492, strength: -5600, data_rate: 72.2, load: 95/255, clients: 0
2026-03-19 16:32:27.961740241  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:95' with SSID: SWAMP-DEVICES, freq:
2412, rank: 492, strength: -5600, data_rate: 72.2, load: 95/255,
clients: 0
2026-03-19 16:32:27.961755059  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:83' with SSID: , freq: 2462, rank: 492,
strength: -6000, data_rate: 72.2
2026-03-19 16:32:27.961766638  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:27.961781246  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:87' with SSID: , freq: 2462, rank: 492,
strength: -6100, data_rate: 72.2
2026-03-19 16:32:27.961792799  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:27.961808782  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:85' with SSID: WSLS_TG2, freq: 2462,
rank: 492, strength: -6300, data_rate: 72.2, load: 77/255, clients: 1
2026-03-19 16:32:27.961823980  src/station.c:station_print_scan_bss()
Processing BSS '88:da:1a:7e:61:ec' with SSID: L2402080530A64, freq:
2412, rank: 443, strength: -3300, data_rate: 65.0
2026-03-19 16:32:27.961840033  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:14' with SSID: SWAMP_GUEST, freq: 2462,
rank: 443, strength: -5200, data_rate: 65.0, load: 70/255, clients: 0
2026-03-19 16:32:27.965197432  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:19' with SSID: SWAMP-Revelo, freq:
2462, rank: 443, strength: -6100, data_rate: 65.0, load: 70/255,
clients: 0
2026-03-19 16:32:27.965247545  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:15' with SSID: SWAMP-DEVICES, freq:
2462, rank: 443, strength: -6200, data_rate: 65.0, load: 70/255,
clients: 0
2026-03-19 16:32:27.965264302  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:18' with SSID: SWAMP-MOBILE, freq:
2462, rank: 443, strength: -6200, data_rate: 65.0, load: 70/255,
clients: 0
2026-03-19 16:32:27.965280595  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:17' with SSID: SWAMP, freq: 2462, rank:
443, strength: -6200, data_rate: 65.0, load: 70/255, clients: 0
2026-03-19 16:32:27.965336913  src/station.c:station_print_scan_bss()
Processing BSS 'c4:41:1e:ac:62:b9' with SSID: WSLS_TG7, freq: 2432,
rank: 295, strength: -6800, data_rate: 43.3
2026-03-19 16:32:27.965352640  src/station.c:station_print_scan_bss()
Processing BSS '30:fb:10:e9:77:60' with SSID: L1402480534721, freq:
2412, rank: 177, strength: -7200, data_rate: 26.0
2026-03-19 16:32:27.965368728  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:0e:d4' with SSID: SWAMP_GUEST, freq: 2462,
rank: 177, strength: -7700, data_rate: 21.7, load: 50/255, clients: 0
2026-03-19 16:32:27.965384676  src/station.c:station_print_scan_bss()
Processing BSS '48:b4:24:9e:20:85' with SSID: booster, freq: 2437,
rank: 90, strength: -8300, data_rate: 11.0, load: 24/255, clients: 1
2026-03-19 16:32:27.965397044  src/station.c:station_add_seen_bss()
Added new Network "booster" security psk
2026-03-19 16:32:27.965411582  src/station.c:station_print_scan_bss()
Processing BSS '48:b4:24:9e:20:87' with SSID: , freq: 2437, rank: 75,
strength: -8400, data_rate: 11.0
2026-03-19 16:32:27.965423076  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:27.965437734  src/station.c:station_print_scan_bss()
Processing BSS '48:b4:24:9e:20:83' with SSID: , freq: 2437, rank: 75,
strength: -8400, data_rate: 11.0
2026-03-19 16:32:27.965449257  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:27.965464445  src/station.c:station_print_scan_bss()
Processing BSS 'd8:7a:3b:af:93:5c' with SSID: L1402480534FB8, freq:
2412, rank: 13, strength: -8800, data_rate: 2.0
2026-03-19 16:32:27.965477049  src/station.c:station_add_seen_bss()
Added new Network "L1402480534FB8" security psk
2026-03-19 16:32:27.970364974  src/station.c:station_autoconnect_start()
2026-03-19 16:32:27.970415813  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:27.970429091
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa3
2026-03-19 16:32:27.971789126
src/station.c:station_autoconnect_next() autoconnect:
'92:83:c4:51:d9:07' freq: 2417, rank: 591, strength: -3200
2026-03-19 16:32:27.971816702
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.971942635
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG4
2026-03-19 16:32:27.971958648
src/station.c:station_autoconnect_next() autoconnect:
'94:a6:7e:f1:9e:70' freq: 2447, rank: 591, strength: -4400
2026-03-19 16:32:27.971972481
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.971984894
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG5
2026-03-19 16:32:27.971998683
src/station.c:station_autoconnect_next() autoconnect:
'f0:2f:74:c5:2d:78' freq: 2462, rank: 591, strength: -5200
2026-03-19 16:32:27.972012106
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972023724  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:27.972036477
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa3mixed
2026-03-19 16:32:27.972050041
src/station.c:station_autoconnect_next() autoconnect:
'9a:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:27.972123191
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972137874
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG6
2026-03-19 16:32:27.972151827
src/station.c:station_autoconnect_next() autoconnect:
'28:ee:52:6c:29:87' freq: 2457, rank: 492, strength: -4200
2026-03-19 16:32:27.972165205
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972177418
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG2
2026-03-19 16:32:27.972190936
src/station.c:station_autoconnect_next() autoconnect:
'c8:e3:06:2b:57:85' freq: 2462, rank: 492, strength: -6300
2026-03-19 16:32:27.972204365
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972216693
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP_GUEST
2026-03-19 16:32:27.972230316
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:94' freq: 2412, rank: 492, strength: -5600
2026-03-19 16:32:27.972243794
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972255948
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG1
2026-03-19 16:32:27.972269546
src/station.c:station_autoconnect_next() autoconnect:
'bc:df:58:d0:56:a1' freq: 2412, rank: 492, strength: -5400
2026-03-19 16:32:27.972282879
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972295087
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest1
2026-03-19 16:32:27.972308655
src/station.c:station_autoconnect_next() autoconnect:
'9a:47:32:d9:93:fa' freq: 2427, rank: 492, strength: -2200
2026-03-19 16:32:27.972322519
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972334892
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
RF_FARM_WIFI
2026-03-19 16:32:27.972348485
src/station.c:station_autoconnect_next() autoconnect:
'5c:e9:31:0d:a3:7c' freq: 2462, rank: 492, strength: -5300
2026-03-19 16:32:27.972361708
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972374132
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG8
2026-03-19 16:32:27.972387725
src/station.c:station_autoconnect_next() autoconnect:
'f0:b4:d2:8c:a2:f1' freq: 2422, rank: 492, strength: -5300
2026-03-19 16:32:27.972400993
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972413186
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP
2026-03-19 16:32:27.972426644
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:97' freq: 2412, rank: 492, strength: -5600
2026-03-19 16:32:27.972439933
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972452561
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpamixed
2026-03-19 16:32:27.972466154
src/station.c:station_autoconnect_next() autoconnect:
'9e:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -4600
2026-03-19 16:32:27.972479467
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972491846
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP-DEVICES
2026-03-19 16:32:27.972505309
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:95' freq: 2412, rank: 492, strength: -5600
2026-03-19 16:32:27.972519217
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972531400
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG9
2026-03-19 16:32:27.972544908
src/station.c:station_autoconnect_next() autoconnect:
'18:a6:f7:32:9f:bb' freq: 2437, rank: 492, strength: -4000
2026-03-19 16:32:27.972558251
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972570685
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa2
2026-03-19 16:32:27.972584228
src/station.c:station_autoconnect_next() autoconnect:
'96:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:27.972597516
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.972609984
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa
2026-03-19 16:32:27.974774850
src/station.c:station_autoconnect_next() autoconnect:
'94:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:27.974814315
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.974826568  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:27.974839022
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG3
2026-03-19 16:32:27.974852650
src/station.c:station_autoconnect_next() autoconnect:
'a0:36:bc:61:1d:88' freq: 2447, rank: 492, strength: -2600
2026-03-19 16:32:27.974865978
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.974878431
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP-MOBILE
2026-03-19 16:32:27.974892064
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:98' freq: 2412, rank: 492, strength: -5600
2026-03-19 16:32:27.974905523
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.974917866
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
Revelotest4
2026-03-19 16:32:27.974931404
src/station.c:station_autoconnect_next() autoconnect:
'd8:ec:5e:99:0e:6c' freq: 2457, rank: 492, strength: -3400
2026-03-19 16:32:27.974944717
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.974957096
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
L2402080530A64
2026-03-19 16:32:27.974970734
src/station.c:station_autoconnect_next() autoconnect:
'88:da:1a:7e:61:ec' freq: 2412, rank: 443, strength: -3300
2026-03-19 16:32:27.974984087
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.974996460
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP-Revelo
2026-03-19 16:32:27.975009988
src/station.c:station_autoconnect_next() autoconnect:
'd8:54:a2:a8:6d:19' freq: 2462, rank: 443, strength: -6100
2026-03-19 16:32:27.975023297
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.975035545
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG7
2026-03-19 16:32:27.975049143
src/station.c:station_autoconnect_next() autoconnect:
'c4:41:1e:ac:62:b9' freq: 2432, rank: 295, strength: -6800
2026-03-19 16:32:27.975090752
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.975105200
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
L1402480534721
2026-03-19 16:32:27.975119079
src/station.c:station_autoconnect_next() autoconnect:
'30:fb:10:e9:77:60' freq: 2412, rank: 177, strength: -7200
2026-03-19 16:32:27.975132557
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.975144820
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
booster
2026-03-19 16:32:27.975158403
src/station.c:station_autoconnect_next() autoconnect:
'48:b4:24:9e:20:85' freq: 2437, rank: 90, strength: -8300
2026-03-19 16:32:27.975171681
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.975184255
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
L1402480534FB8
2026-03-19 16:32:27.975197748
src/station.c:station_autoconnect_next() autoconnect:
'd8:7a:3b:af:93:5c' freq: 2412, rank: 13, strength: -8800
2026-03-19 16:32:27.975211066
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:27.975222345  src/wiphy.c:wiphy_radio_work_done()
Work item 16 done
2026-03-19 16:32:47.951927747  src/scan.c:scan_periodic_timeout() 1
2026-03-19 16:32:47.951980066  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 17
2026-03-19 16:32:47.951992249  src/wiphy.c:wiphy_radio_work_next()
Starting work item 17
2026-03-19 16:32:47.972474811  src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
2026-03-19 16:32:47.972525415  src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
2026-03-19 16:32:47.972538103  src/scan.c:scan_periodic_triggered()
Periodic scan triggered for wdev 1
2026-03-19 16:32:49.267560519  src/scan.c:scan_notify() Scan
notification New Scan Results(34)
2026-03-19 16:32:49.268503506  invalid HE capabilities for 5c:e9:31:0d:a3:7c
2026-03-19 16:32:49.269172374  src/scan.c:scan_periodic_rearm() Arming
periodic scan timer: 40
2026-03-19 16:32:49.271502656  src/station.c:station_print_scan_bss()
Processing BSS '9a:47:32:d9:93:fa' with SSID: revelotest1, freq: 2427,
rank: 591, strength: -3200, data_rate: 72.2, load: 41/255, clients: 17
2026-03-19 16:32:49.271547310  src/station.c:station_print_scan_bss()
Processing BSS 'd8:47:32:d9:93:f7' with SSID: , freq: 2427, rank: 591,
strength: -3800, data_rate: 72.2, load: 41/255, clients: 0
2026-03-19 16:32:49.271559543  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:49.271575651  src/station.c:station_print_scan_bss()
Processing BSS '94:a6:7e:f1:9e:70' with SSID: WSLS_TG4, freq: 2447,
rank: 591, strength: -4400, data_rate: 72.2, load: 11/255, clients: 1
2026-03-19 16:32:49.271591604  src/station.c:station_print_scan_bss()
Processing BSS 'f0:2f:74:c5:2d:78' with SSID: WSLS_TG5, freq: 2462,
rank: 591, strength: -5300, data_rate: 72.2, load: 42/255, clients: 1
2026-03-19 16:32:49.271606647  src/station.c:station_print_scan_bss()
Processing BSS 'a0:36:bc:61:1d:88' with SSID: WSLS_TG3, freq: 2447,
rank: 492, strength: -2500, data_rate: 72.2
2026-03-19 16:32:49.271622815  src/station.c:station_print_scan_bss()
Processing BSS '94:83:c4:51:d9:07' with SSID: revelotest_wpa, freq:
2417, rank: 492, strength: -3200, data_rate: 72.2, load: 79/255,
clients: 1
2026-03-19 16:32:49.271639148  src/station.c:station_print_scan_bss()
Processing BSS '9a:83:c4:51:d9:07' with SSID: revelotest_wpa3mixed,
freq: 2417, rank: 492, strength: -3200, data_rate: 72.2, load: 72/255,
clients: 0
2026-03-19 16:32:49.271655406  src/station.c:station_print_scan_bss()
Processing BSS '9e:83:c4:51:d9:07' with SSID: revelotest_wpamixed,
freq: 2417, rank: 492, strength: -3200, data_rate: 72.2, load: 69/255,
clients: 0
2026-03-19 16:32:49.271671634  src/station.c:station_print_scan_bss()
Processing BSS '92:83:c4:51:d9:07' with SSID: revelotest_wpa3, freq:
2417, rank: 492, strength: -3200, data_rate: 72.2, load: 92/255,
clients: 0
2026-03-19 16:32:49.271687737  src/station.c:station_print_scan_bss()
Processing BSS '96:83:c4:51:d9:07' with SSID: revelotest_wpa2, freq:
2417, rank: 492, strength: -3200, data_rate: 72.2, load: 78/255,
clients: 0
2026-03-19 16:32:49.271702805  src/station.c:station_print_scan_bss()
Processing BSS 'd8:ec:5e:99:0e:6c' with SSID: Revelotest4, freq: 2457,
rank: 492, strength: -3400, data_rate: 72.2
2026-03-19 16:32:49.271717478  src/station.c:station_print_scan_bss()
Processing BSS 'de:ec:5e:99:0e:6c' with SSID: , freq: 2457, rank: 492,
strength: -3400, data_rate: 72.2
2026-03-19 16:32:49.271729286  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:49.271744204  src/station.c:station_print_scan_bss()
Processing BSS '18:a6:f7:32:9f:bb' with SSID: WSLS_TG9, freq: 2437,
rank: 492, strength: -3900, data_rate: 72.2
2026-03-19 16:32:49.272635878  src/station.c:station_print_scan_bss()
Processing BSS '28:ee:52:6c:29:87' with SSID: WSLS_TG6, freq: 2457,
rank: 492, strength: -4400, data_rate: 72.2
2026-03-19 16:32:49.272662140  src/station.c:station_print_scan_bss()
Processing BSS '5c:e9:31:0d:a3:7c' with SSID: RF_FARM_WIFI, freq:
2462, rank: 492, strength: -5200, data_rate: 72.2
2026-03-19 16:32:49.272678503  src/station.c:station_print_scan_bss()
Processing BSS 'bc:df:58:d0:56:a1' with SSID: WSLS_TG1, freq: 2412,
rank: 492, strength: -5400, data_rate: 72.2
2026-03-19 16:32:49.272810491  src/station.c:station_print_scan_bss()
Processing BSS 'f0:b4:d2:8c:a2:f1' with SSID: WSLS_TG8, freq: 2422,
rank: 492, strength: -5600, data_rate: 72.2, load: 65/255, clients: 1
2026-03-19 16:32:49.272828308  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:97' with SSID: SWAMP, freq: 2412, rank:
492, strength: -5600, data_rate: 72.2, load: 95/255, clients: 0
2026-03-19 16:32:49.272844776  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:98' with SSID: SWAMP-MOBILE, freq:
2412, rank: 492, strength: -5600, data_rate: 72.2, load: 95/255,
clients: 0
2026-03-19 16:32:49.272860949  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:95' with SSID: SWAMP-DEVICES, freq:
2412, rank: 492, strength: -5600, data_rate: 72.2, load: 95/255,
clients: 0
2026-03-19 16:32:49.272877067  src/station.c:station_print_scan_bss()
Processing BSS 'a4:c7:f6:f3:a8:94' with SSID: SWAMP_GUEST, freq: 2412,
rank: 492, strength: -5700, data_rate: 72.2, load: 95/255, clients: 0
2026-03-19 16:32:49.272892925  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:85' with SSID: WSLS_TG2, freq: 2462,
rank: 492, strength: -6000, data_rate: 72.2, load: 78/255, clients: 1
2026-03-19 16:32:49.272907633  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:87' with SSID: , freq: 2462, rank: 492,
strength: -6000, data_rate: 72.2
2026-03-19 16:32:49.272919161  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:49.272933869  src/station.c:station_print_scan_bss()
Processing BSS 'c8:e3:06:2b:57:83' with SSID: , freq: 2462, rank: 492,
strength: -6000, data_rate: 72.2
2026-03-19 16:32:49.272945328  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:49.272960551  src/station.c:station_print_scan_bss()
Processing BSS '88:da:1a:7e:61:ec' with SSID: L2402080530A64, freq:
2412, rank: 443, strength: -3300, data_rate: 65.0
2026-03-19 16:32:49.273209754  src/station.c:station_print_scan_bss()
Processing BSS '88:da:1a:7e:67:94' with SSID: L24019805308EF, freq:
2412, rank: 443, strength: -4100, data_rate: 65.0
2026-03-19 16:32:49.273337977  src/station.c:station_add_seen_bss()
Added new Network "L24019805308EF" security psk
2026-03-19 16:32:49.273469985  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:14' with SSID: SWAMP_GUEST, freq: 2462,
rank: 443, strength: -5300, data_rate: 65.0, load: 65/255, clients: 0
2026-03-19 16:32:49.273592584  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:19' with SSID: SWAMP-Revelo, freq:
2462, rank: 443, strength: -6200, data_rate: 65.0, load: 65/255,
clients: 0
2026-03-19 16:32:49.274922155  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:15' with SSID: SWAMP-DEVICES, freq:
2462, rank: 443, strength: -6200, data_rate: 65.0, load: 65/255,
clients: 0
2026-03-19 16:32:49.274942913  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:18' with SSID: SWAMP-MOBILE, freq:
2462, rank: 443, strength: -6200, data_rate: 65.0, load: 65/255,
clients: 0
2026-03-19 16:32:49.274959336  src/station.c:station_print_scan_bss()
Processing BSS 'd8:54:a2:a8:6d:17' with SSID: SWAMP, freq: 2462, rank:
443, strength: -6200, data_rate: 65.0, load: 65/255, clients: 0
2026-03-19 16:32:49.274975329  src/station.c:station_print_scan_bss()
Processing BSS '28:80:a2:3d:aa:75' with SSID: Verizon-MiFi8800L-AA74,
freq: 2437, rank: 443, strength: -6500, data_rate: 65.0
2026-03-19 16:32:49.274988347  src/station.c:station_add_seen_bss()
Added new Network "Verizon-MiFi8800L-AA74" security psk
2026-03-19 16:32:49.275003510  src/station.c:station_print_scan_bss()
Processing BSS '30:fb:10:e9:77:60' with SSID: L1402480534721, freq:
2412, rank: 177, strength: -7200, data_rate: 26.0
2026-03-19 16:32:49.275018333  src/station.c:station_print_scan_bss()
Processing BSS '48:b4:24:9e:20:87' with SSID: , freq: 2437, rank: 75,
strength: -8400, data_rate: 11.0
2026-03-19 16:32:49.275029946  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:49.275045699  src/station.c:station_print_scan_bss()
Processing BSS '48:b4:24:9e:20:85' with SSID: booster, freq: 2437,
rank: 59, strength: -8200, data_rate: 7.2, load: 24/255, clients: 1
2026-03-19 16:32:49.275076845  src/station.c:station_print_scan_bss()
Processing BSS '48:b4:24:9e:20:83' with SSID: , freq: 2437, rank: 49,
strength: -8200, data_rate: 7.2
2026-03-19 16:32:49.275089689  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2026-03-19 16:32:49.275104857  src/station.c:station_print_scan_bss()
Processing BSS 'd8:7a:3b:af:93:5c' with SSID: L1402480534FB8, freq:
2412, rank: 13, strength: -8800, data_rate: 2.0
2026-03-19 16:32:49.275117700  src/station.c:process_network() No
remaining BSSs for SSID: WSLS_TG7 -- Removing network
2026-03-19 16:32:49.275128739  src/station.c:station_autoconnect_start()
2026-03-19 16:32:49.275140967
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG4
2026-03-19 16:32:49.275154555
src/station.c:station_autoconnect_next() autoconnect:
'94:a6:7e:f1:9e:70' freq: 2447, rank: 591, strength: -4400
2026-03-19 16:32:49.275167893
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275180252
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest1
2026-03-19 16:32:49.275193915
src/station.c:station_autoconnect_next() autoconnect:
'9a:47:32:d9:93:fa' freq: 2427, rank: 591, strength: -3200
2026-03-19 16:32:49.275207458
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275219657
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG5
2026-03-19 16:32:49.275233235
src/station.c:station_autoconnect_next() autoconnect:
'f0:2f:74:c5:2d:78' freq: 2462, rank: 591, strength: -5300
2026-03-19 16:32:49.275246568
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275258157  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:49.275270695
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa3mixed
2026-03-19 16:32:49.275284178
src/station.c:station_autoconnect_next() autoconnect:
'9a:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:49.275297602
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275309220  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:49.275321703
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa3
2026-03-19 16:32:49.275335272
src/station.c:station_autoconnect_next() autoconnect:
'92:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:49.275348535
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275360813
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG6
2026-03-19 16:32:49.275374367
src/station.c:station_autoconnect_next() autoconnect:
'28:ee:52:6c:29:87' freq: 2457, rank: 492, strength: -4400
2026-03-19 16:32:49.275387715
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275400028
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG2
2026-03-19 16:32:49.275413556
src/station.c:station_autoconnect_next() autoconnect:
'c8:e3:06:2b:57:85' freq: 2462, rank: 492, strength: -6000
2026-03-19 16:32:49.275427065
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275439313
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP_GUEST
2026-03-19 16:32:49.275452841
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:94' freq: 2412, rank: 492, strength: -5700
2026-03-19 16:32:49.275466140
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275478398
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG1
2026-03-19 16:32:49.275491951
src/station.c:station_autoconnect_next() autoconnect:
'bc:df:58:d0:56:a1' freq: 2412, rank: 492, strength: -5400
2026-03-19 16:32:49.275505305
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275517623
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
RF_FARM_WIFI
2026-03-19 16:32:49.275531191
src/station.c:station_autoconnect_next() autoconnect:
'5c:e9:31:0d:a3:7c' freq: 2462, rank: 492, strength: -5200
2026-03-19 16:32:49.275544439
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275556703
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG8
2026-03-19 16:32:49.275570206
src/station.c:station_autoconnect_next() autoconnect:
'f0:b4:d2:8c:a2:f1' freq: 2422, rank: 492, strength: -5600
2026-03-19 16:32:49.275583529
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275595708
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP
2026-03-19 16:32:49.275609256
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:97' freq: 2412, rank: 492, strength: -5600
2026-03-19 16:32:49.275622544
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275750853
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpamixed
2026-03-19 16:32:49.275766885
src/station.c:station_autoconnect_next() autoconnect:
'9e:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:49.275780484
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275792967
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP-DEVICES
2026-03-19 16:32:49.275806740
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:95' freq: 2412, rank: 492, strength: -5600
2026-03-19 16:32:49.275820054
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275832132
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG9
2026-03-19 16:32:49.275845705
src/station.c:station_autoconnect_next() autoconnect:
'18:a6:f7:32:9f:bb' freq: 2437, rank: 492, strength: -3900
2026-03-19 16:32:49.275858988
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275871807
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa2
2026-03-19 16:32:49.275885360
src/station.c:station_autoconnect_next() autoconnect:
'96:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:49.275898633
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275911082
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
revelotest_wpa
2026-03-19 16:32:49.275924670
src/station.c:station_autoconnect_next() autoconnect:
'94:83:c4:51:d9:07' freq: 2417, rank: 492, strength: -3200
2026-03-19 16:32:49.275937973
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.275949597  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:32:49.275961700
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
WSLS_TG3
2026-03-19 16:32:49.275975213
src/station.c:station_autoconnect_next() autoconnect:
'a0:36:bc:61:1d:88' freq: 2447, rank: 492, strength: -2500
2026-03-19 16:32:49.275988567
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.276000915
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP-MOBILE
2026-03-19 16:32:49.276014498
src/station.c:station_autoconnect_next() autoconnect:
'a4:c7:f6:f3:a8:98' freq: 2412, rank: 492, strength: -5600
2026-03-19 16:32:49.276027861
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.276040105
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
Revelotest4
2026-03-19 16:32:49.276053578
src/station.c:station_autoconnect_next() autoconnect:
'd8:ec:5e:99:0e:6c' freq: 2457, rank: 492, strength: -3400
2026-03-19 16:32:49.276079910
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.276093113
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
L2402080530A64
2026-03-19 16:32:49.276106826
src/station.c:station_autoconnect_next() autoconnect:
'88:da:1a:7e:61:ec' freq: 2412, rank: 443, strength: -3300
2026-03-19 16:32:49.276203819
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.276218537
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
L24019805308EF
2026-03-19 16:32:49.276232535
src/station.c:station_autoconnect_next() autoconnect:
'88:da:1a:7e:67:94' freq: 2412, rank: 443, strength: -4100
2026-03-19 16:32:49.276245843
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.276258271
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
SWAMP-Revelo
2026-03-19 16:32:49.276271785
src/station.c:station_autoconnect_next() autoconnect:
'd8:54:a2:a8:6d:19' freq: 2462, rank: 443, strength: -6200
2026-03-19 16:32:49.276285118
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.276297891
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
Verizon-MiFi8800L-AA74
2026-03-19 16:32:49.276311420
src/station.c:station_autoconnect_next() autoconnect:
'28:80:a2:3d:aa:75' freq: 2437, rank: 443, strength: -6500
2026-03-19 16:32:49.276324853
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.276337356
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
L1402480534721
2026-03-19 16:32:49.276350904
src/station.c:station_autoconnect_next() autoconnect:
'30:fb:10:e9:77:60' freq: 2412, rank: 177, strength: -7200
2026-03-19 16:32:49.276364298
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.276795057
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
booster
2026-03-19 16:32:49.276812674
src/station.c:station_autoconnect_next() autoconnect:
'48:b4:24:9e:20:85' freq: 2437, rank: 59, strength: -8200
2026-03-19 16:32:49.276826352
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.278134492
src/station.c:station_autoconnect_next() autoconnect: Trying SSID:
L1402480534FB8
2026-03-19 16:32:49.278152370
src/station.c:station_autoconnect_next() autoconnect:
'd8:7a:3b:af:93:5c' freq: 2412, rank: 13, strength: -8800
2026-03-19 16:32:49.278166263
src/station.c:station_autoconnect_next() autoconnect:
network_autoconnect: No such file or directory (-2)
2026-03-19 16:32:49.278178171  src/wiphy.c:wiphy_radio_work_done()
Work item 17 done
2026-03-19 16:33:15.260696473  src/agent.c:agent_register() agent
register called
2026-03-19 16:33:15.261216649  src/agent.c:agent_register() agent
:1.71 path /agent/27710
2026-03-19 16:33:15.261568293  src/network.c:network_connect()
2026-03-19 16:33:15.261584786  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:33:15.261596849  src/network.c:network_connect_psk()
ask_passphrase: true
2026-03-19 16:33:15.261662930  src/agent.c:agent_request_passphrase()
agent 0x1264568 owner :1.71 path /agent/27710
2026-03-19 16:33:15.261862681  src/agent.c:agent_send_next_request()
send request to :1.71 /agent/27710
2026-03-19 16:33:15.264424409  src/agent.c:agent_receive_reply() agent
0x1264568 request id 1201
2026-03-19 16:33:15.264463968  src/network.c:passphrase_callback() result 0
2026-03-19 16:33:15.264476182  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:33:15.264488195  src/network.c:network_generate_sae_pt()
Generating PT for Group 19
2026-03-19 16:33:15.269324122  src/network.c:network_generate_sae_pt()
Generating PT for Group 20
2026-03-19 16:33:15.287467279
src/netconfig.c:netconfig_load_settings() netconfig: Hostname
'Revelo-238494033' will be sent in DHCP requests
2026-03-19 16:33:15.287515942  src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
2026-03-19 16:33:15.287529230  src/pmksa.c:pmksa_cache_get() Returning
entry with PMKID: 92c8499ef9c6ddb8f49d8b883b060964
2026-03-19 16:33:15.287541859
src/network.c:network_set_handshake_secrets_psk() Authenticator is SAE
H2E capable
2026-03-19 16:33:15.287554112  src/netdev.c:netdev_connect_common()
Skipping SAE by using PMKSA cache
2026-03-19 16:33:15.287564975  src/netdev.c:netdev_cqm_rssi_update()
2026-03-19 16:33:15.287576639  src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 18
2026-03-19 16:33:15.287588132  src/wiphy.c:wiphy_radio_work_next()
Starting work item 18
2026-03-19 16:33:15.287601100  event: connect-info, ssid:
revelotest_wpa3, bss: 92:83:c4:51:d9:07, signal: -32, load: 92/255
2026-03-19 16:33:15.287613323  event: state, old: autoconnect_full,
new: connecting
2026-03-19 16:33:15.287625092  src/scan.c:scan_periodic_stop()
Stopping periodic scan for wdev 1
2026-03-19 16:33:15.342322574  src/netdev.c:netdev_mlme_notify() MLME
notification New Station(19)
2026-03-19 16:33:15.355437915  src/netdev.c:netdev_mlme_notify() MLME
notification Authenticate(37)
2026-03-19 16:33:15.355485959  src/netdev.c:netdev_authenticate_event()
2026-03-19 16:33:15.375611462  src/netdev.c:netdev_unicast_notify()
Unicast notification Control Port Frame(129)
2026-03-19 16:33:15.375657085  src/netdev.c:netdev_control_port_frame_event()
2026-03-19 16:33:15.390819794  src/netdev.c:netdev_link_notify() event
16 on ifindex 12
2026-03-19 16:33:15.391159335  src/netdev.c:netdev_mlme_notify() MLME
notification Associate(38)
2026-03-19 16:33:15.391175938  src/netdev.c:netdev_associate_event()
2026-03-19 16:33:15.391295351  src/netdev.c:netdev_mlme_notify() MLME
notification Connect(46)
2026-03-19 16:33:15.391355677  src/netdev.c:netdev_connect_event()
2026-03-19 16:33:15.391410939  src/netdev.c:netdev_connect_event()
aborting and ignore_connect_event not set, proceed
2026-03-19 16:33:15.391465876  src/netdev.c:netdev_connect_event()
expect_connect_failure not set, proceed
2026-03-19 16:33:15.391516244  src/netdev.c:parse_request_ies()
2026-03-19 16:33:15.391613015  src/netdev.c:netdev_connect_event()
Request / Response IEs parsed
2026-03-19 16:33:15.391668172  src/netdev.c:netdev_get_oci()
2026-03-19 16:33:15.391949117  src/netdev.c:netdev_get_oci_cb()
Obtained OCI: freq: 2417, width: 1, center1: 2417, center2: 0
2026-03-19 16:33:15.392007099  src/eapol.c:eapol_start()
2026-03-19 16:33:15.392113363  src/station.c:station_handshake_event()
Handshaking
2026-03-19 16:33:15.392373471  src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=12
2026-03-19 16:33:15.396331129  src/netdev.c:netdev_mlme_notify() MLME
notification Control Port TX Status(139)
2026-03-19 16:33:15.398608553  src/netdev.c:netdev_unicast_notify()
Unicast notification Control Port Frame(129)
2026-03-19 16:33:15.398709474  src/netdev.c:netdev_control_port_frame_event()
2026-03-19 16:33:15.401140871  src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=12
2026-03-19 16:33:15.402013456  src/netdev.c:netdev_set_gtk()
ifindex=12 key_idx=1
2026-03-19 16:33:15.402258950  src/netdev.c:netdev_set_igtk()
ifindex=12 key_idx=4
2026-03-19 16:33:15.402341949  src/station.c:station_handshake_event()
Setting keys
2026-03-19 16:33:15.402395301  src/network.c:network_sync_settings()
2026-03-19 16:33:15.403131506  src/netdev.c:netdev_set_tk() ifindex=12 key_idx=0
2026-03-19 16:33:15.408126025  src/netdev.c:netdev_new_group_key_cb()
ifindex: 12, err: 0
2026-03-19 16:33:15.408171084  src/netdev.c:try_handshake_complete()
ptk_installed: 0, gtk_installed: 1, igtk_installed: 0
2026-03-19 16:33:15.412900886
src/netdev.c:netdev_new_group_management_key_cb() ifindex: 12, err: 0
2026-03-19 16:33:15.413886145  src/netdev.c:try_handshake_complete()
ptk_installed: 0, gtk_installed: 1, igtk_installed: 1
2026-03-19 16:33:15.417942020  src/netdev.c:netdev_mlme_notify() MLME
notification Control Port TX Status(139)
2026-03-19 16:33:15.423598455  src/netdev.c:netdev_set_station_cb()
2026-03-19 16:33:15.424338439  src/netdev.c:try_handshake_complete()
ptk_installed: 1, gtk_installed: 1, igtk_installed: 1
2026-03-19 16:33:15.424359116  src/netdev.c:try_handshake_complete()
nhs->complete: 0
2026-03-19 16:33:15.424371464  src/netdev.c:try_handshake_complete()
Invoking handshake_event()
2026-03-19 16:33:15.424384507
src/handshake.c:handshake_state_cache_pmksa() Caching PMKSA for
92:83:c4:51:d9:07
2026-03-19 16:33:15.424397485  src/pmksa.c:pmksa_cache_put() Adding
entry with PMKID: 92c8499ef9c6ddb8f49d8b883b060964
2026-03-19 16:33:15.424408314  src/netdev.c:netdev_connect_ok()
2026-03-19 16:33:15.424419567  src/station.c:station_connect_cb() 12, result: 0
2026-03-19 16:33:15.424430325  src/station.c:station_connect_ok()
2026-03-19 16:33:15.427930974  event: state, old: connecting, new:
connecting (netconfig)
2026-03-19 16:33:15.428497433  src/wiphy.c:wiphy_radio_work_done()
Work item 18 done
2026-03-19 16:33:15.429988649  src/netdev.c:netdev_link_notify() event
16 on ifindex 12
2026-03-19 16:33:15.596679233
src/netconfig.c:netconfig_event_handler() l_netconfig event 0
2026-03-19 16:33:15.598603393
src/netconfig-commit.c:netconfig_commit_print_addrs() installing
address: 10.1.252.26
2026-03-19 16:33:16.359710983  resolvconf: /lib/resolvconf/lglxc a wlan0.dns
2026-03-19 16:33:16.942855588  s6-rc: fatal: unable to take locks:
Device or resource busy
2026-03-19 16:33:18.568696139  resolvconf: /lib/resolvconf/lglxc a wlan0.domain
2026-03-19 16:33:18.770418546  event: state, old: connecting
(netconfig), new: connected
2026-03-19 16:33:18.798277047  src/agent.c:agent_disconnect() agent
:1.71 disconnected
2026-03-19 16:33:18.798328689  src/agent.c:agent_free() agent free 0x1264568
2026-03-19 16:33:31.657151820  lglxc-dhcpd-6: restarting
2026-03-19 16:33:31.678298680  lglxc-dhcpd-4: restarting
