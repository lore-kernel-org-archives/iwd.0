Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB72222B6
	for <iwd@lists.linux.dev>; Mon,  7 Apr 2025 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997732; cv=none; b=Mil7dxGmMs21YpVxA1/j6gZ7Wle81YYoowIlbfdKb1wlTY3USxAL9XHKu3XlwRXWLr/9jJQPhZD1SkiJq/NZXQNAvS2emXo355dFf2ZrPBxUOrA/WNNI7ZsOuNIbG+EfkSzFGbpECy/XCkv5zw5JCYp4YMR3owulcoFUDRc4pV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997732; c=relaxed/simple;
	bh=C/CPmrIy5ISc16ab7x1CnMHDOQ7aLOM8CnE8VkIbm70=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=noyXKNGzo0WG9GVWu3Nvhx2WnqxQaJfB8hJfHBEbhe8sjmCrh+yenbXRVjJ7z/HRGY9RDjScTNpS86/SuyZtCI19npUQPWgVYeQayUqnyHKc0TpeiKopbphDcL8Hfu53Cfl5U5cJe/BblTpaWj38aqnVzTIItD1Yo+1XshaWm70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgIQYFR/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgIQYFR/"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af579e46b5dso2391069a12.3
        for <iwd@lists.linux.dev>; Sun, 06 Apr 2025 20:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743997730; x=1744602530; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C/CPmrIy5ISc16ab7x1CnMHDOQ7aLOM8CnE8VkIbm70=;
        b=jgIQYFR/ToMoMGl3o2Ify6LsCXIgQ9sVau/pC17sxrM0gYtFp9nxwILqKl9bVWmdkJ
         c04Z5/VQRbdR/V2znYuK6Iix9Tc7RAddBlL1+/JnMO92f6U0tCiPCVULrz1XOD986kql
         ak0GmfLuq02c9xUcnMTsVf20mSJ4lUlyY315+arXH9bJqv1FrLRGeWwoZb5356vzk01U
         2gutTUPCb0Fu5v8jRBvCKQ0a99t+HhMQPwbzGBy/f3Wd6Ow+6yi3K934oLggurMSglFe
         4KbUukGAl5DqRy8Joyxa40uPAUQSd55XTu3+aCdK6GaEtUFON+Lo7oJnTwC9lniB1Bji
         33Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743997730; x=1744602530;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/CPmrIy5ISc16ab7x1CnMHDOQ7aLOM8CnE8VkIbm70=;
        b=cj6MeSCF06Y1vvMaAMUiWhBiWVokVAuSxYzi7AlmldqD1noXAlAqn5iQLqLjc9rNua
         2UunkwbQsw+AjtZbCX/fR93H6dj/Q56eC6OXsvRc1YmvOCGx/ADYYYDkRSeEkUZqkkNN
         GYTv3UDxD4ZeZk5YEcxFcgJFLV5fPfM6oZ9+95+Pk64MMQBfBWryrHUt//F6Cv3LzXZY
         TMiL+ltUjLqpSmqHK7/HO3rvLPqGiSuTcvVkmz2geSe9YoHYF+PjLn5WOmqap578/+P2
         F6teRuGBVzMd4dR6LYCqbhj5vCPB0Ff0f0fzz1JoctD1f109WEdEyzL9lSj0kTfCKiCA
         7nuw==
X-Gm-Message-State: AOJu0Yy9Km3uOq14tS3XpxxjFgFh0xvEhH9Ta1aWOKdsiXh0htAr1aoG
	NqL4GvHCL8k5ZiyGc7DaZpu7SGVwGVWQdAMh6tDcWAS9OVvOmFISdHu5wzKs0jt8Tr8V1tTeT9O
	avTqq20dddpSwl/VtSJgYAT+6ldW0OXQn
X-Gm-Gg: ASbGnctniujeNVO4N45jzALe+ax+EZr4Mzh3bRhMyVSwo5v1NIaJeGX/SHywRcaB7lc
	TKRIfF7p+64ztUPhT9IE5JL/TfHxl7Iw7mzHm4fAePCLGSX1cH/xfOECTHF3itFUEpTWC3fk7EF
	339FETnBzDyWQIjvttRwLyiUHN8EhFPk9c+RRqHMY=
