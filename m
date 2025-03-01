Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C923F376
	for <iwd@lists.linux.dev>; Sat,  1 Mar 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740847685; cv=none; b=AwVG9fiKzazk9KFCDF+gx5L9E2RDWEQqHJ/oORlpRW95ongF8u9GhLDpMP2rmdY66CAnZqwUZqkNe7tNICbC/oCii8LZL299hoEsZdjLzC7gdaXMfYMnVhFuTrKAX9sEHpSVWN4bO1tuO2ja7PrDTEgZujOBErTlSq4/rKHVwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740847685; c=relaxed/simple;
	bh=9Ee4KgGaqBDsomM99DVLJiU0x6/+gJJ/gj2fw/kKDBI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=m9knaDhYxBb0saTATwpIxJwMlv9tBXJiTDoD6LCXrAsacYPkbaBSJyB1cAaAZb9a5wWJyJ87GDhIGP+PgqlQaaVBshaSlOZZkddXGN2H6uDG/1yOtDMyMEcWDwy4Dqk120ZRuYBX/dw2ivVhWQSC0ElhAIBNOxtXdxJrMjUZkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbkA5Osw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbkA5Osw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2239f8646f6so1249085ad.2
        for <iwd@lists.linux.dev>; Sat, 01 Mar 2025 08:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740847683; x=1741452483; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Ee4KgGaqBDsomM99DVLJiU0x6/+gJJ/gj2fw/kKDBI=;
        b=lbkA5OswhMWacVRMynZh2JtZre0dsmDM/6IK2BZhamGcAeD3w/RuC40MSl+Ju8zHwp
         82o1PeKvqtVs1FPq1HXQQuWDcJst7J7A7L16twlSsbem2P5SwJSAZc9fYrZWgWtn5NDx
         V72NxEeC4ZlxXM6VzQlb6iM50qf2QJY2OqrQIN4ZT9a/QAiMRuxYIj+Dg9IJnNJwfCTh
         BqeqCHvR1EMdywMAjmx5owHT1CVmsPuWKdIKhlr26US3c18AAwGu3dzunPe4YHAIudcm
         CjmiTWOdO1MFZO1zDWdTlLzhtErFdJpGrBy+WO6UunxrBFOD/WLPJgEgoNWGYPAIsruT
         geZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740847683; x=1741452483;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Ee4KgGaqBDsomM99DVLJiU0x6/+gJJ/gj2fw/kKDBI=;
        b=TCv1UEBQFeqbPjf4TbAepBbeLEcuZmY4vjg76I78RHPevqGzfQ+Wh8+w3vrGsJKEeT
         xXefz6+QHwnQH0Cpe9IRJzMtQeFd1yNcftL1A42V2fNAamRE3F6rRgv7x9Bnaf0cEYY+
         VLWewKUrC/6z4Fr/LxUkpcihHlJCGVTCc8toJlTmv1gqiUnnBBlux9CLUMvclnnRb3vB
         cIZ5OXnPF6HlK/x6VxVQeccNa+6YvZ5hf6Qgp9w+4DFOVJWj/F6K+5gpEIiNlgpGT/+e
         g+SFtcpWORnM+p98z831WZR/R4Mq5n2J+50J/wG+CgUNccezoLS99b0ZDJtbPWkQ4+Om
         l3iQ==
X-Gm-Message-State: AOJu0Yz6kz3YI4obKRuA0oDKBcaSgu8YU0cqizeDVhxmqasOx/cNBa+L
	Dl0FYSH48aLUCfWlwx3Ggt8pUBdU1YM7AoLMDTZhN++fj0HKkV9pLKeg8xOwWp8ATl3PhP5Fgry
	p0ougQF1Po4Xt7Awb7uVLpNK/V+fOWoCW
X-Gm-Gg: ASbGncvdq5K/UseZ9dwcI3A70DZKCkZO5Zrrq8W/yxQDAh3GBVaFdwDUSxLBa/9DCp8
	tTkXUQKcgLuwGyeK5l8O1+M/bDIECo/O4xa/GS1V3nMX5E+ZlszDdTpE+F54kUm0vj+RVTJskEb
	ylApu5PFPyY/fTEwiDx+z2neSm1Q==
X-Google-Smtp-Source: AGHT+IHVLK/Ceq3ukr9VuKUu0TH8kmxI9tmfh5qX9BX9bBN7WhzCqOd+2+LV2UxepNJX6etoMbdBGeD7fVASxtZ9w6Q=
X-Received: by 2002:a17:90b:4a03:b0:2ee:7698:e565 with SMTP id
 98e67ed59e1d1-2febab50fcamr12310056a91.8.1740847683570; Sat, 01 Mar 2025
 08:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 1 Mar 2025 10:47:52 -0600
X-Gm-Features: AQ5f1Jr9t7HgkeHMukrsfj2ART5mt5Vq02D3rW6iTN2ssVtSnxKC_4N9ZX4diOU
Message-ID: <CAG17S_Pxv86uZ9hQe_upS8ybu6KDpXxhUYDa-q=R6muWSYXu+g@mail.gmail.com>
Subject: Suddenly, no DHCP
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Group,

