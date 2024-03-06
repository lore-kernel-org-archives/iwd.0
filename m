Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797F315AC4
	for <iwd@lists.linux.dev>; Wed,  6 Mar 2024 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702817; cv=none; b=K2NzyitGj7OAh1vYfVnFjAZzWHVvQj4fg9tQVGEUJcv+retEHRRoXdwx99VNw0OevwPldWbMx+50wn63C1j/Q4BaGWrW1WPVXjogwNBdGRZwVh/i8a9++LFuSIW6dBB1D7K58I661npWzMeTPcASoNWnocczZXBk7dSArDu/4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702817; c=relaxed/simple;
	bh=Kz7v9vbxl2rZKpK8eamptA3yh9yj8sFiA5rCAkL5Hbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZjPh8GMa1PIxQ9gJVR1FjbJO+A/sSeiiTKbIwd7DHdqyfpHaVae+JAuCQMJKiT198PzZJjDroTsc+68GUg4fy45QUSDlxJePrGmCbQvf3ydGgLO1eP1e2CShxANU6CILvzF6EZsWYKpGkepwVjzOz/vVce+KOc+kyLoL6fxXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rje8u9K7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rje8u9K7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a441d7c6125so152870566b.2
        for <iwd@lists.linux.dev>; Tue, 05 Mar 2024 21:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709702813; x=1710307613; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLJwRupyk4988QmJr5b0zItaaCE6pNDBjvPzIvYMlLA=;
        b=Rje8u9K7/p8QZ98GU75UEapnZQ5WfoY1R9867VfR9gENu9PhRinAq4Va0pjl6DBqV9
         SxkHFmYnMbWnNEsmNVFJAZR9SvvfjXzAq16mBkqCqElwUumQdtyYXnp4ifScikmvxtit
         wq/MB/jN071vBJFeAVYEPPYmKI+nFlVhFfoDKaXp5bxqchdX9VBL6NKFQjnQ8xxspFhS
         A0oSYqs/yDa7xqz6ODnxoXUnh8FbHhgOIWX7PDgONJ7NmvpD0Y77jLo159vH9ztYKlFu
         ZtGSpJrlN7CKZum11M61vgs4RN9e2yV2IScEzYwCxDI6aNon6wagtcIXXQRQiiUZIZ6e
         bf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709702813; x=1710307613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLJwRupyk4988QmJr5b0zItaaCE6pNDBjvPzIvYMlLA=;
        b=KuAlvQkrXECfJLgMsrWx9BLL67NjZnORZaOuVfgEuRhFjcTyP9sxbLABoq85BbrPen
         +2twITBV908+NgeRLqz7wq1QfGAv0t0DYHztT5pAXhFJJiqGNaIBJk5xnDZyBpb8zLVa
         aioC/lKXcGOt8Bd76Sex9Y9jEde8pLOagU7juRHz+4fWH3i0ti1i+cdTab+d3w8ejMY+
         eTNCCcXjb4Ej8b9jBKtVH0srGEZcgnhY3Bmr5GTfH8gILnZNfx3gHNqvPfXzz6CEIGS5
         DxAFb9iHfQjJbq7mGxWTYBnRKH1v56jJkKvYzZsh3+W1HmBkUCm+Gi/AFGCCyhQ7DK/K
         vUOw==
X-Gm-Message-State: AOJu0YyjZymmheHI0ZaAIyCGQ7o4hCA9zfhFpI+mQoy2icuhKf1hLg/O
	krylEi6tIjb75aJjbjsGodspsSZ+vX1YCBRXNMdOjaq5mn2FnBQPTOJChfjz+tWlQ7MC9u8mzPE
	mtkdYgg6zFHZ7WpJLWq1wllqr2bK0E1h5jlc=
