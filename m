Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65452442C
	for <iwd@lists.linux.dev>; Fri,  3 Jan 2025 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735942630; cv=none; b=bhKAlrgYuw0IUDJhTvvukOcXgL4zl7FIXTfUlpImE+4L6e0MXZdpf9NJOYoDxC12RUbw2939/8cPC5dNYo2H2tgbQr9jaXvitt9m8bo5NqZs0DNSP3F3p4s2iX07a8ERcoE2lgA7dC1SFpr2fXVfELzAhiadLuJnGHZUUgojAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735942630; c=relaxed/simple;
	bh=2oDxRBIG18RlNtLno5HB7fQyFOXNhmO4xrOEXQSYTyw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZWXtnYzOZV6UtdGW6QMEVgBqyxlufMUNA0yXhRo1bfuEGb125FDXEz27Cr5ec5mHGO2LSiOa0rz7owuAqO2QuLKRlJmq+IZFYBcJO84Kj4LFy342fJYeCqHGG6mP+5+KNhgdVLzJ6eXSu9Ajk3IwMkAf8zdGpXYhIEi5OKv0Twk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAvF5euz; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAvF5euz"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so5154522276.1
        for <iwd@lists.linux.dev>; Fri, 03 Jan 2025 14:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735942625; x=1736547425; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l3vvQbd1mHHZfCzLyrUXgsaYxQDt4vBSI3Ne5BIlV/w=;
        b=gAvF5euzHdA55gtQ4ktutWeoTggNU+XNh5lPBfxVnfweOvzI4n6xnTfTi+b0mAVCAQ
         hXBGymTW/g8/Ciep16Q/igruU1cpbZMsbMib0/BT8fxlISD9iH+1qoCRutc0kaGqj9zu
         rlEkMoBKqHhzFJFmmV01fdEkLFZ8HR2EgJ3MdnC1+vZkXxYzN1xmbshtqSt04sVRxQCf
         cm9kQ+bf3iwtfLsuUqva7ktVlLc30jIRf1OWerm/PojpPaBHUn6ATKp7G4VGdLOQqBTt
         WHdK0J3DsQwxpUnK2gU1i1mFblK6E4ifS1OWnEv4lDlawEl4zcNRFrLnrWT+zKYebUA0
         1QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735942625; x=1736547425;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3vvQbd1mHHZfCzLyrUXgsaYxQDt4vBSI3Ne5BIlV/w=;
        b=N+n1pv0wHMsuRlzXQVQAeHqDnm5BKboZYZ2cwfD5M1JSQEg8DnPdhV+nSMNbXcEp0U
         86DaPYhIovBXrwcIWvw2VdF4eE7qyRDDEnFyAkkyptwZs+rvsKsDHjYOdkTARZEuuRXB
         JCEwFqKdUS00FQTMPrPVTqXfqj14CppUO9xYS+Q5lnrBOa2nZvtM3Qfjqe26Y72zUk70
         dpD7+H/dktVr0q+1njS3s0smP73+PcVn6Ip0QWkWtJRzU78JIQm8ttQfdkOMvaTMzRQL
         gq0HawJRYlJ5hAdOCUQ2audl3FTDWP9H2GBcSZsRimxZqHLRJR1spMyLq2dj+3KkxKQQ
         Tb2g==
X-Gm-Message-State: AOJu0YzeSyELuW/xCqAbPW/DGVUFFwL82sFMOAUdITyx9UD2tg8GpUaZ
	Z6rI0bP/sQKSL/Oem2/d++TFViVaZdahXAF8OYZHZKuzHdoNEZE7oDBKV10sGm8srkN8DX4pBF2
	OOoFbqFl9FvkZqD3q0jhrQS+fjG6YdIrS
X-Gm-Gg: ASbGncsa/bvjG4iULZoMRvI5N4uOESdrIrp2lwq9BdC741bfdUFVlN9EAdv1670tORm
	Cbw0xbzpijwR+n6b8qyYSsQzFKLXWsHM8svYgxHAQzE7d4qRCNY+5JWck4BvUe/iChg==
X-Google-Smtp-Source: AGHT+IF3TsfPlKbWdVYvGpZJqnKRItlLQBtf2EgdInNExhMj7MRezch2Fou891A07IFHBy21GfhdKf9CnpxcgNh24FA=
X-Received: by 2002:a05:690c:7203:b0:6f0:21d6:449a with SMTP id
 00721157ae682-6f3f80e60a1mr392643407b3.6.1735942625033; Fri, 03 Jan 2025
 14:17:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Owen Garland <garland.owen@gmail.com>
Date: Fri, 3 Jan 2025 23:16:29 +0100
Message-ID: <CAPDaQ_wdXGvy7Sa=10bSC7eAbLut4Jw_CP16Xob7aVtqgCYxSg@mail.gmail.com>
Subject: Repeated Deauthentication event, reason: 4
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hej all,

I couldn't find an issue tracker so I am trying here. Essentially my
problem is I get deauthenticated from AP's at seemingly random
intervals, with `reason: 4`.

iwd --version: 3.3
OS: Arch-Linux 6.11.9-arch1-1
Device: Dell XPS 9370
Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
        Subsystem: Intel Corporation Device 8050
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi
iwconfig:
  wlan0     IEEE 802.11  ESSID:"Tronx_Upper"
           Mode:Managed  Frequency:2.422 GHz  Access Point: 22:D2:CC:07:9C:=
B5
           Bit Rate=3D65 Mb/s   Tx-Power=3D22 dBm
           Retry short limit:7   RTS thr:off   Fragment thr:off
           Power Management:off
           Link Quality=3D31/70  Signal level=3D-79 dBm
           Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
           Tx excessive retries:209  Invalid misc:664   Missed beacon:0

