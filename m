Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B939FE5
	for <iwd@lists.linux.dev>; Sat, 24 Aug 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724542355; cv=none; b=sM+GlTtRsXB4KvFwxvkilAfQlvYqUtT9Fuq3pXsho9QJTgqodXJTWtGdrCZCIkl91o3tkzBG2fnSNDVpxNlDxQ9NeDpxTQ2U0WUm9lcUCN00sSSNM7FfN0YiEVAMPsLu2w1VjaqJEF7CG276uhBX4sm3QK4an627hzuNYwI2/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724542355; c=relaxed/simple;
	bh=IwJVp0J+ESCFXMuUf8RKnTC+HZitH7PHuqRjhR+06u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxRaECxpsEa6rz9s7nqd/VRL2roiT4d+nZxSCls0N9dwupsuUirj5duJ7HGBYUwbOYtHrgHkui/bSiBmAGrKONVfVGcHQzZbY1rXiyC2hrTq2fTuU9ccE8044mANmA3hRR8gG+/Vsd7HnQBkht4fwxtqJDXXz3MiJXg7QIUo+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RihI0ZpP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RihI0ZpP"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3eda6603cso2492124a91.3
        for <iwd@lists.linux.dev>; Sat, 24 Aug 2024 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724542353; x=1725147153; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJs5Zu+L8WBCpCRpxoKZQKIcryc53VH1sQm/pdy3BtY=;
        b=RihI0ZpPFfnPycVeylV6gRvBtnvoeWyToKX5acijiUdiutaORPnCSLPUdYt7Dk9WKZ
         3t2A8he+4/MO3JEy/uhtUmQX94xaY3SN8pXB+JMl3/2LANmfVWe+1gr47TzYiDFTuqp9
         lbah942XMp3aX+NbaONXJPQK3ZFrE389BSz12bFCEmgTdcX2bz4Syr8/KUCarbNP+Hwf
         j30PZtnlBYfNOu/Y3Yks46ZScvQul3nL48VcxVflo2ywE0BGQX0Kwe66WC2NUeQWJJ9p
         NwNf7eS8a9too+tTLPU1FC4rd+DQWc2+mNtPiX5e64UMGvMWzZrhaFO8o57VmSU1KfHe
         impA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724542353; x=1725147153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJs5Zu+L8WBCpCRpxoKZQKIcryc53VH1sQm/pdy3BtY=;
        b=xCmN3mKrOCmNC8cZu6dSs9uKcaw5tHwYKaWLHwFD+ICVmMzzJ5wtSIDq4k+nIaxkCv
         29819ABU5EfAot3sc2aWJb71S+07b3z9OTvZMjWlJMJfIbZahwbimHrPPhSDcW8CdXw1
         3L14q6ZUKx0v3Sp0eFtUINSBIDEVgMO36FjImlpR3k5AfrGtV7C43uX9yq14iIYzYoc8
         T9dj5mwFeY835BZT8YV5iyFpQm4FGgcudHnBw/Ky48VWA22q6Ae7QzTTviXOOiTbA9L4
         pIAviWZz7gAH+agaw+ohUWaQVglpam6EeVAlZUFzkQuXftxOtCx0JbIVrsAZGZjJVQz0
         bPig==
X-Gm-Message-State: AOJu0Yxh9MFnffuXilxg4OX98PXh9VaKgoBFF6k/8EdTY3OwvjAy2PtC
	Hx7K1qaHWgm92fx0ru7M4DwBFVo2z9ZC0Kfa/kHlj4EgdlSXRD3eUELyl8jwnzB2930mwDmEFRg
	rxbKNgrXjhgCkLW3Y56RlZ2JF8PWqE8xJ
X-Google-Smtp-Source: AGHT+IGPG7Gx5YmY4u5FCOoUSDoteSUwLbiVsDSUjZ4IYDfsK1GEoSE9Pp7jfVochKJT43e7zVZAasjWmcRghQGgbY8=
X-Received: by 2002:a17:90a:9314:b0:2c8:ac1:d8c3 with SMTP id
 98e67ed59e1d1-2d646d4bb42mr6936554a91.29.1724542352458; Sat, 24 Aug 2024
 16:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823174220.498594-1-denkenz@gmail.com> <CAG17S_NjMwU4=qn_jJzUJwPEOTT1H-SPVb7Re0P4fyPNUg=WqA@mail.gmail.com>
 <f36d03e4-e85a-438e-adef-b6c2da0c8f72@gmail.com> <CAG17S_P615tCPt0Jy+-BLzFx0N9JiksVXdUj4-iRAA9JTWdotg@mail.gmail.com>
