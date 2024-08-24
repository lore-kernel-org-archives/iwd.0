Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF229422
	for <iwd@lists.linux.dev>; Sat, 24 Aug 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724516433; cv=none; b=l7iY0Olg/Tacrnjb4CnoauDz3oee/hg6uYqU72SbmTyhpEWNkNzjCcRWBhr1dqsp4gL98HfEGuAFKODykSwfA64NvxW0/6ashQby3uUibJy/ix9MXhlSQrwf+kvI7tGR2c/qtplCB9s8dAFjMOxRpdUgGBZ2V9mMakT6D8qX62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724516433; c=relaxed/simple;
	bh=iM5FgCDq3/RkyLH1wRrRYPd2icKqd9RbXqoDN4TjIR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNIwYz8tT/HcfBQ1gYo5cc2KhCvFnjsICpUcu9tbzxFl+KPaA2i+BLRIC5YJQFwzW0KJVA0cS7ZER4A1GoPvf333AvuiTqI5pqkVXBHnK0k4nt3bPLiqCGLMZ7Ij/LKiLuy4IN9LcZUqyguhdvVdr7QoMBhFstHQ2w1WzpPCU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD4Pt1RM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD4Pt1RM"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3da6d3f22so2269055a91.0
        for <iwd@lists.linux.dev>; Sat, 24 Aug 2024 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724516431; x=1725121231; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vM2UcZuNS0EKXEbYevUQlg10Umo5B/5FSYQiI8cK/4=;
        b=ZD4Pt1RM/qS8GBgwA8aw88EQnRxr3Jpdlz9voBQ0dVTFJXme4ubjpkZRwLWpqajIfn
         n4c2CKhGuFZHDxgnrdxtAZOHG1y3596/8vfl2X6W43YNBKeF+ZwhHiteQqk3ofDIyvHM
         Xb7J4yFIltOlIi+xmqOueIht+VrQ8yQZa/HCtWm1A7AGqe/VL0ROxMY0KpXS272Gdlq8
         w6MLYgNJsTDFX15780z20dWDeTZVkk3HZOBTvr5iiSvuAgab0OFeIHkp7oZMM9wOZ0BP
         YWzF8hmzBA1qksDDsT/tZy5JjflEl0caP5miHBOG8whQKXMdVxPNholhwX99uzZQU/kh
         2SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724516431; x=1725121231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vM2UcZuNS0EKXEbYevUQlg10Umo5B/5FSYQiI8cK/4=;
        b=iYyL4d4ay0lt2pqnQtZANY4LPQ4pNqNwCTlJpHCWZVJGJjjL3zYn8WJITYNAxQvXGB
         ajgPgB2X/JVcbcW5Oe4fH2dXlU1ilzU0WKP4SZejAFAvRgIRFAZfOoGcW3ICwf16XjN6
         n1L1kVpBt6DuFhQxfOQm5RoG6JSR/ilqcvB8haUvPWy7JiYI86hjQEznoqcxHnBd1UCr
         AUrkAWCB7RdbdhD97M0IzdAgnVyAQi7xgOHRbZLFNb6gti3tiBV2EoqAOxYNmcQPCSsn
         tKG9dG9rQIbVsNz2ZvQBpCQpJevnzPajL6DQ73oQCzpYAVHWRni81QVJIQXatghsmOec
         oHwA==
X-Gm-Message-State: AOJu0YxndnJmhQYKR0A+8t20DN3wJ1mRGcXrBU1b9cd6LKBmO1wACcJI
	xOcH156Xz7duuAxd7lyfnzskgG3mQGougWbbZPY8HPTlbjH/0yEXwoIvT+UZzBOPEdKh2TGYD/0
	F3BR6/RDXQrX6MqJ1D0LU550c5Xh0rAQG
X-Google-Smtp-Source: AGHT+IH3zVnn+xO7+qAkeLBURPDDg4kw6ckylsk7I4cNoNk6UpGdI/ZPxqjtcPqrjVFeO3/5Y6oJxpzyUdBsD8GSo7o=
X-Received: by 2002:a17:90a:c696:b0:2d3:9137:2375 with SMTP id
 98e67ed59e1d1-2d646bcd374mr5871357a91.4.1724516430925; Sat, 24 Aug 2024
 09:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823174220.498594-1-denkenz@gmail.com> <CAG17S_NjMwU4=qn_jJzUJwPEOTT1H-SPVb7Re0P4fyPNUg=WqA@mail.gmail.com>
 <f36d03e4-e85a-438e-adef-b6c2da0c8f72@gmail.com>
