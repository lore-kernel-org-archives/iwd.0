Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47989823D9
	for <iwd@lists.linux.dev>; Thu,  2 May 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654633; cv=none; b=oKx+VwyOnBSP5zcMV3IXrBKMEyTgtt9zO96yLqVCblsWkqaozOyC2kyPPkAS2iyLO6hD0KSZxY2bVg/Q0vIJ5cthn7u08JK0PM/fz/jnH0TD8AuNS9jgZipUyebJJJoliR/A9xzaQmrUoiulQ2F3xFu3PsB8tOYDtghL7a+jXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654633; c=relaxed/simple;
	bh=+/OYfimq3Go1ek9T2j9ckysCuxxV5irMY94SnY0hs9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQgcFPNRgz8dUZmxyaI79KfT13fnaPWnuxSdUS9zfOLQ+WFXMatHeYDYBwu4a1giK5ZIbDAyoTjHb0AaWSit40TqWUkKSsoVcwI/hkbldTaC0k0uNRGHyCzsUNGyKZTsi6nsaB8/7f/l0Ez22uq3W/LMO79nEjsmBt0xsBOoEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd9H9Yvm; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd9H9Yvm"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f44390e328so186692b3a.2
        for <iwd@lists.linux.dev>; Thu, 02 May 2024 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714654631; x=1715259431; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpdCEOUmYkbRZLpAbzjkTWZeNlJOyyPSq4DB75CYrLc=;
        b=Hd9H9YvmonRc38p3cFnmethEc2qjGGVk5TMSxoJ/zKD+vZlFV4hKt2Cl8M0nd9vYjw
         cnbtXQcM5VlgmwZeqNrwscx2/v0twu8jPwCtaBsGlktE3SopJzPufrmkJXCdFPjpApIF
         Cdvg2Gc/zDDHwhSRrJq61swKqz9jKUVrKHY28WT425Lryao3tBJXdvm2+E7eZlMWeR2g
         1fnSIbPUrgxALIyJqeLGUcqN3AjCl7ABEjplQZtrQm8xCiRcY0BTR1EoLYe4EBmuvnY8
         srgge2IQw/LGog3/lEuX5Wee79mwX1DpR9l+6tqNXuKG1LOIahXCdkrc3u+NiBTfv9AI
         h6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714654631; x=1715259431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpdCEOUmYkbRZLpAbzjkTWZeNlJOyyPSq4DB75CYrLc=;
        b=OclhPnom4qm9lT3kjLDfKnepZzxs5E0fwsEhIVWsa0NNqhNTR1mG8EWEoY/jUnEqTr
         hFKKzKyz3HPxSkyNetWuKwRvIs9NW+69XsLsy5/OjkU5bWGcDoxY/IhZGGghjDasVIhE
         FdD0BR7ZEZBWvnNpZDuyaOHUlTOGc9F/mOOCntkEVMwXroJIdFLSsXLrcCuID6PWw+Ji
         ecFWHWSceSZsYCcabpyo4FcQkKx/p4hZOJ7RuAnvxRYkitmv4Qp0NZXHjqaHxgsqTp8u
         ZzqofrT0437L9OAWW9ZT4ZzDXWmURsXJo06IOhqPqvsQi6I1j72xT31AM95Fae4RjSFx
         nJtg==
X-Forwarded-Encrypted: i=1; AJvYcCUTJqjQABHnXnv/kWHrzyuAv5lnYE+qMmZXG7HVd07BMu8ctdZdyIEVQA9RS7o4LQvyQ1fRDrfTMGTDNv8cLqs5WxqF
X-Gm-Message-State: AOJu0YwNNifLqrnCKEc2cW/HgTzLZ9ILFSDy6TEyVpdeFZ/tKgtsZaPm
	GB7XNXGkBVceXOKSnH7mTp/AoLnyP+Gy+5iL9t2BKjANIfhpk/pF8JDfMMFvaDwgufe9KCrEBvR
	Gg+py/5xp/s5TzGnGTv6yL+2ldzo=
X-Google-Smtp-Source: AGHT+IHEbCxVjDQCbrUF8GlAAI1fmRBalBlk1wzdsLfSqDFYiO83GmnU2bYArFoj5JDIRdI9NAWe58owl58VjrLLwhI=
X-Received: by 2002:a17:90a:de92:b0:2b0:8e9e:7d07 with SMTP id
 n18-20020a17090ade9200b002b08e9e7d07mr1995197pjv.3.1714654631300; Thu, 02 May
 2024 05:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
 <91648487-9c59-40f9-996d-dfad1f1adcbb@gmail.com> <38861D9C-F5F5-4149-99CD-0C59480986ED@holtmann.org>
 <25618c14-df5a-4980-9e62-dd5c96084455@gmail.com> <CAG17S_MTbFpQB-LDu6s87D1stbojwpto3y+V1X4kSPe3Gkixug@mail.gmail.com>
