Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990DD1B296
	for <iwd@lists.linux.dev>; Wed, 29 Nov 2023 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQyLKcYl"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5d226f51f71so14244467b3.3
        for <iwd@lists.linux.dev>; Wed, 29 Nov 2023 09:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701280049; x=1701884849; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBHZA7e4IsrbcSkwoWuepyhIbEHniNsDi8EXSjdsZEY=;
        b=JQyLKcYlXuPREtOrImTDw5WOLoFRtJeEAQPulWvvx/vLRltbgYBLfewBQ7wvG2PdPU
         34+gD+oLdN86HVLajKsWuVosNJ0fcNiuya19n4bzUEjTfemLkQoydmHkvxQg0lCoJ7ao
         kNrkDdOJdrhUUvdjDBHPhr82JyhppHbyMGtmb9OiIuTQhiWIqxQ1OtDV4ky5FSMoiYLS
         5NBtDNNXG9mZjYwj3/WU9EBeLm9WvMJA0prXj6eFuHhyranIcZ/A93XX91yAMKLS9ffc
         NmwhDZj94A+j+KRzLNcXIFMy7KxjWwXPTX+uup7nB268v0/8FhfT2g2n0i5qD43ZlBTv
         waEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701280049; x=1701884849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBHZA7e4IsrbcSkwoWuepyhIbEHniNsDi8EXSjdsZEY=;
        b=gN6iAcSzgQfFgrvsudiuM9WK1fpolosoTTCL//ARFS56+ci2wAgAOMU4Q9gLgebT+K
         xorrwUFwF8rbSyARi8iid8UL/t/Ux7zhM7ns5D1ZmUaweDcCHRWTm4buIkSgMTDZiZ/b
         KDYdgPm8Go57x3yCXrLDABJSHCjZWyVEsT2+I3Ds2XtcVb9Y4ARPnMRGBECy7UhlelXW
         BQErXuezFEJ7ue6WqQGehUELZwMlSEyaoIDUZ1xTZAO0uqvSc8wN1JLUiNsLekPiDjDD
         AijAw4VtOq6Bs+hf2+yih76P6qbaoRTL4EeuRqLlkyzzrdftTLHXDfbjjxYNJpU6O00V
         eeVg==
X-Gm-Message-State: AOJu0YxPbHUARsSSZjkQRMJF0hdtTLytiOaNwfwsK+t7jmPEGeESH8qB
	QgksDL/miF9p/gBWde8y2ljNm877FqkFGdY8D7opKeYGH6Q=
X-Google-Smtp-Source: AGHT+IHG0DpijzHt2NcJ1X1Hlvi89AidQzpC3bL0u49qEtH5ZP60qkjip3R20Wkl/wIAJMWsBgNT51QQFovCCS6xj+E=
X-Received: by 2002:a81:a14f:0:b0:5ca:8b7c:b1d4 with SMTP id
 y76-20020a81a14f000000b005ca8b7cb1d4mr20111724ywg.16.1701280049208; Wed, 29
 Nov 2023 09:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJODeCBYQ3bwRjZjZoZ+AX+QG84U=VO_UEoa0AuWmFAqxunn4Q@mail.gmail.com>
 <0331a3f5-7d04-49d0-b569-3e5fa5b4514d@gmail.com> <CAJODeCDu-85P54m16FanJftz2mC-fVGN-PXrwk4q+yS8n6mwFQ@mail.gmail.com>
 <8212f44e-d7f1-4b5c-9ffb-043a01b4d16b@gmail.com> <437c600a-3dad-4a78-883c-c2cc2939ba00@gmail.com>
In-Reply-To: <437c600a-3dad-4a78-883c-c2cc2939ba00@gmail.com>
From: Daniel Barter <danielbarter@gmail.com>
Date: Wed, 29 Nov 2023 09:47:17 -0800
Message-ID: <CAJODeCCVvGx6FkJKeczSukVcsKs_ohmRA_tY39nyJZaUbKS2vQ@mail.gmail.com>
Subject: Re: roaming issues on a residential LAN with multiple APs
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks James, that does seem like it is related.

I have done a few more tests on the machine (booting from various
nixos iso images):

6.1, iwd: no roaming
6.1, wpa_supplicant: no roaming
6.2, wpa_supplicant: no roaming
6.2, iwd: no roaming
6.6, iwd: no roaming

i have a Debian-12, 6.1 machine with the same network card running
wpa_supplicant that is able to roam, which suggests it may be some
issue with how the kernel is configured.

here is some dmesg output if in case it is useful:

