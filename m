Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F81DF248
	for <iwd@lists.linux.dev>; Tue, 15 Jul 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600532; cv=none; b=i+Lchey+fns1y2BVe8MCMx1/hWPEo8lCGPDjrmEW+RCB/hgvj30uKEI2ecVnmKvhwcNNNW/+2NaVkfxeZA8EDIf23s1mX09gKfaGfNpmhD58lEt3McQ8+CVgSKlPynkR217NCXCpnUf4hzPbqq4ZBeHG1FZI6QyybmVIpWDDSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600532; c=relaxed/simple;
	bh=WoRGzF4xD17zhw2cVbHyKjqH/QYwKL1lDE7lTtUODHY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=h3eXhVC2auAApqLAWQiqPDbRinTPcaErSvHsXU/UmlJjfwX1FFXdTIp9dr4tNqmS+pK7FT+Z6yOtfN1D0zyqolzCo/gazulVk5A3jcO3cN0UibWAz2kjboM1yTol/guuxS4TiadiUdPlDFafkNBUAT3SHMOI0o1iK3/AqCBpmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7176c66e99cso53772407b3.3
        for <iwd@lists.linux.dev>; Tue, 15 Jul 2025 10:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600529; x=1753205329;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQADERYx6BOfIgK3FNYeTr3io6gzZlE5i6DoaRwtZ6s=;
        b=slqbPqhh6N5APE0P/hTMusu1I0M6XgexxPX7ulFz9Y8AJe66kpur1/f3ulkVyWSQty
         AnQ1mQ4ssA3d1qAUX1RCIGCrGD+sQoO0ET/1Sss82GfmG1VWRq4TPnFFdeM0you11TD1
         +MSVrpd1KER1Xl/2vg/wthDAncLRqhC69X1ycP/sUSy+SEQ9vtkyMYhec5li+3F3NjN+
         3tHGL6g6rrgdXxJ6aEUMAYT7Wm+4V58hyBkx4+vXsNsMxKe9UJZl86mIEx3LTeMSrnxJ
         wkFZeOTPx3cpjsjxKA3JMriwrS+JloaNbWQOxdYSVbOvFyMysWCWpoX7a1SaMw1/7fQA
         Zmow==
X-Gm-Message-State: AOJu0YzkoKuTd9ePtYfUw5UOWG7Wnkr+HhzXLlBUYvoyObs+J06RsRWb
	7hlVKrR7QP8rCD/CRm7DUnxLtqREBKQVcVnbT0bRXKIBW7S0sgbr5+hyrARfIg==
X-Gm-Gg: ASbGnctrCT9ShsJR2w2+wEi8Pjf7yYdFWzwtQs3Xvd5kzV05+Uh/fW4pCJOTIKPIGqL
	d4RST26EHBdLiE5z3YVlYiiN8DjF2Uj+JG2A5Dr6qA/liiuHpP9+PF74v31tnt7gAbq+aBMMTAN
	YzVkyD8tzNFTU2/lfwwvKxhWBlST1Etxh1wrfnKS6b/FDRLqaqpmwbtim3P9z1FTYqFTcTbNCdB
	WGkQKXKbnrrqqHrSFzScb+UApDnS2ditJkbW3kdEV9IFPlfPdP0ng/0GBvcFZy2e3NZafsj5lCb
	7GUMQ0p9nNE9BFJqNX45l6WW88nB5ctWrs879Pes8TplkvwEOIs566ptP2hxL1zmcyfJeYKpUXU
	QNTnge16cyopzX0yvK2k+yuFuBubQ7Fug9FQSZRKi5pPwlmYO2D9cFl9uQu6uAMo+Bw==
X-Google-Smtp-Source: AGHT+IGTglmrIZlSTuYn7ePVZASuzsM3ggc3zexxAJ0KOdIYa4d6Qw4cRpsO5pBaxcPgjsn3zSVbvA==
X-Received: by 2002:a05:690c:4a02:b0:70e:1874:b914 with SMTP id 00721157ae682-71834f7f8afmr667477b3.9.1752600528678;
        Tue, 15 Jul 2025 10:28:48 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61b4b7dsm25065447b3.58.2025.07.15.10.28.48
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 10:28:48 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8bb69cdb90so1094036276.0
        for <iwd@lists.linux.dev>; Tue, 15 Jul 2025 10:28:48 -0700 (PDT)