In-Reply-To: <CAG17S_MTbFpQB-LDu6s87D1stbojwpto3y+V1X4kSPe3Gkixug@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 2 May 2024 07:56:59 -0500
Message-ID: <CAG17S_PnK8PebjYZT5s0qyPMn7HhL=D+mC4VaG4i2ZAydeOjSA@mail.gmail.com>
Subject: Re: Raspberry Pi 5 and WPA3
To: James Prestwood <prestwoj@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Harry ten Berge <htenberge@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 7:19=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote:
>
> On Tue, Apr 30, 2024 at 6:24=E2=80=AFAM James Prestwood <prestwoj@gmail.c=
om> wrote:
> >
> > Hi Marcel,
> >
> > On 4/30/24 12:42 AM, Marcel Holtmann wrote:
> > > Hi James,
> > >
> > >>> I'm not sure this is the right place to ask for some assistance, bu=
t
> > >>> here we go...
> > >>>
> > >>> I'm the author for a small Raspberry Pi audio image that is
> > >>> specifically targeting Roon.
> > >>> If you're not familiair with Roon: it's an audio streaming platform
> > >>> targeting audiophiles ;-)
> > >>>
> > >>> Anyways, about a year ago I switched from wpa_supplicant to iwd, to
> > >>> full satisfaction.
> > >>> Better and easier integration, and overall a feel of me being in mo=
re control.
> > >>>
> > >>> Now, recently I'm having issues with WPA3 support. This is partly
> > >>> related to firmware (it's just so obfuscated how this all works wit=
h
> > >>> firmware from broadcom and firmware from cypress :-(
> > >>>
> > >>> And one of those things is that I can't get it to work on the new P=
i
> > >>> 5. Specifically IWD reporting this:
> > >>>
> > >>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> > >>> Network is WPA3-Personal...
> > >>> Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
> > >>> CMD_EXTERNAL_AUTH for SAE
> > >>> Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
> > >>> Can't use SAE, trying WPA2
> > >>>
> > >>> Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message =
and
> > >>> advise me to go back to wpa_supplicant. Which is not something I wo=
uld
> > >>> like to do for various reasons...
> > >>>
> > >>> Do you have any advice for me on what I can do? is this
> > >>> CMD_EXTERNAL_AUTH really related to  this and are you planning on
> > >>> implementing this?
> > >> Unfortunately the external auth support is not yet implemented in IW=
D. The brcmfmac driver itself is rather unique being a fullmac driver. Depe=
nding on how you look at it, this on its own is "easier" to support. It han=
dles connecting/roaming all on its own. But then, for some reason, someone =
didn't want to do SAE/WPA3 on the card itself so they came up with some one=
-off mechanism to offload that onto userspace. This is one of those things =
that got put upstream that is a pain for projects like IWD to support IMO. =
Its something we do need to support eventually, especially given the raspi =
5 requires it.
> > > if the Broadcom firmware finally would be able to support external_au=
th,
> > > then it would be nice, but as seen on recent linux-wireless discussio=
ns,
> > > it is unclear who does what. Broadcom wanted to support external_auth=
,
> > > but then Infineon (the new owner) might be rather using SAE as part o=
f
> > > the firmware. And actually the chip on the RPi5 marks itself as Cypre=
ss
> > > and so you it is an unclear story. I think that Raspberry Pi foundati=
on
> > > should get their story straight. Until really recently they shipped a
> > > firmware that couldn=E2=80=99t do SAE and also their drivers couldn=
=E2=80=99t even do
> > > external_auth and you were stuck with WPA2 only.
> > >
> > > https://holtmann.dev/enabling-wpa3-on-raspberry-pi/
> > I was not aware that it didn't even support it correctly. I figured
> > broadcom was who added it in the first place.
> > >
> > > You can use an upstream firmware from linux-firmware and make the RPi=
5
> > > support WPA3. And as of a few weeks ago, even RPi5 latest Debian was
> > > switching to the upstream firmware.
> > >
> > > On side note, there exists no wpa_supplicant release that really supp=
orts
> > > SAE offload properly. You need to back port a lot of patches or hope
> > > that your distro back ported them for you.
> > >
> > > We should actually check if nl80211 tells us that external_auth is
> > > supported by the driver. And if not (which is the case for the Broadc=
om
> > > upstream driver) send a proper message to users and not lead them int=
o
> > > a wild goose chase.
> > >
> > > Regards
> > >
> > > Marcel
> > >
> >
>
> FWIW, the most recent update to the RPI Bookworm image has enabled
> this capability:
> # uname -a
> Linux pi5 6.6.28+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.28-1+rpt1
> (2024-04-22) aarch64 GNU/Linux
>
> # dmesg | grep brcmfmac
> [    2.195263] brcmfmac: F1 signature read @0x18000000=3D0x15264345
> [    2.209946] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    2.216566] usbcore: registered new interface driver brcmfmac
> [    2.384898] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> available (err=3D-2)
> [    2.385212] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
> 01-996384e2
>
> # iw list
> Wiphy phy0
> ...
>     Supported extended features:
>         * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>         * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station=
 mode
>         * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in stati=
on mode
>         * [ DFS_OFFLOAD ]: DFS offload
>         * [ SAE_OFFLOAD ]: SAE offload support
>         * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>         * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>
> This was achieved here with a normal 'apt update ; apt upgrade' routine.
>
> This appears to work for all Pis, now. Even a 32 bit image on a 3b+
> with similar hardware:
> # uname -a
> Linux rpi32 6.6.28+rpt-rpi-v7 #1 SMP Raspbian 1:6.6.28-1+rpt1
> (2024-04-22) armv7l GNU/Linux
> # iw list
> ...
>     Supported extended features:
>         * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>         * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station=
 mode
>         * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in stati=
on mode
>         * [ DFS_OFFLOAD ]: DFS offload
>         * [ SAE_OFFLOAD ]: SAE offload support
>         * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>         * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>
> The PiZero2W does not show this capability with the same 64 bit image
> running as it has different hardware with different firmware:
> # dmesg | grep brcmfmac
> [    6.051393] brcmfmac: F1 signature read @0x18000000=3D0x1542a9a6
> [    6.077172] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43430b0-sdio for chip BCM43430/2
> [    6.080782] usbcore: registered new interface driver brcmfmac
> [    6.476401] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> available (err=3D-2)
> [    6.481953] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/2
> wl0: Mar 31 2022 17:24:51 version 9.88.4.77 (g58bc5cc) FWID
> 01-3b307371
>
> Keith

I got around to testing this a bit tonight. I set up my Pi5 with
hostapd and used this /etc/hostapd/hostapd.conf

# cat /etc/hostapd/hostapd.conf
# interface and driver
interface=3Dap0
driver=3Dnl80211

# WIFI-Config
ssid=3DSSIDWPA3
channel=3D7
hw_mode=3Dg
ieee80211n=3D1
wmm_enabled=3D1
macaddr_acl=3D0
auth_algs=3D1
max_num_sta=3D10

wpa=3D2
wpa_key_mgmt=3DSAE
rsn_pairwise=3DCCMP
ieee80211w=3D2
wpa_passphrase=3Dpassword
sae_pwe=3D2

Form the log, it looks like SAE is enabled and ruinning, but I do not
know what I am looking at.
Using interface ap0 with hwaddr d8:3a:dd:27:6f:a7 and ssid "SSIDWPA3"
...
SAE: Derive PT - group 19
SAE: SSID - hexdump_ascii(len=3D8):
     53 53 49 44 57 50 41 33                           SSIDWPA3
SAE: password - hexdump_ascii(len=3D9): [REMOVED]
SAE: pwd-seed - hexdump(len=3D32): [REMOVED]
SAE: pwd-value (u1 P1) - hexdump(len=3D48): [REMOVED]
SAE: u1 - hexdump(len=3D32): [REMOVED]
...

I can 'see' it from my other pi running iwd and on my laptop, but I
cannot connect on either. I get nothing in the log. When I type in the
password, I get:

[iwd]# station wlan0 connect SSIDWPA3
Type the network passphrase for SSIDWPA3 psk.
Passphrase: *********
Operation failed

Both Pis show that they have what Marcel noted:

    Supported extended features:
        * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
        * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station m=
ode
        * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station=
 mode
        * [ DFS_OFFLOAD ]: DFS offload
        * [ SAE_OFFLOAD ]: SAE offload support
        * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
        * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support

Is my config wrong?

The version of iwd I am running is 2.17 built from git with the latest
commit as of e3f6a2c. The version if hostapd is:
# hostapd -v
hostapd v2.10
User space daemon for IEEE 802.11 AP management,
IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
