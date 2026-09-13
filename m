Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D5324B31
	for <iwd@lists.linux.dev>; Sun, 13 Sep 2026 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320356; cv=none; b=grnz190FvKaq8qetTIRuiYvaFV1vGQdVi20Kq24I3Xbd5xyeur6YUnrLDQPtA1fSO3vdg0gb5STaCyhwam9QYpMT/yPcuby6sDVSiAfBpz0X34U5SyvSk0hyVnaosuS5HHjxlken5RH8Rtx7WxpdwHqj91lY+464uxSa3wZVUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320356; c=relaxed/simple;
	bh=WDWiTc6OL+WeY+uReOahU90KQqVdb4ZHkavwuzrj5kA=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=YOZVeEq5OEy9sPr+uoQj8l+OR7U3jRArnL+OrfphBZpsOtE7U+9Gp9DPTWEwtu+bVlcy5EHXW5aci3VLuxWCwbCqnasubYbEBBV2U3ZPAwJa0HEYT8MjW7bbA2PBNIK5CfF9pvoaHRg+knxSncFSGW+Zsu+kvz3lzT+Q4h/NKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr0ye6JP; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr0ye6JP"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76bcb09so17552201cf.2
        for <iwd@lists.linux.dev>; Sun, 13 Sep 2026 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789320353; x=1789925153; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type:date
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DN8lkbdQ3jMRWl710Vg/lokjmZZXAhYXR854SkEMTVw=;
        b=Zr0ye6JPCpmFDTVoCKksARcKf0AM2Ts6ifR8O22nAdUW/3BvuWFY0ulPS6I9MB5Yjn
         rS7N62t4jsNW+7EkwIxELGsVeJLZZ6EKHvxO6dr9F303Neq1V3S4THm/Mp2RvmBRx08L
         HT3+xycvABht3jcIH/aE2yYwarVKfJ5QxKs26MRpXQifWWPiDzxYNi83f9vg1qDID71a
         ZeDSMFCymV7mh8q9Jm1Hcu6p2jjt3ggWUybJCug/LXsIy7MWGmk4X97IWHQoiF+f01Sp
         VkuihDGCAWVO7qtVC4SGrkBdq/9gFlAFC8HHZKuzZFx1gLP+cnq1B8YaApI1stwY5ll2
         NUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789320353; x=1789925153;
        h=mime-version:user-agent:content-transfer-encoding:content-type:date
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DN8lkbdQ3jMRWl710Vg/lokjmZZXAhYXR854SkEMTVw=;
        b=mNrLoSott9U0OJBKw3P7GGPJt39yO8jAZoJuLBxuHVVEGDiD70u4aKDvUslOXVPQml
         hy4+6H7iYGZyrY2dQT9nLY8zhbY1zXDxx70XdGd1j4VRk1/w/QHWJ126J6H+FiaVjGOC
         AGzE0vD+W13eAuvxxGqXEO3DqeoWCjkbBPy2IAO2i/X0gdmc4vVa/jIXCwLMPBwzzs+D
         T88YKSP6LUqBQuC0nQOlBUUCUozPRN8YX2eWYqfcAw31M3ls6BjmieZipgNqr1uTvH2p
         0su+UrzwrA5LIsVf5+M3dHnyHmo8825lZAY9TrGiDFxja2ywVP9qO5Yv9uswIoDwM9Gs
         RI7g==
X-Gm-Message-State: AFuF++n21dJdV+bB8+rgpXqqyCcfYa3xrv9zlnsJ/8j0E6LBetwjAG/t
	LEkARvIiSj54aefoNKhdkuuWCZ5H3QXu8kTPbtkSxItsVt8798EZ0A46sBa/ApACY+c=
X-Gm-Gg: AYBFou2gcad8TKkzn+by7C7yN6N+uo8/KYHR2YkduX6mDHL4pDFVGvc0QkaTadXyGea
	06IaUq7Kk90xcBpUx1P1T+SETZtFLUR9uUj7JUZtBS95LtDnAu6vE2TN9/0hWP7h84LvTkpAMhs
	QhUdFhnZGb6hLEZjdFZW6yFaNs/QoyiUAOWtkfG3U5nXUcv0NsKuV6Q6DhZeeKKByQGw/OoGhqj
	LeC2y0puIL39C9TEoEjCt7f4p5eKe+g3HwtMksREulBYjL5FGYn2keosLOrl1yGber3Jgy7uhBD
	bGMJ1O4XGOxH65JqMqF1qzwkpZk6gBapSl0TnTDvAgnTfUHgHUM0xio43QtNfXITdR3pm72OZ5k
	3dAWuP7n10X0BmhCYbD0b3tLfW8TSOBiBfEpz9GvPgTU0h1oQq80w15NPy2+4w5Tl1blgW/7FIU
	FyxVMWdrgpn2csQqnLs5jc4FZn4Uo2tBUlVr+ZYnV0jD+rqSPhCZe9cXAPYHZ8ONRpxcphfH2OT
	N6Ns9PrqlfDXLGpiAtr/4hCATDjzzf0FTRWzvzPIuWSealIgQRd8Zw+OA==
