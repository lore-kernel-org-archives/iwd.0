Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C01367
	for <iwd@lists.linux.dev>; Fri, 20 Dec 2024 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734670722; cv=none; b=Smd1D3TPoOhxiNUWdPUvKvsuno4Y4i+nrxC546bykMAl8LNj3RzZ4aX6UBaCAvaQutiLqCKSnWIg5klwpDdezacy9mkt/jnwAHFXpCsplxTH5w3AQ1MCQY2V+DAE1uynooe3rgt6PdxZ+qfCW0OHqhs5uWYfc+cRF27GdDS7n44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734670722; c=relaxed/simple;
	bh=vnvrAY2Yg4A9Us9HKqr2nIm1ybXwbsBCJLn7YM1UrkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zw/rQR3VfiBOzMlmEr0tv0rpjy62TEoUvB/e9n07Sj5qQO0FipQEmcJBKMfvz9yFX2WXqHEx0eztABSuROqb9uERfGKJv8wln2jT6WFdEXn5qixu3aE2M104ibJT+F74J75if3Lsp5aF4YkTooyXqEUerABKzVdcYZ84pS+vaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH2Xss1q; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH2Xss1q"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-8019f048bc7so1038234a12.1
        for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 20:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734670719; x=1735275519; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzrK467YDHb6683nLuNKty5tprMhppTXrwq9CDcNPrc=;
        b=CH2Xss1qow7VMGKm0WATI85XJ8wJZOjHNrCDQsrLm4YUukBdXgYLq29mXHmYTFgiJ7
         bRQ7XX9laDGJL6etTIU1/acvbKwnIc/5zpXqs8HHkiL+3GruETVZwVux+TJ2D3TcSD3N
         prQA0g9p1dhtZ3xLRRTn3QcbTuB4B6ClrJxu+JTS8i8r6kYZtv3/4CxWiFHux5VuT2c8
         7D490sJNM+kvkjGLgtxSPBDhow3CiUnUfDj4B9n3IQBV477FLJPb1JahRm4U8b8q91y0
         ISPMwxslYKXNTa5Vxcb+eK4eEK2izp3anD8/TrRVD/EhK1Re66Po/gdKbQOH3pY9NWyz
         aXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734670719; x=1735275519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzrK467YDHb6683nLuNKty5tprMhppTXrwq9CDcNPrc=;
        b=JLEvE1AFfTdqPAr1rAmk6uZcDGfB+44Ujy3lwp3eUf1BwEIh9f4yXDP1UhtqU39Xo8
         0tG0WqW1z9ZVbhGAheq33obIM5F4xL6RjnNsp76oWG1MAaqILCvsUD8wMGPir5YTYFTa
         IrUQhW9ZJBK+bBF/kSsqdr8kcp1M6/Y/xLnTvmZkY/iKX3e/buZrmf9/svizo1RaTXXR
         Q2WqYe2mDlgAsnIik47VVQ1NW/5kds+Q5rPQhCTw5n29e7syaOpTrorWVa7ZlZkgV4HC
         95xLUHIzCYNijfhzihK9oy9VXkhAbc4bshFxZzjutTZZYgBO1l4CQRp/kXOX3Kio06S8
         MJpg==
X-Gm-Message-State: AOJu0Yyim2Dkequl0rpsA2eeeWwyQ5TwqMxtexmkpWs003ZDr0mC2PjD
	pzfloMUBKe3p1MBgbUmPKszSk6ImkLkuqAg4OExhk2B0Zp+1wT+dZYkBnbEv3UdWg+nB8P8rm8k
	k6fr/9bs1OnlDTHb0J0epjcbNPDk=
X-Gm-Gg: ASbGnctxl2K4Yh2RbJVeNtzJmQLQtR3mCR+XLkZgLg+bIgtlrJI6L1kqZZS+BH4zr9W
	y+u0Y223WqBwywcdPR9PUlzLzqixjrWsC5wSYPw==
X-Google-Smtp-Source: AGHT+IHJxJ9sUs45IAzsOAYruZGxAQAwzKUaZfIfo+TE77L64thBsnpNgfx49fyMjCmrocy2/0F56fVFK1f8oxmvcio=
X-Received: by 2002:a17:90b:2c84:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2f452dfce88mr2786158a91.8.1734670719354; Thu, 19 Dec 2024
 20:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241219181701.164349-1-prestwoj@gmail.com> <ee05cb0c-d317-4bd8-8736-6ffaba6d7b62@gmail.com>
 <CAG17S_P=O9P1EKFZk939SNQWA6-Q4dePvrrecBwHLXw6VBRKXA@mail.gmail.com>