$ dmesg | grep wifi
[    3.113334] iwlwifi 0000:aa:00.0: enabling device (0000 -> 0002)
[    3.130735] iwlwifi 0000:aa:00.0: Detected crf-id 0x400410, cnv-id
0x400410 wfpm id 0x80000000
[    3.130992] iwlwifi 0000:aa:00.0: PCI dev 2725/0024, rev=3D0x420, rfid=
=3D0x10d000
[    3.180360] iwlwifi 0000:aa:00.0: api flags index 2 larger than
supported by driver
[    3.180388] iwlwifi 0000:aa:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0=
.2.41
[    3.180877] iwlwifi 0000:aa:00.0: loaded firmware version
83.e8f84e98.0 ty-a0-gf-a0-83.ucode op_mode iwlmvm
[    3.586622] iwlwifi 0000:aa:00.0: Detected Intel(R) Wi-Fi 6 AX210
160MHz, REV=3D0x420
[    3.594294] iwlwifi 0000:aa:00.0: WRT: Invalid buffer destination
[    3.753298] iwlwifi 0000:aa:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    3.753319] iwlwifi 0000:aa:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    3.753332] iwlwifi 0000:aa:00.0: WFPM_AUTH_KEY_0: 0x90
[    3.753343] iwlwifi 0000:aa:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    3.754727] iwlwifi 0000:aa:00.0: loaded PNVM version 181407b3
[    3.770223] iwlwifi 0000:aa:00.0: Detected RF GF, rfid=3D0x10d000
[    3.840925] iwlwifi 0000:aa:00.0: base HW address: f4:7b:09:9c:04:3c
[    3.882078] iwlwifi 0000:aa:00.0: WRT: Invalid buffer destination
[    4.041703] iwlwifi 0000:aa:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    4.041789] iwlwifi 0000:aa:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    4.041834] iwlwifi 0000:aa:00.0: WFPM_AUTH_KEY_0: 0x90
[    4.041847] iwlwifi 0000:aa:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    4.148311] iwlwifi 0000:aa:00.0: Registered PHC clock:
iwlwifi-PTP, with index: 0
[    5.616569] iwlwifi 0000:aa:00.0: WRT: Invalid buffer destination
[    5.786287] iwlwifi 0000:aa:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    5.786351] iwlwifi 0000:aa:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    5.786364] iwlwifi 0000:aa:00.0: WFPM_AUTH_KEY_0: 0x90
[    5.786382] iwlwifi 0000:aa:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0






On Wed, Nov 29, 2023 at 4:49=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Daniel,
>
> On 11/26/23 21:00, Denis Kenzior wrote:
> > Hi Daniel,
> >
> > On 11/25/23 18:32, Daniel Barter wrote:
> >> here are my logs:
> >> https://gist.github.com/danielbarter/65ddf6aee78546a0e8f9e2d3af65308c
> >>
> >> notice that this is a mix of iwd 2.4 (my distro default) and iwd 2.8.
> >>
> >> Default roaming thresholds are in the 70s right? I am getting down to
> >> -90dBm without a roam happening.
> >
> > Default thresholds are -70 db for 2.4 Ghz and -76 for 5Ghz.
> >
> > I'm not seeing any CQM events in your log, except for this one:
> >
> > Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify()
> > MLME notification Notify CQM(64)
> > Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_cqm_event()
> > Beacon lost event
> > Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify()
> > MLME notification Notify CQM(64)
> > Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_cqm_event()
> > Beacon lost event
> > Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_link_notify()
> > event 16 on ifindex 3
> > Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify()
> > MLME notification Del Station(20)
> > Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify()
> > MLME notification Deauthenticate(39)
> > Nov 24 16:34:15 jasper iwd[768]:
> > src/netdev.c:netdev_deauthenticate_event()
> > Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify()
> > MLME notification Disconnect(48)
> > Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_disconnect_event()
> > Nov 24 16:34:15 jasper iwd[768]: Received Deauthentication event,
> > reason: 4, from_ap: false
> > Nov 24 16:34:15 jasper iwd[768]:
> > src/station.c:station_disconnect_event() 3
> > Nov 24 16:34:15 jasper iwd[768]: src/station.c:station_disassociated() =
3
> > Nov 24 16:34:15 jasper iwd[768]:
> > src/station.c:station_reset_connection_state() 3
> > Nov 24 16:34:15 jasper iwd[768]:
> > src/station.c:station_roam_state_clear() 3
> > Nov 24 16:34:15 jasper iwd[768]: src/station.c:station_enter_state()
> > Old State: connected, new state: disconnected
> >
> > Basically a lost-beacon event comes in (twice for some reason) and
> > we're disconnected almost instantly after that.  There's no other CQM
> > events that would indicate low signal strength where iwd can actually
> > take some action.  Try setting a more aggressive roam threshold and
> > see if that helps?  man 5 iwd.config, RoamThreshold and RoamThreshold5G=
.
> >
> >>
> >> kernel version is 6.6.0.
> >>
> >
> > It could also be the kernel folks made some change that broke this.
> > For example, this looks to be touching the general area:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.=
git/commit/?id=3D37c20b2effe987b806c8de6d12978e4ffeff026f
> >
> >
> > Try reverting or using a version prior to that commit?
>
> It does appear _something_ is wrong with QCM notifications in the
> kernel. There was an RFC fix with one user commenting that roaming in
> wpa_supplicant is broken as of 6.1. I am able to roam fine on ath11k
> with a stock 6.2 Ubuntu kernel so not sure if its only some drivers or wh=
at.
>
> https://lore.kernel.org/linux-wireless/20231106231715.3a506ac2dadb.Ie774b=
85b9d4ff934a1236e77096cb9c6c9fe6561@changeid/
>
> Thanks,
>
> James
>