In-Reply-To: <f36d03e4-e85a-438e-adef-b6c2da0c8f72@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 24 Aug 2024 11:20:19 -0500
Message-ID: <CAG17S_P615tCPt0Jy+-BLzFx0N9JiksVXdUj4-iRAA9JTWdotg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:21=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> =
wrote:
>
> Hi Keith,
>
> On 8/23/24 7:38 PM, KeithG wrote:
> > Denis,
> >
> >
> > On Fri, Aug 23, 2024 at 12:42=E2=80=AFPM Denis Kenzior <denkenz@gmail.c=
om> wrote:
> >>
> >> This series implements External Auth support on Full MAC cards that do
> >> not support SAE offload.  I have not been able to test this fully sinc=
e
> >> the brcmfmac firmware on the RPi 5 does not actually work properly.
> >> Maybe some enterprising person can test it on a firmware that does wor=
k?
> >>
> >> Denis Kenzior (2):
> >>    netdev: external auth support
> >>    sae: Allow ability to force Group 19 / Hunt and Peck
> >>
> >>   src/netdev.c      | 258 +++++++++++++++++++++++++++++++++++++++++---=
--
> >>   src/nl80211util.c |   4 +-
> >>   src/sae.c         |  20 ++++
> >>   src/sae.h         |   3 +
> >>   src/wiphy.c       |  19 ++--
> >>   5 files changed, 263 insertions(+), 41 deletions(-)
> >>
> >> --
> >> 2.45.2
> >>
> >>
> > I was watching for this. I built iwd from git and tried it on my Pi5.
> > As you said, it did not work:
> >
> > Aug 23 19:24:29 pi5 iwd[16297]: SAE unsupported: brcmfmac needs
> > CMD_EXTERNAL_AUTH for SAE
>
> I don't think you applied the patch correctly.  You should see:
>
> +               /* Case 3 */
> +               iwd_notice(IWD_NOTICE_CONNECT_INFO,
> +                       "FullMAC driver: %s using SAE.  Expect EXTERNAL_A=
UTH",
>                          wiphy->driver_str);
>
> > Aug 23 19:24:29 pi5 iwd[16297]: src/wiphy.c:wiphy_select_akm() Can't
> > use SAE, trying WPA2
> > Aug 23 19:24:32 pi5 iwd[16297]: src/agent.c:agent_disconnect() agent
> > :1.471 disconnected
> > Aug 23 19:24:32 pi5 iwd[16297]: src/agent.c:agent_free() agent free
> > 0x5555946ddaf0
> >
> > I believe this is the latest firmware from Infineon for the RPi fmac ca=
rds:
> > Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265
> > (28bca26 CY) FWID 01-b677b91b
> > Firmware: BCM43430/1 wl0: Jun 14 2023 07:27:45 version 7.45.96.s1
> > (gf031a129) FWID 01-70bd2af7 es7
> >
> > I know there are a number of fmac cards. Does the firmware on these
> > work differently to other brcmfmac cards? Do all of them use
> > CMD_EXTERNAL_AUTH?
>
> No idea.  All other brcmfmac cards used SAE offload.  Cypress firmware se=
ems to
> have gone with EXTERNAL_AUTH.  Not sure about other full mac cards.  I ca=
n see
> references to EXTERNAL_AUTH in two upstream drivers:
>
> [denkenz@archdev linux]$ grep -R "cfg80211_external_auth_request" *
> drivers/net/wireless/microchip/wilc1000/hif.c:
> cfg80211_external_auth_request(vif->ndev, &vif->auth,
> drivers/net/wireless/quantenna/qtnfmac/event.c: ret =3D
> cfg80211_external_auth_request(vif->netdev, &auth, GFP_KERNEL);
>
> But the hardware seems to be unobtanium.  Maybe others can report what ot=
her
> solutions use EXTERNAL_AUTH?  Maybe Pinephone?
>
> Regards,
> -Denis

Denis,

Sorry, I mis-read and assumed it was committed to git and not a patch.
I created the 2 patches and built it again.

iwctl looks like it is trying something:
[iwd]# station wlan0 connect deskSAE
Type the network passphrase for deskSAE psk.
Passphrase: *********
[iwd]#

but it never connects. I do notice that connman thinks it is up and
assigns a 169.254.x.x address

Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver:
brcmfmac using SAE.  Expect EXTERNAL_AUTH
Aug 24 11:18:06 pi5 iwd[28085]:
src/network.c:network_generate_sae_pt() Generating PT for Group 19
Aug 24 11:18:06 pi5 iwd[28085]:
src/network.c:network_generate_sae_pt() Generating PT for Group 20
Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Network
is WPA3-Personal...
Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver:
brcmfmac using SAE.  Expect EXTERNAL_AUTH
Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_cqm_rssi_update()
Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_insert()
Inserting work item 4
Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 4
Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, ssid: deskSAE,
bss: d8:3a:dd:60:a3:0c, signal: -63, load: 0/255
Aug 24 11:18:06 pi5 iwd[28085]: event: state, old: autoconnect_full,
new: connecting
Aug 24 11:18:06 pi5 iwd[28085]: src/scan.c:scan_periodic_stop()
Stopping periodic scan for wdev 1
Aug 24 11:18:06 pi5 iwd[28085]: CMD_SET_CQM failed: Operation not supported
Aug 24 11:18:06 pi5 connmand[635]: Interface wlan0 [ wifi ] state is
configuration
Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
Unicast notification External Auth(127)
Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, External Auth to
SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
Aug 24 11:18:06 pi5 iwd[28085]:
src/netdev.c:netdev_external_auth_sae_tx_authenticate()
Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() MLME
notification Frame TX Status(60)
Aug 24 11:18:06 pi5 iwd[28085]:
src/netdev.c:netdev_external_auth_sae_tx_authenticate()
Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
Unicast notification Frame(59)
Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() MLME
notification Frame TX Status(60)
Aug 24 11:18:06 pi5 iwd[28085]:
src/netdev.c:netdev_external_auth_sae_tx_associate()
Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
Unicast notification Frame(59)
Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_external_auth_cb()
Failed to send External Auth: Invalid exchange(52)
Aug 24 11:18:06 pi5 kernel: ieee80211 phy0:
brcmf_cfg80211_external_auth: auth_status iovar failed: ret=3D-52
Aug 24 11:18:46 pi5 connmand[635]: Interface wlan0 [ wifi ] state is ready
Aug 24 11:18:46 pi5 connmand[635]: wlan0 {add} address
169.254.242.107/16 label wlan0 family 2


Need a log of some sort or is this adequate?

Keith