X-Received: by 2002:ac8:7d45:0:b0:530:42e4:f001 with SMTP id d75a77b69052e-530e81f2edamr113882431cf.46.1789320353256;
        Sun, 13 Sep 2026 10:25:53 -0700 (PDT)
Received: from ?IPv6:2804:14c:485:858b:a3c2:3795:1e66:d796? ([2804:14c:485:858b:a3c2:3795:1e66:d796])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f202856sm74725636d6.2.2026.09.13.10.25.52
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 10:25:52 -0700 (PDT)
Message-ID: <e3195f352dc8c7c556913245a6248d25ad9d572b.camel@gmail.com>
Subject: [BUG] P2P persistent-group negotiation breaks WFD connection
From: "t.haeitmann@gmail.com" <t.haeitmann@gmail.com>
To: iwd@lists.linux.dev
Date: Sun, 13 Sep 2026 14:25:50 -0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello,

I am debugging Wi-Fi Direct / Miracast interoperability with iwd 3.12
on NixOS, using NetworkManager 1.58 with iwd as its Wi-Fi backend.

The peer is an Amazon Fire TV acting as a Wi-Fi Display sink.

Environment:

- iwd 3.12
- NetworkManager 1.58
- NixOS
- COSMIC / Wayland
- Wi-Fi Direct through NetworkManager
- P2P device exposed by NetworkManager through iwd

The connection reaches P2P discovery and GO negotiation, but with
unmodified iwd 3.12 it fails at this point:

    Persistent groups not supported
    GO Negotiation Response sent with status 2

NetworkManager then receives:

    IWD SimpleConfiguration.PushButton/StartPin() failed:
    GDBus.Error:net.connman.iwd.NotSupported:
    Operation not supported

I traced this to the P2P GO selection logic.

iwd currently uses:

    #define P2P_GO_INTENT 2

and the code rejects a peer requesting PERSISTENT_GROUP when iwd does
not become the Group Owner.

As a diagnostic experiment, I rebuilt iwd 3.12 locally with only:

    -#define P2P_GO_INTENT 2
    +#define P2P_GO_INTENT 15

This changes the behavior substantially.

With GO intent 15, GO negotiation succeeds:

    GO Negotiation Response sent with status 0
    creating wlan0-p2p-go0
    Created interface wlan0-p2p-go0

The Fire TV then reaches the local GO successfully:

    AP Probe Request from 82:6d:71:3e:40:13
    AP Probe Response delivered OK
    AP Authentication from 8a:6d:71:3e:40:13
    AP Authentication frame 2 ACKed by STA

So the GO-intent experiment appears to bypass the persistent-group
failure and allows group formation to proceed considerably further.

However, this exposes a second interoperability problem in the WSC
association path.

The sink sends the Probe Request using:

    82:6d:71:3e:40:13

but later associates using:

    8a:6d:71:3e:40:13

iwd then repeatedly rejects the association with:

    AP Association Request from 8a:6d:71:3e:40:13
    8a:6d:71:3e:40:13 tried to register as enrollee but we don't
    have their Probe Request record
    AP (Re)Association Response with an error status delivered OK

Eventually the P2P group is torn down:

    p2p_dhcp_timeout()
    Freeing netdev wlan0-p2p-go0

followed by:

    SimpleConfiguration.PushButton/StartPin() failed:
    GDBus.Error:net.connman.iwd.Failed: Operation failed

I currently have two local experiments:

1. P2P GO intent 2 -> 15

   This is tested and moves the connection from the persistent-group
   rejection to successful GO creation and 802.11 authentication.

2. A P2P-GO/WSC compatibility experiment

   I am investigating whether the WSC PBC Probe Request bookkeeping
   assumes the same address will be used for the later association,
   while this sink appears to use a P2P Device Address and a distinct
   Group Interface Address.

I am not suggesting that globally changing P2P_GO_INTENT to 15 is
necessarily the correct upstream solution. I am reporting it because
it provides a reproducible way to demonstrate that the initial
failure depends on which side becomes Group Owner.

Questions:

- Is rejecting PERSISTENT_GROUP whenever iwd becomes the client the
  intended behavior for this case?
- Would dynamically preferring GO when the peer requests a persistent
  group be appropriate, rather than changing the global GO intent?
- Is the WSC PBC association path expected to handle a peer whose P2P
  Device Address differs from its Group Interface Address?
- Would you like a full debug log, nl80211 capture, or a proposed patch
  for either behavior?

I can reproduce this reliably and can test patches on the affected
hardware.

Thanks,
Thiago