X-Google-Smtp-Source: AGHT+IFsjwdHWwfhuNPsymMEPpvl5zd1dZ5P13KeruXthcEEz7ciS3k2qzSZPThArrjX1C8i9sJlGFDBnOR0Min2hm4=
X-Received: by 2002:a17:90b:570e:b0:2fe:b8ba:62e1 with SMTP id
 98e67ed59e1d1-306a6213a3emr13896349a91.28.1743997729883; Sun, 06 Apr 2025
 20:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 6 Apr 2025 22:48:38 -0500
X-Gm-Features: ATxdqUH7BnryJm5L_s-h3eJpX9voexfZ5N1qMIiLt3nYBFlQsqitH4x-UxuNqbQ
Message-ID: <CAG17S_Mgb9fHFcwW1KoNZ2QxZVH2rKZuwG5i78c8us0HjwO7Eg@mail.gmail.com>
Subject: strange behavior with synthetic ap0
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I have been messing around with a synthetic ap0 to set up AP mode up
on my brcmfmac equipped Pis. This attempt is on a Pi4 with the 43455
chip, but I've recently seen this with other Pis.
What I do to set up the ap0 is this:

iw dev wlan0 interface add ap0 type __ap
ip link set dev ap0 address d8:3a:dd:60:a3:cg
systemctl reload-or-restart iwd
iwctl device ap0 set-property Mode ap
iwctl ap ap0 start-profile test

Then from connmanctl, I attempt to connect to a known SSID. If ap0 is
up, I cannot connect to the SSID with the correct password. If I take
ap0 down 'iw ap0 del' and try again, it connects. This is with either
iwd controlling the AP or hostapd. It doesn't matter which is
controlling the ap0, if it is up, I always get a failed password if
ap0 is up. This used to work and seems to have regressed.