I am flummoxed. I have an image that I had been using to connect to a
WPA2 SSID and it has been working for a very long time. It suddenly
quit connecting. This is an Rpi Zero2w with the brcmfmac 43430 chip. I
am running bookworm with kernel 6.6.77. When I set iwd to debug, I get
this:
Mar 01 09:58:38 zero2w connmand[29811]: Interface wlan0 [ wifi ] state
is association
Mar 01 09:58:38 zero2w iwd[29733]: src/network.c:network_connect()
Mar 01 09:58:38 zero2w iwd[29733]: src/network.c:network_connect_psk()
ask_passphrase: true
Mar 01 09:58:38 zero2w iwd[29733]:
src/agent.c:agent_request_passphrase() agent 0x5569b85c50 owner :1.896
path /net/connman/iwd_agent
Mar 01 09:58:38 zero2w iwd[29733]:
src/agent.c:agent_send_next_request() send request to :1.896
/net/connman/iwd_agent
Mar 01 09:58:38 zero2w iwd[29733]: src/agent.c:agent_receive_reply()
agent 0x5569b85c50 request id 136
Mar 01 09:58:38 zero2w iwd[29733]: src/network.c:passphrase_callback() result 0
Mar 01 09:58:38 zero2w iwd[29733]:
src/network.c:network_generate_sae_pt() Generating PT for Group 19
Mar 01 09:58:38 zero2w iwd[29733]:
src/network.c:network_generate_sae_pt() Generating PT for Group 20
Mar 01 09:58:38 zero2w iwd[29733]: src/netdev.c:netdev_cqm_rssi_update()
Mar 01 09:58:38 zero2w iwd[29733]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
Mar 01 09:58:38 zero2w iwd[29733]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 5
Mar 01 09:58:38 zero2w iwd[29733]: event: connect-info, ssid: spg5,
bss: bc:2e:48:fd:9e:70, signal: -37, load: 22/255
Mar 01 09:58:38 zero2w iwd[29733]: event: state, old:
autoconnect_full, new: connecting
Mar 01 09:58:38 zero2w iwd[29733]: src/scan.c:scan_periodic_stop()
Stopping periodic scan for wdev 1
Mar 01 09:58:38 zero2w iwd[29733]:
src/netdev.c:netdev_cmd_set_cqm_cb() CMD_SET_CQM not supported,
falling back to polling
Mar 01 09:58:38 zero2w connmand[29811]: Interface wlan0 [ wifi ] state
is configuration
Mar 01 09:58:39 zero2w systemd[1]: Reloading.
Mar 01 09:58:43 zero2w kernel: sh (31068): drop_caches: 3
Mar 01 09:59:19 zero2w avahi-daemon[261]: Joining mDNS multicast group
on interface wlan0.IPv4 with address 169.254.3.191.
Mar 01 09:59:19 zero2w avahi-daemon[261]: New relevant interface
wlan0.IPv4 for mDNS.
Mar 01 09:59:19 zero2w avahi-daemon[261]: Registering new address
record for 169.254.3.191 on wlan0.IPv4.
Mar 01 09:59:19 zero2w connmand[29811]: Interface wlan0 [ wifi ] state is ready
Mar 01 09:59:19 zero2w connmand[29811]: wlan0 {add} address
169.254.3.191/16 label wlan0 family 2
Mar 01 09:59:24 zero2w dbus-daemon[264]: [system] Activating via
systemd: service name='org.freedesktop.timedate1'
unit='dbus-org.freedesktop.timedate1.service' requested by ':1.946'
(uid=0 pid=31657 comm="timedatectl show -a")
Mar 01 09:59:24 zero2w systemd[1]: Starting systemd-timedated.service
- Time & Date Service...
Mar 01 09:59:25 zero2w dbus-daemon[264]: [system] Successfully
activated service 'org.freedesktop.timedate1'
Mar 01 09:59:25 zero2w systemd[1]: Started systemd-timedated.service -
Time & Date Service.
Mar 01 09:59:42 zero2w iwd[29733]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 4

Mar 01 09:58:38 kitchenrune iwd[29733]:
src/netdev.c:netdev_cmd_set_cqm_cb() CMD_SET_CQM not supported,
falling back to polling
Mar 01 09:58:38 kitchenrune connmand[29811]: Interface wlan0 [ wifi ]
state is configuration
Mar 01 09:58:39 kitchenrune systemd[1]: Reloading.
Mar 01 09:58:43 kitchenrune kernel: sh (31068): drop_caches: 3
Mar 01 09:59:19 kitchenrune avahi-daemon[261]: Joining mDNS multicast
group on interface wlan0.IPv4 with address 169.254.3.191.
Mar 01 09:59:19 kitchenrune avahi-daemon[261]: New relevant interface
wlan0.IPv4 for mDNS.
Mar 01 09:59:19 kitchenrune avahi-daemon[261]: Registering new address
record for 169.254.3.191 on wlan0.IPv4.
Mar 01 09:59:19 kitchenrune connmand[29811]: Interface wlan0 [ wifi ]
state is ready
Mar 01 09:59:19 kitchenrune connmand[29811]: wlan0 {add} address
169.254.3.191/16 label wlan0 family 2
Mar 01 09:59:24 kitchenrune dbus-daemon[264]: [system] Activating via
systemd: service name='org.freedesktop.timedate1'
unit='dbus-org.freedesktop.timedate1.service' requested by ':1.946'
(uid=0 pid=31657 comm="timedatectl show -a")
Mar 01 09:59:24 kitchenrune systemd[1]: Starting
systemd-timedated.service - Time & Date Service...
Mar 01 09:59:25 kitchenrune dbus-daemon[264]: [system] Successfully
activated service 'org.freedesktop.timedate1'
Mar 01 09:59:25 kitchenrune systemd[1]: Started
systemd-timedated.service - Time & Date Service.
Mar 01 09:59:42 kitchenrune iwd[29733]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 4

as you can see, it does not get a DHCP address, but gets an APIPA
address. Any ideas what might be going on? I have tried rebooting the
Pi and also rebooted the DHCP server and restarted the router.