X-Received: by 2002:a05:690c:9a8d:b0:710:ed16:267a with SMTP id
 00721157ae682-7183515dcbfmr210287b3.30.1752600527791; Tue, 15 Jul 2025
 10:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Tue, 15 Jul 2025 11:28:36 -0600
X-Gmail-Original-Message-ID: <CADXxVSK3vr5=wsB8q6yz1KvB5VqSnQNW+8Nf_Wn7OrAQN470Kw@mail.gmail.com>
X-Gm-Features: Ac12FXzNblzJRBYPsMLCpbIM-Cet3DBc1rdnA6x3QohyhpUmubx6Ck8Xv9p_NrM
Message-ID: <CADXxVSK3vr5=wsB8q6yz1KvB5VqSnQNW+8Nf_Wn7OrAQN470Kw@mail.gmail.com>
Subject: Dealing with wifi driver crash that doesn't remove wlan interface
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,
Long shot if there is something I can do with iwd, but I figured I'd
ask... We are dealing with an occasional wifi-driver crash on silabs
wf200 that silabs hasn't been able to fix... so we had implemented a
workaround that seems to be working fairly well up until now.

From our wifi provisioning application, we query a few params over
dbus periodically and log them:
mac_address: "70:c5:9c:xx:xx:xx"
ssid: "xxxxxxxx"
freq: 2412
rssi: -32
security: "WPA2-Personal"

If our dbus path fails in our application it will trigger the
wifi-driver to be restarted.  That fixes many of the issues, but we
ran into an issue at a friendly customer site, where the driver
failed, but apparently left enough up where the wlan0 was up and iwd
was just getting stale data from it.

The correct answer is for silabs to fix the driver, but I was
wondering if there were any other additional workarounds I could try
in the meantime...

This in on iwd 3.4, Here is a snip of the iwd log with debug enabled:

at ~2025-07-14 18:45: the driver crashed:
dmesg: [ 3253.325450] wfx-spi spi0.0: firmware exception

at ~2025-07-15 16:20 we manually restarted the driver
dmesg: [80768.916153] wlan0: deauthenticating from 90:09:d0:42:07:56
by local choice (Reason: 3=DEAUTH_LEAVING)