X-Google-Smtp-Source: AGHT+IFbptITmaHyJKco71G31M8n3cxMfKwzWd+j9DBiCpebD2xQbbjgwtVyj5NdhpjU6R0InbwPDH7VjT+yhgQP+EU=
X-Received: by 2002:a17:906:fcc2:b0:a45:b6b3:dc29 with SMTP id
 qx2-20020a170906fcc200b00a45b6b3dc29mr642607ejb.4.1709702812095; Tue, 05 Mar
 2024 21:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKbf6axbkp5E1M8Pvm1SbPOQFtzxX8Cdwj9YjbYNy0aekHDHzw@mail.gmail.com>
 <1aebf48a-0ed4-4605-a03b-5f6e0706ed71@gmail.com> <CAKbf6aw-So-y=NuHTo-GqTRmjPR7pN1j8UOmHOvvRETBM-3XoA@mail.gmail.com>
 <0f64f742-4fbc-4493-9fd8-bd0afdc9f4a7@gmail.com>
In-Reply-To: <0f64f742-4fbc-4493-9fd8-bd0afdc9f4a7@gmail.com>
From: Kentaro Yamaguchi <kentaro.y@gmail.com>
Date: Wed, 6 Mar 2024 14:26:41 +0900
Message-ID: <CAKbf6az_97xryQNWnebsUesxEnHnWiRyT+t2E=6RtxTYzoexeA@mail.gmail.com>
Subject: Re: How to connect specifying the BSSID?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

The IWD log is as follows.
I have confirmed that it is possible to connect to the same BSSID
using a combination of nmcli and wpa_suplicant.

