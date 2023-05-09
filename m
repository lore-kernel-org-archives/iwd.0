Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FA17FE6
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 14:55:03 +0000 (UTC)
Received: from smtpclient.apple (p4fefc45b.dip0.t-ipconnect.de [79.239.196.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id 39EFCCECC7;
	Tue,  9 May 2023 16:55:01 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: powersave support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
Date: Tue, 9 May 2023 16:55:00 +0200
Cc: Mike Silva <mike.silva@mikesilva.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F32B57B-3517-46EA-97F6-2B5DC172B952@holtmann.org>
References: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
 <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Hi James,

>> Does IWD support disabling/enabling WiFi powersave/power management?
>=20
> No, currently it doesn't.
>=20
>> Perhaps, I=E2=80=99m failing in finding it in the documentation. =
It=E2=80=99s possible to do this as needed with ifconfig, iwconfig, or =
NetworkManager, or to permanently configure them to enable or disable it =
at boot..
>> If IWD doesn=E2=80=99t support this, it would be nice enhancement if =
IWD could when managing the adapter/connection, as some drivers do a =
poor job of handling powersave being on.
>=20
> Yes, I've recently seen instances of drivers handling this poorly. Are =
you envisioning something like these other tools, where power save is =
just toggled on/off?
>=20
> I think this could be done, and actually we do this manually every =
boot using iwconfig in the software stack I work with. The tricky part =
is PS is done per-interface and IWD doesn't have any concept of =
per-interface configurations.

if anybody uses iwconfig, then the problem is already there. iwconfig
is an WEXT tool and deprecated. The driver is broken.

> Denis might have preferences on this? but my initial thoughts would be =
something like:
>=20
> [General.wlan0]
> PowerSave=3D{on,off}

You can't tie anything to interface names. Then can change and are
basically random names. The most you can do is tie it to the phy
and its mode of operation.

Regards

Marcel