The logs from `journactl -u iwd` show this:

Jan 03 21:52:09 titanium systemd[1]: Starting Wireless service...
Jan 03 21:52:09 titanium iwd[318201]: Wireless daemon version 3.3
Jan 03 21:52:09 titanium iwd[318201]: Loaded configuration from
/etc/iwd/main.conf
Jan 03 21:52:09 titanium systemd[1]: Started Wireless service.
Jan 03 21:52:09 titanium iwd[318201]: Wiphy: 0, Name: phy0
Jan 03 21:52:09 titanium iwd[318201]:         Permanent Address:
64:5d:86:ed:80:5a
Jan 03 21:52:09 titanium iwd[318201]:         2.4GHz Band:
Jan 03 21:52:09 titanium iwd[318201]:                 Bitrates (non-HT):
Jan 03 21:52:09 titanium iwd[318201]:                          1.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                          2.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                          5.5 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         11.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                          6.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                          9.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         12.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         18.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         24.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         36.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         48.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         54.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                 HT Capabilities:
Jan 03 21:52:09 titanium iwd[318201]:                         HT40
Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for =
20Mhz
Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for =
40Mhz
Jan 03 21:52:09 titanium iwd[318201]:                 HT RX MCS indexes:
Jan 03 21:52:09 titanium iwd[318201]:                         0-15
Jan 03 21:52:09 titanium iwd[318201]:         5GHz Band:
Jan 03 21:52:09 titanium iwd[318201]:                 Bitrates (non-HT):
Jan 03 21:52:09 titanium iwd[318201]:                          6.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                          9.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         12.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         18.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         24.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         36.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         48.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                         54.0 Mbps
Jan 03 21:52:09 titanium iwd[318201]:                 HT Capabilities:
Jan 03 21:52:09 titanium iwd[318201]:                         HT40
Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for =
20Mhz
Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for =
40Mhz
Jan 03 21:52:09 titanium iwd[318201]:                 HT RX MCS indexes:
Jan 03 21:52:09 titanium iwd[318201]:                         0-15
Jan 03 21:52:09 titanium iwd[318201]:                 VHT Capabilities:
Jan 03 21:52:09 titanium iwd[318201]:                         Short GI for =
80Mhz
Jan 03 21:52:09 titanium iwd[318201]:                         Max RX
MCS: 0-9 for NSS: 2
Jan 03 21:52:09 titanium iwd[318201]:                         Max TX
MCS: 0-9 for NSS: 2
Jan 03 21:52:09 titanium iwd[318201]:         Ciphers: BIP-CMAC-128
CCMP-128 TKIP
Jan 03 21:52:09 titanium iwd[318201]:         Supported iftypes:
ad-hoc station ap p2p-client p2p-go p2p-device
Jan 03 21:52:09 titanium iwd[318201]: event: state, old: disconnected,
new: autoconnect_quick
Jan 03 21:52:09 titanium iwd[318201]: udev interface=3Dwlan0 ifindex=3D6
Jan 03 21:52:10 titanium iwd[318201]: event: connect-info, ssid:
Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -79, load: 0/255
Jan 03 21:52:10 titanium iwd[318201]: event: state, old:
autoconnect_quick, new: connecting (auto)
Jan 03 21:52:10 titanium iwd[318201]: event: state, old: connecting
(auto), new: connecting (netconfig)
Jan 03 21:52:10 titanium iwd[318201]: event: state, old: connecting
(netconfig), new: connected
Jan 03 21:52:15 titanium iwd[318201]: event: roam-scan,
<truncated>
Jan 03 22:41:53 titanium iwd[318201]: Received Deauthentication event,
reason: 4, from_ap: false
Jan 03 22:41:53 titanium iwd[318201]: event: disconnect-info, reason: 4
Jan 03 22:41:53 titanium iwd[318201]: event: state, old: connected,
new: disconnected
Jan 03 22:41:53 titanium iwd[318201]: event: state, old: disconnected,
new: autoconnect_quick
Jan 03 22:41:54 titanium iwd[318201]: event: state, old:
autoconnect_quick, new: autoconnect_full
Jan 03 22:42:13 titanium iwd[318201]: event: connect-info, ssid:
Tronx_Upper, bss: 22:d2:cc:07:9c:b5, signal: -79, load: 0/255
Jan 03 22:42:13 titanium iwd[318201]: event: state, old:
autoconnect_full, new: connecting (auto)
Jan 03 22:42:17 titanium iwd[318201]: event: state, old: connecting
(auto), new: connecting (netconfig)
Jan 03 22:42:18 titanium iwd[318201]: event: state, old: connecting
(netconfig), new: connected

This then appears to happen several times, and at seemingly random
intervals. It can be fine for several hours, then there is one
disconnect, or there may be a few disconnects in a short time. As an
example the 28th had this:

 Dec 28 15:40:49 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 15:41:12 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 16:02:27 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 16:13:12 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 16:13:27 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 16:34:55 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 17:02:41 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 17:11:34 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 17:16:38 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 17:20:27 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 17:25:01 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 18:52:40 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 20:21:20 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 20:21:28 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 20:21:46 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false
 Dec 28 21:07:33 titanium iwd[869]: Received Deauthentication event,
reason: 4, from_ap: false

My investigations haven't led to much, not having a publicly viewable
issue tracker is certainly not helping. I have found a few other
threads where people have had this issue, however none of the proposed
remedies have made an impact. The one thing I did try was disabling
powersaving by adding this to my config:

~ =CE=BB cat /etc/modprobe.d/iwlwifi.conf
options iwlmvm power_scheme=3D1
options iwlwifi power_save=3D0

 Any suggestions on where to take this, and let me know if I can
provide you with any further information.

Thanks for making open source software <3
