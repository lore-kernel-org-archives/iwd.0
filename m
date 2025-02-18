Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0A33E4;
	Tue, 18 Feb 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739840329; cv=none; b=bWmWzN/IF9CnGvi8Qgp7c1UlWdct6kvEoTBKqxLvokI1hn0oYABLXwdLTuy7dsKRKZzDcIcUna/OB55cx3MejMa2/BCRi6hMj+oOTzK7NXJT/tcFzbgkmmvA+FkJq8kEbAV5tBeoLHDAQmFyuGM/KwjQzUg/XP564DthShs2eyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739840329; c=relaxed/simple;
	bh=Rj6iKeTiOSVsV+X/9KTgpdnLldVameGouaVTXnOr7pA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SEFLY+CnPA8TB7gK5B5G7FTlkyex1giUmIm0GFE/3pAxvxl1lqZM1lsKe0Cng1eyGllclKqqJVDRd9nAswElUhUwHbPLZtJc7PCMz1OCANYEL0Vxatcepdv7c6zj0R8g2ucNimVm+imfYcN3UbJEUq7JrcFBkKqFHfAzEfA28Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3VucGoD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3VucGoD"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc4418c0b9so3155511a91.0;
        Mon, 17 Feb 2025 16:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739840328; x=1740445128; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rj6iKeTiOSVsV+X/9KTgpdnLldVameGouaVTXnOr7pA=;
        b=m3VucGoD2nmKrJnIgcB/i/1aRPgR6R7V+zbCXRUCzVCn3T3rZpG/dOwVkdUvFcdJvE
         FuSoDDQN/XhNiPA4Z0Mo4XqYopTdxkEg2ge5TauwTG84bqw5z4FrzvAltK8ZxDEERJ4W
         Ln8I9dcerZT9y5U7W2Fr35VbToI8PDbt4IyLa+7G2HRFFS8pByNtRp2GffNHNB9f03ys
         DnNON8cQY0uFd6iR4k3ubAuuRg0uiXUTh+ZsG0pS9WscP2he2vvHQS833u0D8hr3E3bw
         z9icXn5jwXB0slHEnafzLmYK5pJMdSEkEa6v6EJrJa7w4AGPWRzXSqQ0VUZDZ3rwnPOJ
         3+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739840328; x=1740445128;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rj6iKeTiOSVsV+X/9KTgpdnLldVameGouaVTXnOr7pA=;
        b=nAQ6WUr+DkImlKgMrcJvzww5AyDK6CYX9MtQugJmF79yCEWA6siEmSBDBLfmSTBvlM
         w+3REDrI5wJsgd1xq6AtmDVBwcoxlQ7ZEliskXsPU4sZ53Xt8I8I5LiDNcIRXopV1Zbt
         G+3Wcn5/Vv9KkSms0Ip2s8DahzZvNzeijlEyvfseynSDIOlIJCGaiXaRGM2fDBZQm/dR
         KntZ04Pi234DT+5c6sQ8WRbLO2hahh/oQ7LXYSjSnstZ5Zee/vAF8QswOoEfGAb5sH+G
         ojeiXRN/BcN5r8R5jExcLiVsjm69TMHCsSk1Jn3oBIbBpIdOoS2fCOLRYMh8qVt5RbbR
         ULsA==
X-Forwarded-Encrypted: i=1; AJvYcCWhLdHISTtc4RCCxegrXf/CIsm8ND3Qqu+tZQQtIIIWva0kliUgSxoagIiIhNg6bIgpf6jmOiR0@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9AMf+yiQuGCsB/uOYXKnYwV6Ns8MDlTeTFjIBXrz6VNyuLyZ5
	ynaeZ0DEVUKvWAgDae5ZKhPcno/nR9k2sv8EKmqXGb1qxMcI+0+8lG4TF1BIvav1XKGgBw27rfe
	d3hdH74ZvLZVXM2ggCG+Ms7l76IjcqA==
X-Gm-Gg: ASbGnct8bkCcppM0Uxjbk3z35EmtHGv3k+PfmsJgn+L2h9Kb/27YlxjrSZP2jxRBLEi
	KVWY4CBR2q/mVJopqdEXebZYzbduhB+r1+qunwioCgnKn2LfDCyf6cV/ksyciZ12hFha5n3WE2I
	o=
X-Google-Smtp-Source: AGHT+IEYbyuCCeHx52pWbjgNJzU6n0K62xNYeLn2LMW9dx1PMupal/qqvZKGLzamB0mDlFIpFX1C6Lnzhq+iNfosSlI=
X-Received: by 2002:a17:90b:4c0b:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-2fc40f0f510mr17950861a91.9.1739840327709; Mon, 17 Feb 2025
 16:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 17 Feb 2025 18:58:36 -0600
X-Gm-Features: AWEUYZmVKwhs3Yd9lNvUk1MBiVHg0WHQPE8xV4lgTCgrkngoHiZgUbHUXpiYbC4
Message-ID: <CAG17S_Nkb6jH_aBfAzWiqVqY7PUZ5rQJsHo3WzvfPtBa0E57iA@mail.gmail.com>
Subject: How to elegantly engage/disengage AP mode
To: iwd@lists.linux.dev, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi. I am soliciting ideas on how to elegantly engage/disengage AP mode
when configuration is needed on a headless device.

What we do now: We use connman as our connection manager with iwd
handling wlan duties. At first boot our headless RPi based appliance
checks to see if it has a valid ethernet address on either the wlan or
the ethernet. If not, it creates an AP on a made up MAC address and
launches (with either IWD or Hostapd) an AP to allow a connection to
configure the internet. This works fine and we can use this to
configure the RPi and when we select a valid SSID with connman and
type in the password, it brings the AP down and connects to the SSID.
All good.

The problem: What happens if the SSID goes away either because we
moved the Pi or the SSID goes away? What we would like is it to scan
for a known SSID and reconnect if it finds one, (which it already
does) and if ones does not appear, to restart AP mode so we can
connect to it. If it finds an SSID while we are connecting, continue
to set up, but if the SSID reappears and no-one has connected, to then
shut down AP and re-connect to the SSID.

Question: Are there any elegant ways of doing this? We currently use
scripts and such to look at connmanctl and iwctl, but could start
digging into dbus, to monitor what is going on if needed. We thought
this may have been solved previously and wanted to ask here.

Any ideas? This seems like something that would be useful for just
about any headless internet connected device.