IWD logs
---------------------------------------------------------------------------=
--------------------
Mar 06 11:40:51 livazplus sudo[1323]:       ken : TTY=3Dpts/0 ;
PWD=3D/home/ken ; USER=3Droot ; COMMAND=3D/usr/bin/iwctl station wlp4s0 sca=
n
Mar 06 11:40:51 livazplus sudo[1323]: pam_unix(sudo:session): session
opened for user root(uid=3D0) by ken(uid=3D1001)
Mar 06 11:40:51 livazplus iwd[747]: src/agent.c:agent_register() agent
register called
Mar 06 11:40:51 livazplus iwd[747]: src/agent.c:agent_register() agent
:1.52 path /agent/1325
Mar 06 11:40:51 livazplus iwd[747]: src/station.c:station_dbus_scan()
Scan called from DBus
Mar 06 11:40:51 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
Mar 06 11:40:51 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 1
Mar 06 11:40:51 livazplus iwd[747]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
Mar 06 11:40:51 livazplus iwd[747]:
src/scan.c:scan_request_triggered() Active scan triggered for wdev 2
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_dbus_scan_triggered() station_scan_triggered: 0
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_dbus_scan_triggered() Scan triggered for wlp4s0
subset 0
Mar 06 11:40:51 livazplus iwd[747]: src/agent.c:agent_disconnect()
agent :1.52 disconnected
Mar 06 11:40:51 livazplus iwd[747]: src/agent.c:agent_free() agent
free 0x5b56da177a30
Mar 06 11:40:51 livazplus sudo[1323]: pam_unix(sudo:session): session
closed for user root
Mar 06 11:40:51 livazplus iwd[747]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
Mar 06 11:40:51 livazplus iwd[747]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'5a:91:e3:16:be:7c' with SSID: tp-link_be85, freq: 2417, rank: 3912,
strength: -700, data_rate: 573.6
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network "tp-link_be85"
security psk
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'6c:e4:da:92:4d:56' with SSID: aterm-9bcdbf-g, freq: 2437, rank: 591,
strength: -6700, data_rate: 86.7
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network
"aterm-9bcdbf-g" security psk
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'80:22:a7:58:48:fe' with SSID: ntcm1-3a3c49-g, freq: 2462, rank: 443,
strength: -6500, data_rate: 65.0
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network
"ntcm1-3a3c49-g" security psk
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'90:f3:05:6a:cc:96' with SSID: HUMAX-ACC89, freq: 2462, rank: 236,
strength: -7200, data_rate: 28.9
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network "HUMAX-ACC89"
security psk
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'38:f8:5e:8a:ba:43' with SSID: HUMAX-ABA36, freq: 2462, rank: 90,
strength: -8300, data_rate: 11.0
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network "HUMAX-ABA36"
security psk
Mar 06 11:40:51 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
Mar 06 11:40:51 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_done() Work item 1 done
Mar 06 11:40:51 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 2
Mar 06 11:40:51 livazplus iwd[747]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
Mar 06 11:40:51 livazplus iwd[747]:
src/scan.c:scan_request_triggered() Active scan triggered for wdev 2
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_dbus_scan_triggered() station_scan_triggered: 0
Mar 06 11:40:51 livazplus iwd[747]:
src/station.c:station_dbus_scan_triggered() Scan triggered for wlp4s0
subset 1
Mar 06 11:40:54 livazplus iwd[747]: src/wiphy.c:wiphy_reg_notify()
Notification of command Wiphy Reg Change(113)
Mar 06 11:40:54 livazplus iwd[747]:
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
phy0 is JP
Mar 06 11:40:54 livazplus iwd[747]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
Mar 06 11:40:54 livazplus iwd[747]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'56:91:e3:16:be:7d' with SSID: tp-link_be85, freq: 5200, rank: 16384,
strength: -2700, data_rate: 2402.0
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'50:91:e3:16:be:7d' with SSID: , freq: 5200, rank: 16384, strength:
-2700, data_rate: 2402.0
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() BSS has hidden SSID
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'f8:b7:97:58:d0:2b' with SSID: KSH5G, freq: 5500, rank: 5911,
strength: -4100, data_rate: 866.7
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network "KSH5G"
security psk
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'80:22:a7:58:48:ff' with SSID: ntcm1-3a3c49-a, freq: 5180, rank: 204,
strength: -7700, data_rate: 30.0
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network
"ntcm1-3a3c49-a" security psk
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'90:f3:05:6a:cc:8e' with SSID: HUMAX-ACC89-A, freq: 5260, rank: 16,
strength: -9000, data_rate: 2.0
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network "HUMAX-ACC89-A"
security psk
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'5a:91:e3:16:be:7c' with SSID: tp-link_be85, freq: 2417, rank: 3912,
strength: -700, data_rate: 573.6
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'6c:e4:da:92:4d:56' with SSID: aterm-9bcdbf-g, freq: 2437, rank: 591,
strength: -6700, data_rate: 86.7
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'80:22:a7:58:48:fe' with SSID: ntcm1-3a3c49-g, freq: 2462, rank: 443,
strength: -6500, data_rate: 65.0
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'90:f3:05:6a:cc:96' with SSID: HUMAX-ACC89, freq: 2462, rank: 236,
strength: -7200, data_rate: 28.9
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'38:f8:5e:8a:ba:43' with SSID: HUMAX-ABA36, freq: 2462, rank: 90,
strength: -8300, data_rate: 11.0
Mar 06 11:40:54 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
Mar 06 11:40:54 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_done() Work item 2 done
Mar 06 11:40:54 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 3
Mar 06 11:40:54 livazplus iwd[747]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
Mar 06 11:40:54 livazplus iwd[747]:
src/scan.c:scan_request_triggered() Active scan triggered for wdev 2
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_dbus_scan_triggered() station_scan_triggered: 0
Mar 06 11:40:54 livazplus iwd[747]:
src/station.c:station_dbus_scan_triggered() Scan triggered for wlp4s0
subset 2
Mar 06 11:40:55 livazplus iwd[747]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
Mar 06 11:40:55 livazplus iwd[747]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'5a:91:e3:16:be:7c' with SSID: tp-link_be85, freq: 2417, rank: 3912,
strength: -600, data_rate: 573.6
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'50:91:e3:16:be:7c' with SSID: tp-link_be85_2G, freq: 2417, rank:
3912, strength: -600, data_rate: 573.6
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network
"tp-link_be85_2G" security psk
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'56:91:e3:16:be:7c' with SSID: , freq: 2417, rank: 2346, strength:
-5800, data_rate: 344.0
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() BSS has hidden SSID
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'24:4b:fe:b6:5c:e0' with SSID: zxcvbnm27, freq: 2447, rank: 281,
strength: -7900, data_rate: 34.4
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network "zxcvbnm27"
security psk
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'58:27:8c:88:8c:d9' with SSID: Buffalo-G-8CD8, freq: 2452, rank: 45,
strength: -8500, data_rate: 5.5
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Added new Network
"Buffalo-G-8CD8" security psk
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'56:91:e3:16:be:7d' with SSID: tp-link_be85, freq: 5200, rank: 16384,
strength: -2700, data_rate: 2402.0
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'50:91:e3:16:be:7d' with SSID: , freq: 5200, rank: 16384, strength:
-2700, data_rate: 2402.0
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() BSS has hidden SSID
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'f8:b7:97:58:d0:2b' with SSID: KSH5G, freq: 5500, rank: 5911,
strength: -4100, data_rate: 866.7
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'80:22:a7:58:48:ff' with SSID: ntcm1-3a3c49-a, freq: 5180, rank: 204,
strength: -7700, data_rate: 30.0
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'90:f3:05:6a:cc:8e' with SSID: HUMAX-ACC89-A, freq: 5260, rank: 16,
strength: -9000, data_rate: 2.0
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'6c:e4:da:92:4d:56' with SSID: aterm-9bcdbf-g, freq: 2437, rank: 591,
strength: -6700, data_rate: 86.7
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'80:22:a7:58:48:fe' with SSID: ntcm1-3a3c49-g, freq: 2462, rank: 443,
strength: -6500, data_rate: 65.0
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'90:f3:05:6a:cc:96' with SSID: HUMAX-ACC89, freq: 2462, rank: 236,
strength: -7200, data_rate: 28.9
Mar 06 11:40:55 livazplus iwd[747]:
src/station.c:station_add_seen_bss() Processing BSS
'38:f8:5e:8a:ba:43' with SSID: HUMAX-ABA36, freq: 2462, rank: 90,
strength: -8300, data_rate: 11.0
Mar 06 11:40:55 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_done() Work item 3 done
Mar 06 11:41:23 livazplus sudo[1326]:       ken : TTY=3Dpts/0 ;
PWD=3D/home/ken ; USER=3Droot ; COMMAND=3D/usr/bin/iwctl debug wlp4s0
get-networks
Mar 06 11:41:23 livazplus sudo[1326]: pam_unix(sudo:session): session
opened for user root(uid=3D0) by ken(uid=3D1001)
Mar 06 11:41:23 livazplus iwd[747]: src/agent.c:agent_register() agent
register called
Mar 06 11:41:23 livazplus iwd[747]: src/agent.c:agent_register() agent
:1.53 path /agent/1328
Mar 06 11:41:23 livazplus iwd[747]: src/agent.c:agent_disconnect()
agent :1.53 disconnected
Mar 06 11:41:23 livazplus iwd[747]: src/agent.c:agent_free() agent
free 0x5b56da16a030
Mar 06 11:41:23 livazplus sudo[1326]: pam_unix(sudo:session): session
closed for user root
Mar 06 11:42:02 livazplus sudo[1332]:       ken : TTY=3Dpts/0 ;
PWD=3D/home/ken ; USER=3Droot ; COMMAND=3D/usr/bin/iwctl debug wlp4s0
connect 5a:91:e3:16:be:7c
Mar 06 11:42:02 livazplus sudo[1332]: pam_unix(sudo:session): session
opened for user root(uid=3D0) by ken(uid=3D1001)
Mar 06 11:42:02 livazplus iwd[747]: src/agent.c:agent_register() agent
register called
Mar 06 11:42:02 livazplus iwd[747]: src/agent.c:agent_register() agent
:1.54 path /agent/1334
Mar 06 11:42:02 livazplus iwd[747]:
src/station.c:station_force_connect_bssid() Attempting forced
connection to BSS 5a:91:e3:16:be:7c
Mar 06 11:42:02 livazplus iwd[747]:
src/network.c:network_connect_psk() ask_passphrase: true
Mar 06 11:42:02 livazplus iwd[747]:
src/agent.c:agent_request_passphrase() agent 0x5b56da181630 owner
:1.54 path /agent/1334
Mar 06 11:42:02 livazplus iwd[747]:
src/agent.c:agent_send_next_request() send request to :1.54
/agent/1334
Mar 06 11:42:08 livazplus iwd[747]: src/agent.c:agent_receive_reply()
agent 0x5b56da181630 request id 53
Mar 06 11:42:08 livazplus iwd[747]: src/network.c:passphrase_callback() res=
ult 0
Mar 06 11:42:08 livazplus iwd[747]: src/wiphy.c:wiphy_select_akm()
Network is WPA3-Personal...
Mar 06 11:42:08 livazplus iwd[747]:
src/network.c:network_generate_sae_pt() Generating PT for Group 19
Mar 06 11:42:08 livazplus iwd[747]:
src/network.c:network_generate_sae_pt() Generating PT for Group 20
Mar 06 11:42:08 livazplus iwd[747]: src/wiphy.c:wiphy_select_akm()
Network is WPA3-Personal...
Mar 06 11:42:08 livazplus iwd[747]:
src/network.c:network_set_handshake_secrets_psk() Authenticator is SAE
H2E capable
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_cqm_rssi_update()
Mar 06 11:42:08 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 4
Mar 06 11:42:08 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_next() Starting work item 4
Mar 06 11:42:08 livazplus iwd[747]:
src/station.c:__station_connect_network() connecting to BSS
56:91:e3:16:be:7d
Mar 06 11:42:08 livazplus iwd[747]:
src/station.c:station_enter_state() Old State: disconnected, new
state: connecting
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_auth_cb()
Error during auth: -2
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.2063] device (wlp4s0): new IWD device state is connecting
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.2075] device (wlp4s0): Activation: starting connection
'tp-link_be85' (c80da4d8-3a60-45c5-bc17-b421686b8270)
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.2077] device (wlp4s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Mar 06 11:42:08 livazplus iwd[747]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.2080] device (wlp4s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_new_scan_results_ev=
ent()
Mar 06 11:42:08 livazplus iwd[747]: src/scan.c:scan_notify() Scan
notification New Scan Results(34)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification New Station(19)
Mar 06 11:42:08 livazplus kernel: wlp4s0: authenticate with
56:91:e3:16:be:7d (local address=3Da0:02:a5:e0:72:b6)
Mar 06 11:42:08 livazplus kernel: wlp4s0: send auth to
56:91:e3:16:be:7d (try 1/3)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Authenticate(37)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_authenticate_event(=
)
Mar 06 11:42:08 livazplus kernel: wlp4s0: 56:91:e3:16:be:7d denied
authentication (status 77)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Del Station(20)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification New Station(19)
Mar 06 11:42:08 livazplus kernel: wlp4s0: authenticate with
56:91:e3:16:be:7d (local address=3Da0:02:a5:e0:72:b6)
Mar 06 11:42:08 livazplus kernel: wlp4s0: send auth to
56:91:e3:16:be:7d (try 1/3)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Authenticate(37)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_authenticate_event(=
)
Mar 06 11:42:08 livazplus kernel: wlp4s0: authenticate with
56:91:e3:16:be:7d (local address=3Da0:02:a5:e0:72:b6)
Mar 06 11:42:08 livazplus kernel: wlp4s0: send auth to
56:91:e3:16:be:7d (try 1/3)
Mar 06 11:42:08 livazplus kernel: wlp4s0: authenticated
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Authenticate(37)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_authenticate_event(=
)
Mar 06 11:42:08 livazplus kernel: wlp4s0: associate with
56:91:e3:16:be:7d (try 1/3)
Mar 06 11:42:08 livazplus kernel: wlp4s0: RX AssocResp from
56:91:e3:16:be:7d (capab=3D0x1511 status=3D0 aid=3D16)
Mar 06 11:42:08 livazplus kernel: wlp4s0: associated
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Associate(38)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_associate_event()
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Connect(46)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_connect_event()
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_connect_event() aborting and ignore_connect_event
not set, proceed
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_connect_event() expect_connect_failure not set,
proceed
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:parse_request_ies()
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_connect_event() Request / Response IEs parsed
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_get_oci()
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_get_oci_cb()
Obtained OCI: freq: 5200, width: 5, center1: 5250, center2: 0
Mar 06 11:42:08 livazplus iwd[747]: src/eapol.c:eapol_start()
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_unicast_notify() Unicast notification Control Port
Frame(129)
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_control_port_frame_event()
Mar 06 11:42:08 livazplus iwd[747]:
src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D5
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Control Port TX Status(139)
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_unicast_notify() Unicast notification Control Port
Frame(129)
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_control_port_frame_event()
Mar 06 11:42:08 livazplus iwd[747]:
src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D5
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_set_gtk()
ifindex=3D5 key_idx=3D1
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_set_igtk()
ifindex=3D5 key_idx=3D4
Mar 06 11:42:08 livazplus iwd[747]:
src/station.c:station_handshake_event() Setting keys
Mar 06 11:42:08 livazplus iwd[747]: src/network.c:network_sync_settings()
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_set_tk()
ifindex=3D5 key_idx=3D0
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_set_rekey_offload()=
 5
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_new_group_key_cb() ifindex: 5, err: 0
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed:
1, igtk_installed: 0
Mar 06 11:42:08 livazplus kernel: wlp4s0: Limiting TX power to 23 (23
- 0) dBm as advertised by 56:91:e3:16:be:7d
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_new_group_management_key_cb() ifindex: 5, err: 0
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_installed:
1, igtk_installed: 1
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Control Port TX Status(139)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_set_station_cb()
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_installed:
1, igtk_installed: 1
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:try_handshake_complete() nhs->complete: 0
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:try_handshake_complete() Invoking handshake_event()
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_connect_ok()
Mar 06 11:42:08 livazplus iwd[747]: src/station.c:station_connect_cb()
5, result: 0
Mar 06 11:42:08 livazplus iwd[747]: src/station.c:station_connect_ok()
Mar 06 11:42:08 livazplus iwd[747]:
src/station.c:station_enter_state() Old State: connecting, new state:
connected
Mar 06 11:42:08 livazplus iwd[747]:
src/wiphy.c:wiphy_radio_work_done() Work item 4 done
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_link_notify()
event 16 on ifindex 5
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Frame TX Status(60)
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.5379] device (wlp4s0): new IWD device state is connected
Mar 06 11:42:08 livazplus iwd[747]: src/agent.c:agent_disconnect()
agent :1.54 disconnected
Mar 06 11:42:08 livazplus iwd[747]: src/agent.c:agent_free() agent
free 0x5b56da181630
Mar 06 11:42:08 livazplus sudo[1332]: pam_unix(sudo:session): session
closed for user root
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.5390] device (wlp4s0): state change: config -> ip-config
(reason 'none', sys-iface-state: 'managed')
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
Mar 06 11:42:08 livazplus iwd[747]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-21)
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.5443] dhcp4 (wlp4s0): activation: beginning transaction
(timeout in 45 seconds)
Mar 06 11:42:08 livazplus avahi-daemon[597]: Joining mDNS multicast
group on interface wlp4s0.IPv6 with address fe80::58f3:30cf:d2ca:d07f.
Mar 06 11:42:08 livazplus avahi-daemon[597]: New relevant interface
wlp4s0.IPv6 for mDNS.
Mar 06 11:42:08 livazplus avahi-daemon[597]: Registering new address
record for fe80::58f3:30cf:d2ca:d07f on wlp4s0.*.
Mar 06 11:42:08 livazplus iwd[747]:
src/station.c:station_early_neighbor_report_cb() ifindex: 5, error:
0()
Mar 06 11:42:08 livazplus iwd[747]:
src/station.c:parse_neighbor_report() Neighbor report received for
5a:91:e3:16:be:7c: ch 2 (oper class 0), MD not set
Mar 06 11:42:08 livazplus iwd[747]:
src/station.c:parse_neighbor_report() Neighbor report received for
4e:91:e3:16:be:70: ch 37 (oper class 134), MD not set
Mar 06 11:42:08 livazplus iwd[747]:
src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.5614] dhcp4 (wlp4s0): state changed new lease,
address=3D192.168.3.3
Mar 06 11:42:08 livazplus avahi-daemon[597]: Joining mDNS multicast
group on interface wlp4s0.IPv4 with address 192.168.3.3.
Mar 06 11:42:08 livazplus avahi-daemon[597]: New relevant interface
wlp4s0.IPv4 for mDNS.
Mar 06 11:42:08 livazplus avahi-daemon[597]: Registering new address
record for 192.168.3.3 on wlp4s0.IPv4.
Mar 06 11:42:08 livazplus dbus-daemon[600]: [system] Activating via
systemd: service name=3D'org.freedesktop.nm_dispatcher'
unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.12'
(uid=3D0 pid=3D658 comm=3D"/usr/sbin/NetworkManager --no-daemon")
Mar 06 11:42:08 livazplus systemd-resolved[504]: wlp4s0: Bus client
set default route setting: yes
Mar 06 11:42:08 livazplus systemd-resolved[504]: wlp4s0: Bus client
set DNS server list to: 192.168.3.1, 8.8.8.8
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.5807] device (wlp4s0): state change: ip-config -> ip-check
(reason 'none', sys-iface-state: 'managed')
Mar 06 11:42:08 livazplus systemd[1]: Starting
NetworkManager-dispatcher.service - Network Manager Script Dispatcher
Service...
Mar 06 11:42:08 livazplus dbus-daemon[600]: [system] Successfully
activated service 'org.freedesktop.nm_dispatcher'
Mar 06 11:42:08 livazplus systemd[1]: Started
NetworkManager-dispatcher.service - Network Manager Script Dispatcher
Service.
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.6206] device (wlp4s0): state change: ip-check ->
secondaries (reason 'none', sys-iface-state: 'managed')
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.6208] device (wlp4s0): state change: secondaries ->
activated (reason 'none', sys-iface-state: 'managed')
Mar 06 11:42:08 livazplus NetworkManager[658]: <info>
[1709692928.6214] device (wlp4s0): Activation: successful, device
activated.
Mar 06 11:42:10 livazplus NetworkManager[658]: <info>
[1709692930.8452] dhcp6 (wlp4s0): activation: beginning transaction
(timeout in 45 seconds)
Mar 06 11:42:18 livazplus systemd[1]:
NetworkManager-dispatcher.service: Deactivated successfully.
Mar 06 11:42:21 livazplus iwd[747]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
Mar 06 11:42:21 livazplus iwd[747]: src/netdev.c:netdev_cqm_event()
Signal change event (above=3D1 signal=3D-15)

