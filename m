Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFC1EEE3
	for <iwd@lists.linux.dev>; Sun,  4 Aug 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722791347; cv=none; b=dAq6m+I8u75sm9p/cndYd0j8fShWdZ7/EG9CccALnFaVRfeTHJHXF3Q7KvOMGIbf5DxGlsqW+r/MRepj/ku7OlztBmFXzTMKb39n4LaKDpqzpFE/IS+Rb7WUlQr5aQqct6Z8SF7H7ESryiW1i9sNsik7utK3+B60p9isMlC+Mhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722791347; c=relaxed/simple;
	bh=A4mj10ZYr2hlBe6e0JIbRTll8lsqXiYJ4MPNq3zdDsw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LmJNeY0eLeRKgSp3q6Cu/OkeYAnY2iNNXf2IwTD2YOEHIaoot9flJtUwJVtIvuXVyvDRagiP3ukhBu5mu2zXCBOp2unYl4sMle1TbIb6iDaJpg2gJClVh1oCoOldC4kALrvtgyfv4str6mdJ02QqS3TsGQCy9Pc69xz40k/ad8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8rNwmfZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8rNwmfZ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cf11b91813so6430389a91.1
        for <iwd@lists.linux.dev>; Sun, 04 Aug 2024 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722791345; x=1723396145; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2UwB6j78KOjxpXUQeDAHXVHu0j9fzr4i2/bNJ9AS7oI=;
        b=X8rNwmfZ5pK1U3KR1+u++yP6gtEYpD3FOEkpAoTS1NkjnIxWE8fdTD4P7Ade1Xg16W
         jKh6gqbRVoOwSF3oKysbslbA3y3GeO7gPqZeJ1s1HgnZn882/rNvnM8ocDBHaFRffmEj
         6kayEXLecpNLIN7E77UCtvylLwsQd7Xkx0L4Gx2nAdu623EI9ATIGHr+UrdMEpnu0fyn
         28VjDqNB/7OpzBe9upiHuT08R7QsT0ySPl388vc/X+KRNXdqW/1Cfa+OTEjmz6rOIAko
         xyyN7CGmHfpoNeHcaOxhIx5wMJVePbpyDhuCx9O4Ir6BY3TSddmAUqx0ZjSsD7RVx31B
         GU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722791345; x=1723396145;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UwB6j78KOjxpXUQeDAHXVHu0j9fzr4i2/bNJ9AS7oI=;
        b=hhOmh3JEGTZ0AkXMoEXHzQnlbqQqlHxZ5ZjsEuVaBgv66Kr/fyPwWwYXInMfHSaZ/o
         Ycftzz0+MxKTVI+QVfsPkFunAAjvjTWiTnimphGF9Uf7JrPsmezPO7MQTAtZap6sIvbQ
         vPZfSDnLq+4FAKu08HDhkGOA+lJAxmetMVdmof/Pl9VmYXkax9NXnhSpXYqiDm73tGmo
         dfkIiCXqmzsfESWGiYiSofPmdhSPjRz7y1wSMFAin9fGAwLczMCQeGwIrUoIhH2oVXkh
         rAX03DIuIyKh8MrTiHFVP2Tcvm+LXEu11TiyjkXnvhk7Qo64L/xzvFeR8keifUQ2dBgs
         rePQ==
X-Gm-Message-State: AOJu0Yy2d+/zJQ6pyVDPAsuQmNSk/1qL7zphQK6LqRcOOM1aToRtiFHt
	m7cy5WRwCuWe1GzBeQAGo7Zj4q6Hq/KfseZhd0GW9TpXi5GrwALUglZLqgpHKe5jzKugvvFYWNs
	Z0XXIhbgLuN/f1qh8QWrcHw8zDv3xvV/3
X-Google-Smtp-Source: AGHT+IEDW7eYSHShZ9uUTu6tE97/RvHeZoRRtTcD/F/aceNlA6AG8Vkk1+XCW1c2mHJSic68V/j85TlAVV0Bg3nbA24=
X-Received: by 2002:a17:90a:2c48:b0:2c9:58dd:e01d with SMTP id
 98e67ed59e1d1-2cff941b877mr8893757a91.14.1722791345100; Sun, 04 Aug 2024
 10:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 4 Aug 2024 12:08:53 -0500
Message-ID: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
Subject: [Request] iwd to support brcmfmac 'SAE with AUTHENTICATE'
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I know brcmfmac is a pain to deal with on many fronts. The current
firmware installed by RPiOS in bookworm as of:

Linux 6.6.31+rpt-rpi-v8 RPiOS-bookworm aarch64 (64bit)

is:
[   65.894288] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
01-996384e2
iwlist shows:
        Supported extended features:
                * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
                * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK
in station mode
                * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with
802.1X in station mode
                * [ DFS_OFFLOAD ]: DFS offload
                * [ SAE_OFFLOAD ]: SAE offload support
                * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
                * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support

This driver does not seem to work with iwd nor wpa_supplicant to
connect to an SAE3-Personal network. To get it to work with
wpa_supplicant, I had to follow the instructions in this link:
https://github.com/raspberrypi/linux/pull/5945
It shows that it has been merged into the kernel. The new firmware
forces SAE authentication to the AUTHENTICATE command, apparently.

[   65.764656] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
01-b677b91b
iwlist shows:
...
 Device supports SAE with AUTHENTICATE command
...
        Supported extended features:
                * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
                * [ DFS_OFFLOAD ]: DFS offload

With this driver and the latest wpa_supplicant (built from git), I can
connect to an SAE3/Personal AP.

I am not a dev but can build and test stuff on my setup. As I
understand it, since the new brcmfmac firmware requires the SAE
authentication to be done outside of the kernel and that iwd does not
yet support this functionality.
Is there anything I can do to support the addition of this
functionality to iwd? We develop on the RPi and we are stuck with the
brcmfmac cards and use connman/iwd for our connectivity.

Keith