2025-07-14 17:58:11.565200658  src/station.c:station_print_scan_bss()
Processing BSS '38:70:0c:41:d2:b8' with SSID: ROBBY, freq: 2462, rank:
37, strength: -8500, data_rate: 5.5
2025-07-14 17:58:11.566580887  src/station.c:station_print_scan_bss()
Processing BSS '18:90:88:2e:88:05' with SSID: , freq: 2412, rank: 13,
strength: -8800, data_rate: 2.0
2025-07-14 17:58:11.566801362  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2025-07-14 17:58:11.566967170  src/station.c:station_print_scan_bss()
Processing BSS '64:51:06:db:a5:ae' with SSID: HP-Print-AE-Photosmart
6520, freq: 2412, rank: 13, strength: -8800, data_rate: 2.0
2025-07-14 17:58:11.569713212  src/station.c:station_print_scan_bss()
Processing BSS '76:54:25:16:80:39' with SSID: , freq: 2462, rank: 13,
strength: -9100, data_rate: 2.0
2025-07-14 17:58:11.569950527  src/station.c:station_add_seen_bss()
BSS has hidden SSID
2025-07-14 17:58:11.570111448  src/station.c:station_print_scan_bss()
Processing BSS '1c:39:29:02:b4:c5' with SSID:
AT_401_WIN_056905_WW_b4c5, freq: 2462, rank: 13, strength: -9200,
data_rate: 2.0
2025-07-14 17:58:11.573726453  src/wiphy.c:wiphy_radio_work_done()
Work item 4 done
2025-07-14 17:58:11.575809796  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-07-14 17:58:17.677447209  src/netdev.c:netdev_link_notify() event
16 on ifindex 6
2025-07-14 17:58:17.677731675  src/netdev.c:netdev_link_notify() event
16 on ifindex 5
2025-07-14 17:59:23.451727924  src/netdev.c:netdev_link_notify() event
16 on ifindex 5
2025-07-14 17:59:23.463000704  src/netdev.c:netdev_link_notify() event
16 on ifindex 5
2025-07-14 17:59:23.482318002  src/netdev.c:netdev_link_notify() event
16 on ifindex 5
2025-07-14 17:59:23.483857888  src/netdev.c:netdev_link_notify() event
17 on ifindex 5
2025-07-14 17:59:23.485664308  src/netdev.c:netdev_link_notify() event
16 on ifindex 4
2025-07-14 17:59:23.487021309  src/netdev.c:netdev_link_notify() event
17 on ifindex 5
2025-07-14 17:59:31.211091899  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:31.213708170  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:31.276263723  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:31.283333624  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:31.285134352  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:31.286224134  src/netdev.c:netdev_link_notify() event
16 on ifindex 4
2025-07-14 17:59:31.288634631  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:31.289996567  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:31.339801875  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:31.340068480  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:31.341316514  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 17:59:46.764125543  src/netdev.c:netdev_link_notify() event
16 on ifindex 8
2025-07-14 18:45:50.472050964  src/netdev.c:netdev_unicast_notify()
Unicast notification Control Port Frame(129)
2025-07-14 18:45:50.472323982  src/netdev.c:netdev_control_port_frame_event()
2025-07-14 18:45:50.489657876  src/eapol.c:eapol_handle_gtk_1_of_2() ifindex=2
2025-07-14 18:45:50.503031733  src/netdev.c:netdev_set_gtk() ifindex=2 key_idx=2
2025-07-14 18:45:50.526112177  src/netdev.c:netdev_new_group_key_cb()
ifindex: 2, err: 0
2025-07-14 18:45:50.527560761  src/netdev.c:try_handshake_complete()
ptk_installed: 1, gtk_installed: 1, igtk_installed: 1
2025-07-14 18:45:50.528956809  src/netdev.c:try_handshake_complete()
nhs->complete: 1
2025-07-14 18:45:50.559356169  src/netdev.c:netdev_mlme_notify() MLME
notification Control Port TX Status(139)
2025-07-15 16:20:46.865790966  src/netdev.c:netdev_mlme_notify() MLME
notification Notify CQM(64)
2025-07-15 16:20:46.866248149  src/station.c:station_packets_lost()
Packets lost event: 50
2025-07-15 16:20:46.866559823  src/station.c:station_start_roam()
Requesting neighbor report for roam
2025-07-15 16:20:49.674634613  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-07-15 16:20:49.689872602  src/netdev.c:netdev_link_notify() event
16 on ifindex 2
2025-07-15 16:20:49.690157914
src/station.c:station_neighbor_report_cb() ifindex: 2, error:
-107(Transport endpoint is not connected)
2025-07-15 16:20:49.690321414
src/station.c:station_neighbor_report_cb() no neighbor report results
or known freqs
2025-07-15 16:20:49.690755567  src/station.c:station_roam_failed() 2
2025-07-15 16:20:49.690928478  src/station.c:station_free()
2025-07-15 16:20:49.691063826  src/netconfig.c:netconfig_destroy()
2025-07-15 16:20:49.694320325
src/netconfig.c:netconfig_event_handler() l_netconfig event 2
2025-07-15 16:20:49.696345663
src/netconfig-commit.c:netconfig_commit_print_addrs() removing
address: 192.168.1.100
2025-07-15 16:20:52.482746720  resolve: /sbin/resolvconf exited with
status (36096).
2025-07-15 16:20:52.483011183  src/station.c:station_roam_state_clear() 2
2025-07-15 16:20:52.520806556  src/netdev.c:netdev_link_notify() event
17 on ifindex 2
2025-07-15 16:20:52.522040814  src/netdev.c:netdev_free() Freeing
netdev wlan0[2]
2025-07-15 16:20:52.524139481  src/device.c:device_free()
2025-07-15 16:20:52.526958891  Removing scan context for wdev 1