2024=E5=B9=B43=E6=9C=885=E6=97=A5(=E7=81=AB) 21:11 James Prestwood <prestwo=
j@gmail.com>:
>
> Hi,
>
> On 3/5/24 2:20 AM, Kentaro Yamaguchi wrote:
> > Hi James,
> > Thank you for answering.
> > I tried it right away, but unfortunately I couldn't connect to the
> > desired BSSID.
> > Even if you specify the BSSID, if the same SSID exists, it seems that
> > the connection will be made according to the RANK.
> >
> > When I specified the BSSID on the 2GHz side below and connected, it
> > connected to the BSSID on the 5GHz side.
> > I tried it 3 times and got the same result all three times.
>
> Could you check the IWD logs as to why? I have a feeling the connection
> to ":7c" just failed so IWD moved onto another BSS?
>
> >
> > access point
> > -------------------------------------------------------
> >      SSID  BSSID              RSSI  Freq    Rank      MDE
> > -----------------------------------------------------------------------=
---------
> >      tp-link_be85
> >            4e:91:e3:xx:xx:70  -25   6135    16384     000000
> >            5a:91:e3:xx:xx:7d  -25   5240    16384     000000
> >            56:91:e3:xx:xx:7c  -6    2417    3912      000000
> >
> >
> > connection
> > -------------------------------------------------------
> > Execute the commands in the following order.
> >
> > $ sudo /usr/libexec/iwd -E &
> > $ sudo iwctl station wlp4s0 scan
> > $ sudo iwctl debug wlp4s0 connect 56:91:e3:xx:xx:7c
> > Type the network passphrase for tp-link_be85 psk.
> > Passphrase: ********
> >
> >
> > Check the connection destination
> > -------------------------------------------------------
> >
> > $ iw dev wlp4s0 link
> > Connected to 5a:91:e3:xx:xx:7d (on wlp4s0)
> >          SSID: tp-link_be85
> >          freq: 5240.0
> >          RX: 7401 bytes (70 packets)
> >          TX: 8867 bytes (77 packets)
> >          signal: -19 dBm
> >          rx bitrate: 1441.3 MBit/s 160MHz EHT-MCS 7 EHT-NSS 2 EHT-GI 0
> >          tx bitrate: 576.4 MBit/s 160MHz EHT-MCS 3 EHT-NSS 2 EHT-GI 0
> >          bss flags: short-slot-time
> >          dtim period: 1
> >          beacon int: 100
> >
> > Thanks,
> >
> > Kentaro Yamaguchi
> >
> > 2024=E5=B9=B43=E6=9C=884=E6=97=A5(=E6=9C=88) 21:23 James Prestwood <pre=
stwoj@gmail.com>:
> >> Hi Kentaro,
> >>
> >> On 3/3/24 8:31 PM, Kentaro Yamaguchi wrote:
> >>> Dear iwd users and developers,
> >>>
> >>> With mesh, I would like to check whether it is faster to connect
> >>> directly to the child device or the parent device.
> >>> Therefore, please tell me how to connect using iwd from the client an=
d
> >>> specifying the BSSID.
> >>>
> >>> According to the comment made 5 years ago at the link below, there is
> >>> no way to connect by specifying the BSSID.
> >>> This has been answered, but is the situation still the same?
> >>> https://bbs.archlinux.org/viewtopic.php?id=3D237074&p=3D5
> >> Yes IWD connections are SSID based and IWD chooses the best BSS based =
on
> >> how it ranks.
> >>
> >> For testing IWD does have a "developer mode" which lets you connect to
> >> BSSID's specifically but this mode isn't something meant for
> >> general/production use. But if you only want to test one vs the other
> >> you could use it:
> >>
> >> # Start IWD in developer mode (-E)
> >> iwd -E
> >> # Scan first (developer mode doesn't autoconnect)
> >> iwctl station wlan0 scan
> >> iwctl debug wlan0 get-networks
> >> iwctl wlan0 connect <bssid>
> >>
> >> Thanks,
> >>
> >> James
> >>
> >>> I tried the following, but I was unable to connect due to an error.
> >>> I know that using wpa_supplicant as the Network Manager backend will
> >>> work. However, in that case I would like to use IWD because I have
> >>> problems with 6GHz connectivity.
> >>>
> >>> 1. Specify iwd as wifi.backend of NetworkManager and restart.
> >>> 2. nmcli device wifi connect [SSID] password [Password]
> >>> 3. nmcli connection down [SSID]
> >>> 4. nmcil connection modify [SSID] wifi.bssid [BSSID]
> >>> 5. nmcli connection up [SSID]
> >>>
> >>> Error (from journal log)
> >>> -------------------------------------
> >>> Mar 01 16:38:48 livazplusNetworkManager[1408]: <info>
> >>> [1709278728.5365] device (wlp4s0): Activation: starting connection
> >>> 'Buf-MLO' (019cd427-8f11-4c84-9625-db03895b510b)
> >>> Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
> >>> [1709278728.5367] device (wlp4s0): state change: disconnected ->
> >>> prepare (reason 'none', sys-iface-state: 'managed')
> >>> Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
> >>> [1709278728.5370] device (wlp4s0): state change: prepare -> failed
> >>> (reason 'none', sys-iface-state: 'managed')
> >>> Mar 01 16:38:48 livazplus NetworkManager[1408]: <warn>
> >>> [1709278728.5374] device (wlp4s0): Activation: failed for connection
> >>> 'Buf-MLO'
> >>>
> >>> My environment is below.
> >>> --------------------------------------
> >>> Lubuntu 23.10
> >>> Kernel 6.7.6
> >>> IWD 2.8
> >>> NetworkManager 1.44.2
> >>> Intel BE200
> >>> [    5.297551] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> >>> Version: 0.0.4.125
> >>> [    5.302086] iwlwifi 0000:01:00.0: loaded firmware version
> >>> 86.fb5c9aeb.0 gl-c0-fm-c0-86.ucode op_mode iwlmvm
> >>> [    5.764947] iwlwifi 0000:01:00.0: loaded PNVM version 8443a58d
> >>> --------------------------------------
> >>>
> >>> Thanks in advance!
> >>> Kentaro Yamaguchi
> >>>
