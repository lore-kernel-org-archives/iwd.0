Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C02FE579
	for <iwd@lists.linux.dev>; Wed, 11 Feb 2026 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851723; cv=pass; b=OYBIu1s6J1cu/oGE//BQilILIEidW59qc9KGfmJK4jky21g1yH76ehiborG9FkOqvyZpjfLX/GSgJnA7NKxLTrwhvyNl6iJ3PKJJ4/re9M9GVzSDLYzXp/MKk3xP3pG3RARbJFNmbEsBgYFwuZtfDKj446TUOJy15r+q5bpPTMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851723; c=relaxed/simple;
	bh=ELlhMpZknynUf2H8SdfNirWv9PjcAjZN2JHsZgSqWiE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tY+Czc1ZRjieBYLzdLrM16zNdIJLMXqVlRsgB0nheqHIfZktRSqV3kXxaV2UEgo2B8TeOFC/CPXTZKa66T8V8LL/O4YRMFbj9qJ7peDf8Gr5JVXjYD1aNHxJMhG2uTWIi3D3X9xJaD1n/7EglFTm3Km5DOUHTE8aRCW3dwbgJvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiVjuNqG; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiVjuNqG"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65a40f3f048so2054837a12.3
        for <iwd@lists.linux.dev>; Wed, 11 Feb 2026 15:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770851720; cv=none;
        d=google.com; s=arc-20240605;
        b=FOBvAUaKf6X/6vCjnKUfMaSRz65BGUPthzPUxZp/+Dqryaqm8mV6ko9DN7ANC2ung/
         ZAj4bJiU0BVGokHPnJpHFJGq7eZ62Uwx4SLy10tMjFZ0vl603+y6yCNCkgtmzC5kcGCn
         B78zhklVioW3JuZcLpo+/TAaqTAvQjzW/FxsBxX0TzTRu88SpX+OPvoDqhN70cIfiYsM
         ETJnxLokKVZnxZfFvy+pBov2wH7HKOx1glpENjOTfO4Mki1BZxRbz/NJrLdRz4Uj0a2j
         GlTk926lekLja4K5K68FS9M+g93Yf4PSjudi8Ums9+k5x37n/cYbpl8ZWehCSJj8kE+x
         l6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ELlhMpZknynUf2H8SdfNirWv9PjcAjZN2JHsZgSqWiE=;
        fh=LVwSdJJT2poHpWJpvI73c3fFqaJVA08Td3ZAiex6+kI=;
        b=TNoB1471BDLyo9701GhjVQ2lsLmkweFg0lyxCy9rWzOO9PlwQYeb/Ce2C/4IPW5SsB
         b6GeU7IB+h391OmxrYExHkrq06nFQxE6Z1U7a1e7A1djIfRKp3C5yx+UiVrIc1dQ66Pi
         9dikiznb0fu4uqW7BLFoGVy5mrsuelPXNRiJ7AA5JgCaX2SWIp4LdhMJg3JnIcENmb4o
         OCQ2ty8QtVvAbJXGcujLhtg3dRIErkX6p7UNBZsCnqBFIfv9jyOrwt+XGYClhTPOJbu9
         0jl2m2zNa0Ci332tUAUye2IPdOug1Qdex2nLIvD0/Q045Hzt9CFFaKVLDhKSicV6xEFs
         AIEQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770851720; x=1771456520; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ELlhMpZknynUf2H8SdfNirWv9PjcAjZN2JHsZgSqWiE=;
        b=ZiVjuNqG3ZbAZ+9VnLUVGXif0441YoNKOm/vOOKrQU2DVb/tewopMIo/1paupEtYqs
         KBV835xMnMvOo/NL8b4yUAdsEY0MvIWOH2wqgwgqz1xeaBdU4dCMhfIMk9yaDudfdVwG
         O9wCHHZHHwiVOS1Pn1tNldCNJBf+4fF4+u89qzVUVHG+GFIpPcOmecbtsdOZjdEQOy+e
         SOM2vSugJCkE0MLGRdfS8/tjCiwSU9oTSNmfBO6etMUT8RvHfFZMt+7YUOxQoXoU8yln
         nPymytvRTw9s9iKBGryso+JBwtoMiXQNIWaRiFWFkgEe0My8jbNLAe1DC/0IK6jTeBNa
         2Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770851720; x=1771456520;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELlhMpZknynUf2H8SdfNirWv9PjcAjZN2JHsZgSqWiE=;
        b=v7HivxN2WdmvJ8s1F4Ly/wvDuKAvF675V1+etyDgcguYsNyLuzege4LFLXZTx2tW7j
         O9JHqN93oKx+uzUe8LA3UyvyVxIbhqXdHIUi4M/b2ibVN0lkthpz85lM80DxTr4Mx97q
         jkW+YUbyIDR8rGg1R9TN8ng3a+WI4D2d5bDFojDxKiIoUNiXVG/NokKPofRRdHwYXuA6
         7r+joD1YW2JIE/6GjeUMmb3q+8xLeNMz0U6tdeGNC/CQpwBpLmuSCdMSDwL9ttteANQr
         Kj68IwSelL6eR+cT02419hLusb7Ppv7HEGq1LihbxXRRhriAyUKncT+tcVhS8nj+HJEx
         B3hA==