When I enable debug for iwd, this is what it looks like when I attempt
to connect to a known SSID when the ap0 is up.
Apr 06 16:36:09 pi4 connmand[138138]: Interface wlan0 [ wifi ] state
is association
Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:network_connect()
Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:network_connect_psk()
ask_passphrase: true
Apr 06 16:36:09 pi4 iwd[158609]:
src/agent.c:agent_request_passphrase() agent 0x5582c692f0 owner
:1.5673 path /net/connman/iwd_agent
Apr 06 16:36:09 pi4 iwd[158609]: src/agent.c:agent_send_next_request()
send request to :1.5673 /net/connman/iwd_agent
Apr 06 16:36:09 pi4 iwd[158609]: src/agent.c:agent_receive_reply()
agent 0x5582c692f0 request id 117
Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:passphrase_callback() result 0
Apr 06 16:36:09 pi4 iwd[158609]:
src/network.c:network_generate_sae_pt() Generating PT for Group 19
Apr 06 16:36:09 pi4 iwd[158609]:
src/network.c:network_generate_sae_pt() Generating PT for Group 20
Apr 06 16:36:09 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 6
Apr 06 16:36:09 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 6
Apr 06 16:36:09 pi4 iwd[158609]: event: connect-info, ssid: keithS23,
bss: 56:ba:50:be:c8:62, signal: -69, load: 0/255
Apr 06 16:36:09 pi4 iwd[158609]: event: state, old: autoconnect_full,
new: connecting
Apr 06 16:36:09 pi4 iwd[158609]: src/scan.c:scan_periodic_stop()
Stopping periodic scan for wdev 1
Apr 06 16:36:09 pi4 connmand[138138]: Interface wlan0 [ wifi ] state
is configuration
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_mlme_notify()
MLME notification Connect(46)
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
aborting and ignore_connect_event not set, proceed
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
expect_connect_failure not set, proceed
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:parse_request_ies()
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_event()
Request / Response IEs parsed
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_get_oci()
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {RX} 335 packets 72684 bytes
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {TX} 1615 packets 216925 bytes
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {update} flags 102403 <UP,LOWER_UP>
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3 address
DC:A6:32:B4:50:CF mtu 1500
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3
operstate 5 <DORMANT>
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 3
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_get_oci_cb()
Obtained OCI: freq: 5785, width: 3, center1: 5775, center2: 0
Apr 06 16:36:09 pi4 iwd[158609]: src/eapol.c:eapol_start()
Apr 06 16:36:09 pi4 iwd[158609]:
src/station.c:station_handshake_event() Handshaking
Apr 06 16:36:09 pi4 iwd[158609]: src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 3
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 3
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 3
Apr 06 16:36:09 pi4 iwd[158609]: src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_gtk()
ifindex=3 key_idx=1
Apr 06 16:36:09 pi4 iwd[158609]:
src/station.c:station_handshake_event() Setting keys
Apr 06 16:36:09 pi4 iwd[158609]: src/network.c:network_sync_settings()
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_tk()
ifindex=3 key_idx=0
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_rekey_offload() 3
Apr 06 16:36:09 pi4 iwd[158609]:
src/netdev.c:netdev_new_group_key_cb() ifindex: 3, err: 0
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
ptk_installed: 0, gtk_installed: 1, igtk_installed: 1
Apr 06 16:36:09 pi4 iwd[158609]: hardware_rekey not supported
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_set_station_cb()
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
ptk_installed: 1, gtk_installed: 1, igtk_installed: 1
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
nhs->complete: 0
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:try_handshake_complete()
Invoking handshake_event()
Apr 06 16:36:09 pi4 iwd[158609]:
src/handshake.c:handshake_state_cache_pmksa() No PMKSA for
56:ba:50:be:c8:62
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_connect_ok()
Apr 06 16:36:09 pi4 iwd[158609]: src/station.c:station_connect_cb() 3, result: 0
Apr 06 16:36:09 pi4 iwd[158609]: src/station.c:station_connect_ok()
Apr 06 16:36:09 pi4 iwd[158609]: event: state, old: connecting, new:
connecting (netconfig)
Apr 06 16:36:09 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_done()
Work item 6 done
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {RX} 336 packets 72839 bytes
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {TX} 1619 packets 217577 bytes
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {update} flags 102467
<UP,RUNNING,LOWER_UP>
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3 address
DC:A6:32:B4:50:CF mtu 1500
Apr 06 16:36:09 pi4 connmand[138138]: wlan0 {newlink} index 3 operstate 6 <UP>
Apr 06 16:36:09 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 3
Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_mlme_notify()
MLME notification Disconnect(48)
Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_disconnect_event()
Apr 06 16:36:19 pi4 iwd[158609]: Received Deauthentication event,
reason: 0, from_ap: false
Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_disconnect_event() 3
Apr 06 16:36:19 pi4 iwd[158609]: event: disconnect-info, reason: 0
Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_disassociated() 3
Apr 06 16:36:19 pi4 iwd[158609]:
src/station.c:station_reset_connection_state() 3
Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_roam_state_clear() 3
Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {RX} 336 packets 72839 bytes
Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {TX} 1635 packets 220020 bytes
Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {update} flags 36867 <UP>
Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {newlink} index 3 address
DC:A6:32:B4:50:CF mtu 1500
Apr 06 16:36:19 pi4 connmand[138138]: wlan0 {newlink} index 3 operstate 2 <DOWN>
Apr 06 16:36:19 pi4 iwd[158609]: event: state, old: connecting
(netconfig), new: disconnected
Apr 06 16:36:19 pi4 iwd[158609]: event: state, old: disconnected, new:
autoconnect_quick
Apr 06 16:36:19 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 7
Apr 06 16:36:19 pi4 iwd[158609]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 7
Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 3
Apr 06 16:36:19 pi4 iwd[158609]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
Apr 06 16:36:19 pi4 iwd[158609]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 3
Apr 06 16:36:19 pi4 iwd[158609]: src/scan.c:scan_request_triggered()
Passive scan triggered for wdev 1
Apr 06 16:36:19 pi4 iwd[158609]:
src/station.c:station_quick_scan_triggered() Quick scan triggered for
wlan0
Apr 06 16:36:19 pi4 connmand[138138]: Interface wlan0 [ wifi ] error
"connect-failed"
Apr 06 16:36:19 pi4 connmand[138138]: Interface wlan0 [ wifi ] state is failure
Apr 06 16:36:19 pi4 iwd[158609]: src/station.c:station_dbus_disconnect()
Apr 06 16:36:19 pi4 iwd[158609]: event: state, old: autoconnect_quick,
new: disconnected

It is strange that it reports a bad password. Is this a brcmfmac
driver issue or a firmware issue?

Keith
