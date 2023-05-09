Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934017FEC
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 16:09:06 +0000 (UTC)
Received: from smtpclient.apple (p4fefc45b.dip0.t-ipconnect.de [79.239.196.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id 181B4CECC7;
	Tue,  9 May 2023 18:09:04 +0200 (CEST)
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
In-Reply-To: <66b05814-cb78-40c7-929b-0e2ffa2027a6@gmail.com>
Date: Tue, 9 May 2023 18:09:03 +0200
Cc: Mike Silva <mike.silva@mikesilva.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <04BED22D-EBF1-47B8-AD51-01DCC2CA4138@holtmann.org>
References: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
 <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
 <4F32B57B-3517-46EA-97F6-2B5DC172B952@holtmann.org>
 <66b05814-cb78-40c7-929b-0e2ffa2027a6@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Hi James,

>>>> Does IWD support disabling/enabling WiFi powersave/power =
management?
>>>=20
>>> No, currently it doesn't.
>>>=20
>>>> Perhaps, I=E2=80=99m failing in finding it in the documentation. =
It=E2=80=99s possible to do this as needed with ifconfig, iwconfig, or =
NetworkManager, or to permanently configure them to enable or disable it =
at boot..
>>>> If IWD doesn=E2=80=99t support this, it would be nice enhancement =
if IWD could when managing the adapter/connection, as some drivers do a =
poor job of handling powersave being on.
>>>=20
>>> Yes, I've recently seen instances of drivers handling this poorly. =
Are you envisioning something like these other tools, where power save =
is just toggled on/off?
>>>=20
>>> I think this could be done, and actually we do this manually every =
boot using iwconfig in the software stack I work with. The tricky part =
is PS is done per-interface and IWD doesn't have any concept of =
per-interface configurations.
>> if anybody uses iwconfig, then the problem is already there. iwconfig
>> is an WEXT tool and deprecated. The driver is broken.
>=20
> It doesn't have much to do with the tool, its just an NL80211 API to =
toggle power save. But yes, the driver is broken if it can't handle this =
properly... but this is the world we live in.
>=20
> The reason I'm interested though is because there is no nice way to =
disable power save "automatically" unless you use NetworkManager. Apart =
from hooking in a script to disable it with iw/iwconfig (which we =
currently do). An option in IWD would be convenient.
>=20
>>> Denis might have preferences on this? but my initial thoughts would =
be something like:
>>>=20
>>> [General.wlan0]
>>> PowerSave=3D{on,off}
>> You can't tie anything to interface names. Then can change and are
>> basically random names. The most you can do is tie it to the phy
>> and its mode of operation.
>=20
> True, it would have to be per-phy. But this too has the same problem =
if its a hotplug device...
>=20
> We do have this concept of driver_flags already, for interface =
removal, but I'm not sure if power save is something that EVERYONE will =
want to disable for a given driver. Maybe it works for some use cases =
but not others.

we already have this:

enum driver_flag {
        DEFAULT_IF =3D 0x1,
        FORCE_PAE =3D 0x2,
};

struct driver_info {
        const char *prefix;
        unsigned int flags;
};

/*
 * The out-of-tree rtl88x2bu crashes the kernel hard if default =
interface is
 * destroyed.  It seems many other drivers are built from the same =
source code
 * so we set the DEFAULT_IF flag for all of them.  Unfortunately there =
are
 * in-tree drivers that also match these names and may be fine.
 */
static const struct driver_info driver_infos[] =3D {
        { "rtl81*",          DEFAULT_IF },
        { "rtl87*",          DEFAULT_IF },
        { "rtl88*",          DEFAULT_IF },
        { "rtw_*",           DEFAULT_IF },
        { "brcmfmac",        DEFAULT_IF },
        { "bcmsdh_sdmmc",    DEFAULT_IF },
};

It is hardcoded and obviously awful as that, but you could add a flag
for power save mode. However I think this needs to move into a =
configuration
file somewhere that can match and flag drivers and/or hardware.

Regards

Marcel