In-Reply-To: <CAG17S_P615tCPt0Jy+-BLzFx0N9JiksVXdUj4-iRAA9JTWdotg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 24 Aug 2024 18:32:21 -0500
Message-ID: <CAG17S_Oe0_DnVZW32GrArC9XCQUHh3QEYXxvXatWQiuwV5_QkA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 11:20=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote:
>
> On Fri, Aug 23, 2024 at 10:21=E2=80=AFPM Denis Kenzior <denkenz@gmail.com=
> wrote:
> >
> > Hi Keith,
> >
> > On 8/23/24 7:38 PM, KeithG wrote:
> > > Denis,
> > >
> > >
> > > On Fri, Aug 23, 2024 at 12:42=E2=80=AFPM Denis Kenzior <denkenz@gmail=
.com> wrote:
> > >>
> > >> This series implements External Auth support on Full MAC cards that =
do
> > >> not support SAE offload.  I have not been able to test this fully si=
nce
> > >> the brcmfmac firmware on the RPi 5 does not actually work properly.
> > >> Maybe some enterprising person can test it on a firmware that does w=
ork?
> > >>
> > >> Denis Kenzior (2):
> > >>    netdev: external auth support
> > >>    sae: Allow ability to force Group 19 / Hunt and Peck
> > >>
> > >>   src/netdev.c      | 258 +++++++++++++++++++++++++++++++++++++++++-=
----
> > >>   src/nl80211util.c |   4 +-
> > >>   src/sae.c         |  20 ++++
> > >>   src/sae.h         |   3 +
> > >>   src/wiphy.c       |  19 ++--
> > >>   5 files changed, 263 insertions(+), 41 deletions(-)
> > >>
> > >> --
> > >> 2.45.2
> > >>
> > >>
> > > I was watching for this. I built iwd from git and tried it on my Pi5.
> > > As you said, it did not work:
> > >
> > > Aug 23 19:24:29 pi5 iwd[16297]: SAE unsupported: brcmfmac needs
> > > CMD_EXTERNAL_AUTH for SAE
> >
> > I don't think you applied the patch correctly.  You should see:
> >
> > +               /* Case 3 */
> > +               iwd_notice(IWD_NOTICE_CONNECT_INFO,
> > +                       "FullMAC driver: %s using SAE.  Expect EXTERNAL=
_AUTH",
> >                          wiphy->driver_str);
> >
> > > Aug 23 19:24:29 pi5 iwd[16297]: src/wiphy.c:wiphy_select_akm() Can't
> > > use SAE, trying WPA2
> > > Aug 23 19:24:32 pi5 iwd[16297]: src/agent.c:agent_disconnect() agent
> > > :1.471 disconnected
> > > Aug 23 19:24:32 pi5 iwd[16297]: src/agent.c:agent_free() agent free
> > > 0x5555946ddaf0
> > >
> > > I believe this is the latest firmware from Infineon for the RPi fmac =
cards:
> > > Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265
> > > (28bca26 CY) FWID 01-b677b91b
> > > Firmware: BCM43430/1 wl0: Jun 14 2023 07:27:45 version 7.45.96.s1
> > > (gf031a129) FWID 01-70bd2af7 es7
> > >
> > > I know there are a number of fmac cards. Does the firmware on these
> > > work differently to other brcmfmac cards? Do all of them use
> > > CMD_EXTERNAL_AUTH?
> >
> > No idea.  All other brcmfmac cards used SAE offload.  Cypress firmware =
seems to
> > have gone with EXTERNAL_AUTH.  Not sure about other full mac cards.  I =
can see
> > references to EXTERNAL_AUTH in two upstream drivers:
> >
> > [denkenz@archdev linux]$ grep -R "cfg80211_external_auth_request" *
> > drivers/net/wireless/microchip/wilc1000/hif.c:
> > cfg80211_external_auth_request(vif->ndev, &vif->auth,
> > drivers/net/wireless/quantenna/qtnfmac/event.c: ret =3D
> > cfg80211_external_auth_request(vif->netdev, &auth, GFP_KERNEL);
> >
> > But the hardware seems to be unobtanium.  Maybe others can report what =
other
> > solutions use EXTERNAL_AUTH?  Maybe Pinephone?
> >
> > Regards,
> > -Denis
>
> Denis,
>
> Sorry, I mis-read and assumed it was committed to git and not a patch.
> I created the 2 patches and built it again.
>
> iwctl looks like it is trying something:
> [iwd]# station wlan0 connect deskSAE
> Type the network passphrase for deskSAE psk.
> Passphrase: *********
> [iwd]#
>
> but it never connects. I do notice that connman thinks it is up and
> assigns a 169.254.x.x address
>
> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Network
> is WPA3-Personal...
> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver:
> brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Aug 24 11:18:06 pi5 iwd[28085]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 19
> Aug 24 11:18:06 pi5 iwd[28085]:
> src/network.c:network_generate_sae_pt() Generating PT for Group 20
> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Network
> is WPA3-Personal...
> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver:
> brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_cqm_rssi_update()
> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_insert()
> Inserting work item 4
> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_next()
> Starting work item 4
> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, ssid: deskSAE,
> bss: d8:3a:dd:60:a3:0c, signal: -63, load: 0/255
> Aug 24 11:18:06 pi5 iwd[28085]: event: state, old: autoconnect_full,
> new: connecting
> Aug 24 11:18:06 pi5 iwd[28085]: src/scan.c:scan_periodic_stop()
> Stopping periodic scan for wdev 1
> Aug 24 11:18:06 pi5 iwd[28085]: CMD_SET_CQM failed: Operation not support=
ed
> Aug 24 11:18:06 pi5 connmand[635]: Interface wlan0 [ wifi ] state is
> configuration
> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
> Unicast notification External Auth(127)
> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, External Auth to
> SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> Aug 24 11:18:06 pi5 iwd[28085]:
> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() MLME
> notification Frame TX Status(60)
> Aug 24 11:18:06 pi5 iwd[28085]:
> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
> Unicast notification Frame(59)
> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() MLME
> notification Frame TX Status(60)
> Aug 24 11:18:06 pi5 iwd[28085]:
> src/netdev.c:netdev_external_auth_sae_tx_associate()
> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
> Unicast notification Frame(59)
> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_external_auth_cb()
> Failed to send External Auth: Invalid exchange(52)
> Aug 24 11:18:06 pi5 kernel: ieee80211 phy0:
> brcmf_cfg80211_external_auth: auth_status iovar failed: ret=3D-52
> Aug 24 11:18:46 pi5 connmand[635]: Interface wlan0 [ wifi ] state is read=
y
> Aug 24 11:18:46 pi5 connmand[635]: wlan0 {add} address
> 169.254.242.107/16 label wlan0 family 2
>
>
> Need a log of some sort or is this adequate?
>
> Keith

I gave it a bit more thought and wondered if NetworkManager could deal
with wpa3 and this patched verison of iwd. Also no connection. I first
verified that nmcli could connect to the wpa2 ssid then tried this
one.

from cli:
#nmcli --ask dev wifi connect deskSAE
Password: =E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=
=E2=80=A2=E2=80=A2
Error: Timeout 90 sec expired.

Aug 24 18:07:43 pi5 iwd[212556]: event: connect-info, FullMAC driver:
brcmfmac using SAE.  Expect EXTERNAL_AUTH
Aug 24 18:08:17 pi5 sudo[219244]:     root : TTY=3Dpts/0 ; PWD=3D/root ;
USER=3Droot ; COMMAND=3D/usr/bin/nmcli --ask dev wifi connect deskSAE
Aug 24 18:08:17 pi5 sudo[219244]: pam_unix(sudo:session): session
opened for user root(uid=3D0) by root(uid=3D0)
Aug 24 18:08:17 pi5 polkitd[212049]: Registered Authentication Agent
for unix-process:219250:1397111 (system bus name :1.7111 [nmcli --ask
dev wifi connect deskSAE], obje>
Aug 24 18:08:23 pi5 NetworkManager[216946]: <info>  [1724540903.5369]
device (wlan0): Activation: starting connection 'deskSAE'
(20e14402-d74a-48d0-a6f9-5c8d0404d21d)
Aug 24 18:08:23 pi5 NetworkManager[216946]: <error> [1724540903.5390]
audit: failed to open auditd socket: Protocol not supported
Aug 24 18:08:23 pi5 NetworkManager[216946]: <info>  [1724540903.5391]
audit: op=3D"connection-add-activate"
uuid=3D"20e14402-d74a-48d0-a6f9-5c8d0404d21d" name=3D"deskSAE" pid=3D2>
Aug 24 18:08:23 pi5 NetworkManager[216946]: <info>  [1724540903.5398]
device (wlan0): state change: disconnected -> prepare (reason 'none',
sys-iface-state: 'managed')
Aug 24 18:08:23 pi5 NetworkManager[216946]: <info>  [1724540903.5400]
device (wlan0): state change: prepare -> config (reason 'none',
sys-iface-state: 'managed')
Aug 24 18:08:23 pi5 iwd[212556]: event: connect-info, FullMAC driver:
brcmfmac using SAE.  Expect EXTERNAL_AUTH
Aug 24 18:08:23 pi5 iwd[212556]: event: connect-info, FullMAC driver:
brcmfmac using SAE.  Expect EXTERNAL_AUTH
Aug 24 18:08:23 pi5 iwd[212556]: event: connect-info, ssid: deskSAE,
bss: d8:3a:dd:60:a3:0c, signal: -57, load: 0/255
Aug 24 18:08:23 pi5 iwd[212556]: event: state, old: autoconnect_full,
new: connecting
Aug 24 18:08:23 pi5 iwd[212556]: CMD_SET_CQM failed: Operation not supporte=
d
Aug 24 18:08:23 pi5 NetworkManager[216946]: <info>  [1724540903.5434]
device (wlan0): new IWD device state is connecting
Aug 24 18:08:23 pi5 iwd[212556]: event: connect-info, External Auth to
SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
Aug 24 18:08:23 pi5 kernel: ieee80211 phy0:
brcmf_cfg80211_external_auth: auth_status iovar failed: ret=3D-52

Keith
