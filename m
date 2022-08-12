Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AF620E4
	for <iwd@lists.linux.dev>; Fri, 12 Aug 2022 16:16:11 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4M481J74xZz9sTD;
	Fri, 12 Aug 2022 18:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joachim-breitner.de;
	s=MBO0001; t=1660320965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeqigphSaIz1yKQV+Ue751ayFnN8JRf1cP7aQzTH7HY=;
	b=EuBFffaGTAHEJRG5CFD9w4JaOAHfCYCrMFNIe2sY84bZNN9JlnVGh5H+MSIhL/BA3GqV+1
	D4SlLAWzldc2Re0u19iw+hcLJfRltwzoyzCNQ7cWqtmiuf1tOqTgp3Af7mf9P3oZpSJsZp
	zMTk+ZhtbGzOD5D6jx2CIl7LcxU9/ueFtXXk3OfUDXgTM267kwBfmG/bJaCDF4ZQQ8xyzM
	NB72RJ+Artw0qObw6lFFtreiY6yoapxweosnvJ+zFfD4c2vdxqbgdJRGuBW8qkMd5Onumh
	j9mPTYycG25syvtOGCHS1uKaGYsfwCuERY6u0Y7DBqBh5VLY+DIk0nUxL0/zzw==
Message-ID: <bf762c9c0e528ef2a04ee423d54c4be0c082be77.camel@joachim-breitner.de>
Subject: Re: iwd needs restart after suspending
From: Joachim Breitner <mail@joachim-breitner.de>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Fri, 12 Aug 2022 18:16:04 +0200
In-Reply-To: <ebbf6098-299a-63cf-e016-5d200784970a@gmail.com>
References: 
	<f79517c3f23c14dcd6db0dd5f3fb48fdeb687315.camel@joachim-breitner.de>
	 <fa74ccdf82f2f4db651d50e51583bd85eca3fb28.camel@joachim-breitner.de>
	 <47479f89-c065-8402-818b-d0becc285c27@gmail.com>
	 <bb8de096a7a6d3775271e598189c312e1d9079ac.camel@joachim-breitner.de>
	 <ebbf6098-299a-63cf-e016-5d200784970a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4M481J74xZz9sTD

Hi,

Am Freitag, dem 12.08.2022 um 10:45 -0500 schrieb Denis Kenzior:

> > >=20
> > > So the question is why is the kernel changing this behavior?
> >=20
> > I could narrow it down to 5.15 vs. 5.17, if that helps. But
> > linux/drivers/net/wireless/intel/iwlwifi seems to be a rather busy
> > directory:
> > https://github.com/torvalds/linux/commits/v5.17/drivers/net/wireless/in=
tel/iwlwifi
>=20
> That would help, but ideally we need a bisected commit or something else=
=20
> concrete to work with.

Yeah, but bisecting this with all the manual rebuilding, rebooting,
suspending sounds daunting=E2=80=A6

>   Do you see anything suspicious in dmesg?

Hmm, maybe this is suspicious?

[ 6215.382573] PM: suspend entry (s2idle)
[ 6215.391000] Filesystems sync: 0.008 seconds
[ 6215.514851] Freezing user space processes ... (elapsed 0.001 seconds) do=
ne.
[ 6215.516769] OOM killer disabled.
[ 6215.516781] Freezing remaining freezable tasks ... (elapsed 0.001 second=
s) done.
[ 6215.517980] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[ 6215.518444] wlan0: deauthenticating from dc:15:c8:12:e8:85 by local choi=
ce (Reason: 3=3DDEAUTH_LEAVING)
[ 6215.638139] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Co=
uldn't get ACK from CSME on HOST_GOES_DOWN message
[ 6215.638250] iwlmei 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: fa=
iled to send the SAP_ME_MSG_CHECK_SHARED_AREA message -19
[ 6216.985516] ACPI: EC: interrupt blocked
[ 6220.116906] ACPI: EC: interrupt unblocked
[ 6220.412349] i2c_hid_acpi i2c-ELAN0672:00: i2c_hid_get_input: incomplete =
report (14/65280)
[ 6220.437632] nvme nvme0: Shutdown timeout set to 10 seconds
[ 6220.439318] nvme nvme0: 8/0/0 default/read/poll queues
[ 6220.694608] OOM killer enabled.
[ 6220.694611] Restarting tasks ...=20
[ 6220.694710] usb 3-3: USB disconnect, device number 7
[ 6220.695734] done.
[ 6220.700829] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[ 6220.706607] thermal thermal_zone7: failed to read out thermal zone (-61)
[ 6220.810825] PM: suspend exit
[ 6220.811417] usb 3-3: new full-speed USB device number 8 using xhci_hcd
[ 6220.940161] usb 3-3: New USB device found, idVendor=3D06cb, idProduct=3D=
00fc, bcdDevice=3D 0.00
[ 6220.940169] usb 3-3: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[ 6220.940172] usb 3-3: SerialNumber: ce8cf4b20507

ah, googling for that message leads to this thread, which seems highly
relevant, and it seems upstream knows about it:
https://www.spinics.net/lists/linux-wireless/msg223249.html

Unfortunately, no resolution in that thread. I=E2=80=99ll try to follow up
there.

Cheers,
Joachim


--=20
Joachim Breitner
  mail@joachim-breitner.de
  http://www.joachim-breitner.de/