In-Reply-To: <CAG17S_P=O9P1EKFZk939SNQWA6-Q4dePvrrecBwHLXw6VBRKXA@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 19 Dec 2024 22:58:28 -0600
Message-ID: <CAG17S_PFqDcbbVHByZFm_nxdcTwc-LxT-581nUad12tVW7RgGw@mail.gmail.com>
Subject: Re: [PATCH] netdev: destroy auth-proto after external auth
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just a further note, I reverted to the older firmware to give it a try:
Dec 19 22:04:36 jackrune kernel: brcmfmac: brcmf_c_preinit_dcmds:
Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265
(28bca26 CY) FWID 01-b677b91b
and now I no longer get a connection.

It appears that this works only with the latest firmware from Infineon
and only on the 3b+/4/5:
You need this firmware plus the patch to iwd and the patch to the 80211 dri=
ver:
Dec 19 22:16:58 jackrune kernel: brcmfmac: brcmf_c_preinit_dcmds:
Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
(be70ab3 CY) FWID 01-95efe7fa

It does not appear that the wifi chip in the RPi_Zero and RPi_Zero2w
get any of this love, though:
Dec 19 22:32:44 kitchenrune kernel: brcmfmac: brcmf_c_preinit_dcmds:
Firmware: BCM43430/1 wl0: Jun 14 2023 07:27:45 version 7.45.96.s1
(gf031a129) FWID 01-70bd2af7 es7
This 43430 chip is not in the latest firmware zip from Infineon.

