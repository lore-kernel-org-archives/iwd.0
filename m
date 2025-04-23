Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151C22097
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370022; cv=none; b=qWrAGDBvtcFOmJceBlg3zAGDAR4Ow8se7Ud7ZSl0eDcrAMY8r0KUIf+gNUYidnPHVm2eSt/odiGcmiKKloJLRsBsmFHkNpnfYWGxXR+Hr1T4WhFnwYf9+ojuabCs4AW9dU1vyTRwKxHGVj/G4QJihtDu8vWotoIVETLPeDMld74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370022; c=relaxed/simple;
	bh=nUJmBlRcy8yUglRoEEGU8ODifrqycrBN7ShDEAdKt0Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rmUJ+9ss5jBnn+ddCvJeeph9/6Z74nu6AHMPy9X8KcwgpB2NsBdDBNxLIoaIeGXH3XGo2HhW+3fjKFVS4A8VAAIPhJVpw4PTM+t1Xo7JN6UQwN8VWtKtJptqiG9w0YodNteJdX711euKZdT13TFnAzBn2oZklNWLQRnuFhH467E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J896KlUt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J896KlUt"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b061a06f127so3961459a12.2
        for <iwd@lists.linux.dev>; Tue, 22 Apr 2025 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745370020; x=1745974820; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DaFZHu5dsSpDfcE/CuuaWLP494bhHUDBxZu6kt6NAq8=;
        b=J896KlUtsaEERw8JBlJ0rWOcZMBRkG4S/UT0He8EJuH/V+zAYWc5lDHdsEtEUdvYC6
         gJ88fvaSqDcLTQPD7uTcsYxq23/0KkZGt99NbKMh0tNb5rR/UvhiOkbecJGROEwAPbv6
         bf4obyhFUAcL+R4eJTGv1DFExp4u1uFVgmp2dpnLhxYbPtgvEM0Ba0xlDAkK9EUtvLtX
         jU+CUwhl64JW7EyN1qyuyYBMlqxjJuh9+9xMBqcA0kvRTHahks3Mjo9pWN2giJoPMSmV
         xtww7mkuN9XubY0ubPFWq3tgWEXGM1PQqeOgL6LdK9dkbNNMkKUTxowrksuyqaF6tcmF
         PC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745370020; x=1745974820;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DaFZHu5dsSpDfcE/CuuaWLP494bhHUDBxZu6kt6NAq8=;
        b=hB1KmIB07CfccPVXfSa1IcjCndWjM8VeWA2QPZV6w3dhYZFu5wsC4/r7Jltf+79QQm
         23ANSVGDkw49EGHNlms0djHqpgUcUVozEdo+e7AHEUy0VlasDQLh+8e/Pcd90ZH591u8
         3y587n+gUAixs0v85qcJWMighjZTHDB4dopck/XGTaSRqKjIc4ajRqfwT08U/DRMOhMB
         roSFyJyQHE+9xvpMIfSrmhhF5m/K64Vmd8cWtz5rMnT0loEHFO0+8xgOAPH8MPY4w9gJ
         7wvor5hGeeri/S5+dJ6yg1Rty1UAYUkgWtdHg03leK40Movc+cKbuihxjUlVxvPtz/tV
         2jSw==
X-Gm-Message-State: AOJu0YyUZ0xyN15JGH33gP15KaBsdfVOC0xsjElXFGQNFPDTlb+T6O/J
	fKRHH7xukkOx5O3tf/fvNQFa2yD9Se+WVIZi4iw3ZsITZNy85iZsZy2NmS+i1qcI6O+qJUq9vcM
	TAjqD85HCyMfASlgWkYLKtjuBFeIoaonF
X-Gm-Gg: ASbGncuOvCAoEQsTl0+/keHhfzPKq91GlXbR2DRR0UiuqBo1U/8O1ti3xm4gEWjBFkX
	8mV0Mn2nsfqicXsQ6FJJmTjdp7c8bZjNknQzGO6nE4hLjyRIgkmUN73a2OqEvSI8HW89XBh2tJ0
	JEC19PXJBBZxbbFfFmjf7flYsHw7OqaDOIp/U=
X-Google-Smtp-Source: AGHT+IF26QTSrFwSdlb4QU9ppzQoLtiSDDA0/aVdvxcB3FxATezO24OUa47t/gZ8E1Y0HfCnZ48ufTLS3+tLK8PqmJY=
X-Received: by 2002:a17:90b:5410:b0:2ff:71ad:e84e with SMTP id
 98e67ed59e1d1-3087bb4cffdmr26881767a91.10.1745370020506; Tue, 22 Apr 2025
 18:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 22 Apr 2025 20:00:05 -0500