X-Gm-Message-State: AOJu0YxaJPgGvoI1l7AqBlB5dZkLL6cpjyFQUK11tbIXWl4lHYmlau7X
	bI3hQLUlpXYRSlJz99c5zY8+dJ5GyxOlZgWntuxghyU14JRamAbWvlBdu0Tgiz77/HoJ4yt+CQR
	Z8Qcb4aIG5bcjYOQuuYCIxlKz3wLdQPujyitd
X-Gm-Gg: AZuq6aKNCTfIr0zeU1qQAL2JE366H9wfwceo/lGe2UbcGq6oPI9zTqG9V7xXloMMeJP
	mteGkjftu3ngIqMYkdCr+iBCLw8YOl424FCkBvqtbM9AD0Law5uzkpAMJ9EgBg9NETJ/H2mhEqz
	sR7jWSQwprUN3ovvs4nbGUdzxTc5g7DiW8lyvEWFGN8Nsg22qXubYTgB7GSoMxI9Aeisnt/QvmQ
	vOIO22wHVAdC4VbgoNCdjhMbrXFppeVruj73Gz9ihWFkq+pJVG/WnmjZVnQYCS6vwPz/arbdLiY
	9r9Rd94Nz/3/FyEsvttu
X-Received: by 2002:a05:6402:2354:b0:658:b55d:2822 with SMTP id
 4fb4d7f45d1cf-65b96dd78d2mr512988a12.16.1770851720268; Wed, 11 Feb 2026
 15:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 11 Feb 2026 15:15:07 -0800
X-Gm-Features: AZwV_QgCR_ZLnxzuV-VhTy-qPMbm31NmL7V59LVnXLFm2vlJwvDzahWoKpBqxwc
Message-ID: <CAKxU2N9ED1tuKM6ygCb1Ln9VrrMEHGOoc_NhNTn3md87-wH8Mw@mail.gmail.com>
Subject: does not connect with intel 3168 past kernel 6.16
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Output from 6.17 dmesg:

iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=0x220, rfid=0xd55555d5
iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
3168-29.ucode op_mode iwlmvm
iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor version: 0x0

There's also iwd dmesg spam:

invalid HE capabilities for xx:xx:xx:xx:xx:x1
invalid HE capabilities for xx:xx:xx:xx:xx:x0
event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x1, signal: -76, load: 52/255
event: state, old: autoconnect_quick, new: connecting (auto)
event: authentication-timeout,
event: connect-failed, status: 1
event: connect-info, ssid: X, bss: xx:xx:xx:xx:xx:x0, signal: -78, load: 96/255
event: authentication-timeout,
event: connect-failed, status: 1
event: state, old: connecting (auto), new: disconnected
event: state, old: disconnected, new: autoconnect_full
invalid HE capabilities for xx:xx:xx:xx:xx:x1

6.16 output:

iwlwifi 0000:08:00.0: enabling device (0000 -> 0002)
iwlwifi 0000:08:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
iwlwifi 0000:08:00.0: PCI dev 24fb/2110, rev=0x220, rfid=0xd55555d5
iwlwifi 0000:08:00.0: Detected Intel(R) Dual Band Wireless-AC 3168
iwlwifi 0000:08:00.0: loaded firmware version 29.0bd893f3.0
3168-29.ucode op_mode iwlmvm
iwlwifi 0000:08:00.0: base HW address: xx:xx:xx:xx:xx:xx, OTP minor version: 0x0
iwlwifi 0000:08:00.0: Registered PHC clock: iwlwifi-PTP, with index: 1

Note the extra PHC clock message.

This is still an issue with kernel 6.18. I work around this by using a
USB WiFi adapter, which is not ideal.