On Thu, Dec 19, 2024 at 9:57=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Thu, Dec 19, 2024 at 12:18=E2=80=AFPM James Prestwood <prestwoj@gmail.=
com> wrote:
> >
> > Hi Keith,
> >
> > On 12/19/24 10:17 AM, James Prestwood wrote:
> > > With external auth there is no associate event meaning the auth proto
> > > never gets freed, which prevents eapol from starting inside the
> > > OCI callback. Check for this specific case and free the auth proto
> > > after signaling that external auth has completed.
> > > ---
> > >   src/netdev.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > >
> > > diff --git a/src/netdev.c b/src/netdev.c
> > > index 02496c92..2a6d94fc 100644
> > > --- a/src/netdev.c
> > > +++ b/src/netdev.c
> > > @@ -3483,6 +3483,13 @@ static void netdev_external_auth_sae_tx_associ=
ate(void *user_data)
> > >
> > >       netdev_send_external_auth(netdev, MMPDU_STATUS_CODE_SUCCESS);
> > >       netdev_ensure_eapol_registered(netdev);
> > > +
> > > +     /*
> > > +      * Free the auth proto now. With external auth there is no asso=
ciate
> > > +      * event which is where this normally gets cleaned up.
> > > +      */
> > > +     auth_proto_free(netdev->ap);
> > > +     netdev->ap =3D NULL;
> > >   }
> > >
> > >   struct rtnl_data {
> >
> > Could you give this version of the patch a try to verify it still works
> > on brcmfmac? This is just a bit simpler and more straight forward.
> >
> > Thanks,
> >
> > James
> >
> James,
>
> This patch seems to work just like the previous one. I am able to get
> a connection, collect a DHCP address and then ping the AP from the
> RPi.
>
> I use connman/iwd
>
> Dec 19 21:49:45 jackrune iwd[346]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 19 21:49:47 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd022 fail, reason -52
> Dec 19 21:49:47 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd026 fail, reason -52
> Dec 19 21:49:47 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd02a fail, reason -52
> Dec 19 21:49:47 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd02e fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd034 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd038 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd03c fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd040 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd064 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd068 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd06c fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd070 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd074 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd078 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd07c fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd080 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd084 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd088 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd08c fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd090 fail, reason -52
> Dec 19 21:49:48 jackrune iwd[346]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 19 21:49:49 jackrune connmand[454]: Adding configuration wifi_6465736=
b534145
> Dec 19 21:49:49 jackrune connmand[454]: Adding service configuration
> 6465736b534145
> Dec 19 21:49:49 jackrune connmand[454]: Interface wlan0 [ wifi ] state
> is association
> Dec 19 21:49:49 jackrune connmand[454]: ipconfig state 2 ipconfig method =
1
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, ssid: deskSAE,
> bss: d8:3a:dd:60:a3:0c, signal: -58, load: 0/255
> Dec 19 21:49:49 jackrune iwd[346]: event: state, old:
> autoconnect_full, new: connecting
> Dec 19 21:49:49 jackrune connmand[454]: Interface wlan0 [ wifi ] state
> is configuration
> Dec 19 21:49:49 jackrune connmand[454]: ipconfig state 3 ipconfig method =
1
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, External Auth
> to SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {RX} 1 packets 121 bytes
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {TX} 0 packets 0 bytes
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {update} flags 69635 <UP,LO=
WER_UP>
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd074 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd078 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd07c fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd080 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd084 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd088 fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd08c fail, reason -52
> Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
> chanspec 0xd090 fail, reason -52
> Dec 19 21:49:48 jackrune iwd[346]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 19 21:49:49 jackrune connmand[454]: Adding configuration wifi_6465736=
b534145
> Dec 19 21:49:49 jackrune connmand[454]: Adding service configuration
> 6465736b534145
> Dec 19 21:49:49 jackrune connmand[454]: Interface wlan0 [ wifi ] state
> is association
> Dec 19 21:49:49 jackrune connmand[454]: ipconfig state 2 ipconfig method =
1
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
> driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, ssid: deskSAE,
> bss: d8:3a:dd:60:a3:0c, signal: -58, load: 0/255
> Dec 19 21:49:49 jackrune iwd[346]: event: state, old:
> autoconnect_full, new: connecting
> Dec 19 21:49:49 jackrune connmand[454]: Interface wlan0 [ wifi ] state
> is configuration
> Dec 19 21:49:49 jackrune connmand[454]: ipconfig state 3 ipconfig method =
1
> Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, External Auth
> to SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {RX} 1 packets 121 bytes
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {TX} 0 packets 0 bytes
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {update} flags 69635 <UP,LO=
WER_UP>
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {newlink} index 3
> address B8:27:EB:A4:6E:0F mtu 1500
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {newlink} index 3
> operstate 5 <DORMANT>
> Dec 19 21:49:49 jackrune systemd-networkd[163]: wlan0: Connected WiFi
> access point: deskSAE (d8:3a:dd:60:a3:0c)
> Dec 19 21:49:49 jackrune iwd[346]: hardware_rekey not supported
> Dec 19 21:49:49 jackrune iwd[346]: event: state, old: connecting, new:
> connecting (netconfig)
> Dec 19 21:49:49 jackrune systemd-networkd[163]: wlan0: Gained carrier
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {RX} 3 packets 356 bytes
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {TX} 4 packets 652 bytes
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {update} flags 69699
> <UP,RUNNING,LOWER_UP>
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {newlink} index 3
> address B8:27:EB:A4:6E:0F mtu 1500
> Dec 19 21:49:49 jackrune connmand[454]: wlan0 {newlink} index 3 operstate=
 6 <UP>
> Dec 19 21:49:50 jackrune systemd-networkd[163]: wlan0: Gained IPv6LL
> Dec 19 21:49:52 jackrune iwd[346]: event: state, old: connecting
> (netconfig), new: connected
> Dec 19 21:49:52 jackrune systemd-resolved[316]: wlan0: Bus client set
> DNS server list to: 192.168.5.1
> Dec 19 21:49:52 jackrune connmand[454]: wlan0 {add} address
> 192.168.5.207/24 label wlan0 family 2
> Dec 19 21:49:53 jackrune kernel: sh (18913): drop_caches: 3
> Dec 19 21:49:54 jackrune connmand[454]: rp_filter set to 2 (loose mode
> routing), old value was 0
> Dec 19 21:49:54 jackrune connmand[454]: Interface wlan0 [ wifi ] state is=
 ready
>
> # ping 192.168.5.1
> PING 192.168.5.1 (192.168.5.1) 56(84) bytes of data.
> 64 bytes from 192.168.5.1: icmp_seq=3D1 ttl=3D64 time=3D26.7 ms
> 64 bytes from 192.168.5.1: icmp_seq=3D2 ttl=3D64 time=3D4.79 ms
> 64 bytes from 192.168.5.1: icmp_seq=3D3 ttl=3D64 time=3D4.39 ms
> 64 bytes from 192.168.5.1: icmp_seq=3D4 ttl=3D64 time=3D4.42 ms
>
> # ifconfig wlan0
> wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet 192.168.5.207  netmask 255.255.255.0  broadcast 192.168.5.25=
5
>         ether b8:27:eb:a4:6e:0f  txqueuelen 1000  (Ethernet)
>         RX packets 15  bytes 2718 (2.6 KiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 32  bytes 4668 (4.5 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
