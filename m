Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F320E4
	for <iwd@lists.linux.dev>; Fri, 12 Aug 2022 16:03:12 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4M47Wm6j3Dz9sSd;
	Fri, 12 Aug 2022 17:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joachim-breitner.de;
	s=MBO0001; t=1660319636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gq9K7Ut0VDNSbQN5E/R6I08u8mjD2j9KFdVwanBPk6Q=;
	b=PjDp8j/wUWDWIyGiVCaGk7H5UXgXIyQYhiH9CWWD9/nTmHHX0FM+1f0t0Arluio3DElrre
	T14Bmf6cTvscTmxC6erYSFFIO3wXEMrynHfB24L3MiRqZ8ErvWaZICfVDE+ku+aRRzDM0k
	enVpEJKa5Pgqo5YW5sYfWELFdbJSGtNP7BfzqoZym0QKGIJAC3Ocn8BQbEkbi2vRbaV/d7
	KzuSwL4eWCgs8XZ5T+0o+qXafq9sd32CIOGHyn/Wa90jqUrIRzoPJ+WJAT67i3WXDLs4FL
	qhiQQ27nIZGMBJPfDbYOfbRYyt3InEG0YSTM1hc8lflC0maCaT147k+3y1arTA==
Message-ID: <bb8de096a7a6d3775271e598189c312e1d9079ac.camel@joachim-breitner.de>
Subject: Re: iwd needs restart after suspending
From: Joachim Breitner <mail@joachim-breitner.de>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Fri, 12 Aug 2022 17:53:55 +0200
In-Reply-To: <47479f89-c065-8402-818b-d0becc285c27@gmail.com>
References: 
	<f79517c3f23c14dcd6db0dd5f3fb48fdeb687315.camel@joachim-breitner.de>
	 <fa74ccdf82f2f4db651d50e51583bd85eca3fb28.camel@joachim-breitner.de>
	 <47479f89-c065-8402-818b-d0becc285c27@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Dear Denis,


Am Freitag, dem 12.08.2022 um 10:01 -0500 schrieb Denis Kenzior:
> > I recorded the output of iwd -d on 5.15 and 5.19, see attachement. The
> > relevant bit seems to be
> >=20
>=20
> We should add this to our debug output, but what driver / hardware are yo=
u using?


~ $ hwinfo --wlan
06: PCI 14.3: 0282 WLAN controller                             =20
  [Created at pci.386]
  Unique ID: y9sn.qVqUKmQ3GD6
  SysFS ID: /devices/pci0000:00/0000:00:14.3
  SysFS BusID: 0000:00:14.3
  Hardware Class: network
  Model: "Intel Wi-Fi 6 AX201"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0xa0f0 "Wi-Fi 6 AX201"
  SubVendor: pci 0x8086 "Intel Corporation"
  SubDevice: pci 0x0070=20
  Revision: 0x20
  Driver: "iwlwifi"
  Driver Modules: "iwlwifi"
  Device File: wlan0
  Features: WLAN
  Memory Range: 0x603d1cc000-0x603d1cffff (rw,non-prefetchable)
  IRQ: 16 (no events)
  HW Address: 2c:8d:b1:25:46:21
  Permanent HW Address: 2c:8d:b1:25:46:21
  Link detected: yes
  WLAN channels: 1 2 3 4 5 6 7 8 9 10 11 12 13 36 40 44 48 52 56 60 64 100 =
104 108 112 116 120 124 128 132 136 140
  WLAN frequencies: 2.412 2.417 2.422 2.427 2.432 2.437 2.442 2.447 2.452 2=
.457 2.462 2.467 2.472 5.18 5.2 5.22 5.24 5.26 5.28 5.3 5.32 5.5 5.52 5.54 =
5.56 5.58 5.6 5.62 5.64 5.66 5.68 5.7
  WLAN encryption modes: WEP40 WEP104 TKIP CCMP
  WLAN authentication modes: open sharedkey wpa-psk wpa-eap
  Module Alias: "pci:v00008086d0000A0F0sv00008086sd00000070bc02sc80i00"
  Config Status: cfg=3Dnew, avail=3Dyes, need=3Dno, active=3Dunknown

>=20
> So the question is why is the kernel changing this behavior?

I could narrow it down to 5.15 vs. 5.17, if that helps. But=20
linux/drivers/net/wireless/intel/iwlwifi seems to be a rather busy
directory:
https://github.com/torvalds/linux/commits/v5.17/drivers/net/wireless/intel/=
iwlwifi

>   iwd is not aware=20
> of resume/suspend, so I'm not sure we can tell whether the ifdown event c=
ame=20
> from the user manually bringing down the device or due to suspend / resum=
e.
>=20
> What does rfkill look like on 5.15 & 5.19 after resume?


On 5.19, before suspend, after suspend and after restarting iwd it is
always simply

~ $ LANG=3DC rfkill
ID TYPE      DEVICE                   SOFT      HARD
 0 bluetooth tpacpi_bluetooth_sw unblocked unblocked
 1 bluetooth hci0                unblocked unblocked
 2 wlan      phy0                unblocked unblocked

Cheers,
Joachim

--=20
Joachim Breitner
  mail@joachim-breitner.de
  http://www.joachim-breitner.de/