X-Gm-Features: ATxdqUGdn3lPeny-QFXnYUKZnqBCMIkhYSxdEPj3XcGwxUAHdxNLGG2QqEEhrH8
Message-ID: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
Subject: brcmfmac disconnects when iwd scans
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

I ran into this a while back and James came up with a few patches that
I have been using to keep it from restarting the AP0 interface.
[PATCH 1/3] station: remove scan subsets for dbus scans
[PATCH 2/3] eap: fix compile issue on ARM/GCC 12
[PATCH 3/3] scan: use ifindex and only active scans

These no longer seem to work with current builds of iwd from git. I am
running iwd 3.6.r10.g4ded663e. My kernel is 6.12.20. The firmware is:
[    3.496006] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    3.839254] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
01-95efe7fa

I get the same response with the firmware that ships with RPiOS,
7.45.265 as well. I am building a fresh kernel to be able to get iwmon
data and should be able to do so tomorrow.

This flakiness of ap0 happens regardless if I use iwd or hostap to
bring up ap0. When I use hostapd, I use this to bring up the
interface:

iw dev wlan0 interface add ap0 type __ap
ip link set dev ap0 address d8:3a:dd:60:a3:cg
systemctl start hostapd
systemctl start dnsmasq
ip addr add 192.168.5.1/24 broadcast 192.168.5.255 dev ap0

With this, I can have the ap0 up and can scan on wlan0 with the single
brcmfmac card. If I use wpa_supplicant, ap0 does not go down when
wpa_supplicant scans for ssids.
iw wlan0 scan
It is only with iwd that the network goes down when iwd scans for ssids.
iwctl station wlan0 scan

This is what it shows in the log (with brcmfmac debug) when it scans:
lost of scan redults above then:
Apr 22 18:27:24 pi4 hostapd[32625]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 22 18:27:24 pi4 hostapd[32625]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 22 18:27:24 pi4 kernel: brcmfmac: brcmf_rx_event Enter:
mmc1:0001:1: rxp=00000000a28ac6b0
Apr 22 18:27:24 pi4 kernel: brcmfmac: brcmf_rx_event Enter:
mmc1:0001:1: rxp=00000000a28ac6b0
Apr 22 18:27:24 pi4 kernel: brcmfmac: brcmf_fweh_event_worker event
DEAUTH_IND (6:6) ifidx 1 bsscfg 1 addr 50:84:92:a6:7a:7a
Apr 22 18:27:24 pi4 kernel: brcmfmac: brcmf_fweh_event_worker
version 2 flags 0 status 0 reason 4
Apr 22 18:27:24 pi4 kernel: brcmutil: event payload, len=2
Apr 22 18:27:24 pi4 kernel: 00000000: 04 00
                ..
Apr 22 18:27:24 pi4 kernel: brcmfmac: brcmf_fweh_event_worker event
DISASSOC_IND (12:12) ifidx 1 bsscfg 1 addr 50:84:92:a6:7a:7a
Apr 22 18:27:24 pi4 kernel: brcmfmac: brcmf_fweh_event_worker
version 2 flags 0 status 0 reason 8
Apr 22 18:27:24 pi4 kernel: brcmutil: event payload, len=0
Apr 22 18:27:24 pi4 kernel: brcmfmac: CONSOLE: 001705.564 wl0:
wlc_recvfilter: scb is null, dont resend deauth
Apr 22 18:27:24 pi4 hostapd[32625]: ap0: STA 50:84:92:a6:7a:7a IEEE
802.11: disassociated
Apr 22 18:27:24 pi4 kernel: brcmfmac: brcmf_rx_event Enter:
mmc1:0001:1: rxp=00000000102035b7
Apr 22 18:27:24 pi4 kernel: brcmfmac: brcmf_fweh_event_worker event
DEAUTH (5:5) ifidx 1 bsscfg 1 addr 50:84:92:a6:7a:7a
Apr 22 18:27:24 pi4 kernel: brcmfmac: brcmf_fweh_event_worker
version 2 flags 0 status 0 reason 7
Apr 22 18:27:24 pi4 kernel: brcmutil: event payload, len=0
Apr 22 18:27:25 pi4 kernel: brcmfmac: CONSOLE: 001705.683 wl0:
wlc_recvfilter: scb is null, dont resend deauth
Apr 22 18:27:25 pi4 kernel: brcmfmac: brcmf_rx_event Enter:
mmc1:0001:1: rxp=00000000baa46293
