Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D91800B
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 16:52:20 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 100FC32003AC;
	Tue,  9 May 2023 12:52:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 May 2023 12:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mikesilva.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1683651139; x=1683737539; bh=1zG8J/QuF0wPYBkvNooeS+BBG
	TjOcHXD0QgMmJ3FQC8=; b=Ag7QXZv2DO1uX8RBpJDEu9oxUis7/GT8fZNhMk7q7
	lK0GHmRLXw1i44TG9VilxXJSW25dPYD5h6UuiSNrmZl3m3TKYRFdeTFYimchvtzR
	nVC6z/0afE0rfuAWavyneLjFdftxPrzJuDNO4d/RYYSU/KlC5PwE9qTJ8vgZvuax
	kK67Ze+vHREfpcyI7Rt+YFBG92BboCWcu5+SZ9/0zVAtNvrrL2e1viqkvORiUEB6
	H4aBWFPlEHTAED/mBvStVs8VKvcudaplbCh63Ka9QZU3cJBS2OKP9yrM0ZPtu4pj
	1yXw4rwCtlHemfvhoAZ0RVhzt0ydrUqDm8ISN1d3twyzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1683651139; x=1683737539; bh=1zG8J/QuF0wPYBkvNooeS+BBGTjOcHXD0Qg
	MmJ3FQC8=; b=Y/s0D3zVbGQatt2HUcQurkM+EVlUc81s1wq5rgBIyY7jkJkTcoG
	JKpbjkeaVCeTR0NlKZrVzh0MRxpLEHa8D0FQ5OKHwIAyiyKV7KrDQ2A7T2bhUlrl
	K0jzvR63xCxTmJRaq69Sked1yuwSACl+OhS+P2y69h2LOLG5KXN8St6pXtmn/CbB
	RtfLtN0hMEJ+isa7FO9A4osLXF9uo5pnHRAQJ7mbDUpvtNsuPaLOqXNw+7H18yX3
	qf/60JEGceKSYZWNpY1wRH55TPs3GOAS2WySF6uKeDX623My50XyrIovDF7ZZnLT
	CVzrW7zXQ/E4mZTRbfW7cZoZG4BUNm5EP9Q==
X-ME-Sender: <xms:Q3paZGTxqED7tie9WwAmPyXOmwp36c8aFz2yGg3eVVd3aK2aaIxnxQ>
    <xme:Q3paZLy79NjgyCRY-qx6bZQWIKy3eL86zP6KIgcligzyV4DXnyqJPj5Hlo6gItjHK
    NoMLs-rXkBnMi5Okao>
X-ME-Received: <xmr:Q3paZD0vj1HHCrVNjvaKxTjoXr7OcDKwOHncdFQ1i6tMNSQhFmAW3cPYtnnNW_wYNEEhKDKQtG8Kys30r7CeNzrWh6BysuMbxzKquML1lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeguddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefoihhk
    vgcuufhilhhvrgcuoehmihhkvgdrshhilhhvrgesmhhikhgvshhilhhvrgdrtghomheqne
    cuggftrfgrthhtvghrnhephedvheefkeejudfhvdeuveehteeuveffleehheeuteeffedv
    teejvdetgeeivedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhhikhgvrdhsihhlvhgrsehmihhkvghsihhlvhgrrdgtohhm
X-ME-Proxy: <xmx:Q3paZCBXhxVFvcdtwcFKVnk0lN9RX_3xpUo5eq9HCNbePdpYVdvpPQ>
    <xmx:Q3paZPicqhAH4_rAxvhYQQaq1kK2RhCKmUp6_YhYPV76oC5mLerNBQ>
    <xmx:Q3paZOpBMqdBjOK5wHeS9fEG5c0dZc7GIAxGgwjoOYWrliHB7g6bwg>
    <xmx:Q3paZHYmhmhr1TJQ3vNHrHnGrATEhDSD7PJMsghaQfCyMhrOQd6tRQ>
Feedback-ID: i3a5446d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 12:52:18 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: powersave support
From: Mike Silva <mike.silva@mikesilva.com>
In-Reply-To: <04BED22D-EBF1-47B8-AD51-01DCC2CA4138@holtmann.org>
Date: Tue, 9 May 2023 09:52:18 -0700
Cc: James Prestwood <prestwoj@gmail.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9382E92-3CC8-48BD-BDB3-2F673F899B85@mikesilva.com>
References: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
 <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
 <4F32B57B-3517-46EA-97F6-2B5DC172B952@holtmann.org>
 <66b05814-cb78-40c7-929b-0e2ffa2027a6@gmail.com>
 <04BED22D-EBF1-47B8-AD51-01DCC2CA4138@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3696.120.41.1.3)



> On May 9, 2023, at 9:09 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>=20
> Hi James,
>=20
>>>>> Does IWD support disabling/enabling WiFi powersave/power =
management?
>>>>=20
>>>> No, currently it doesn't.
>>>>=20
>>>>> Perhaps, I=E2=80=99m failing in finding it in the documentation. =
It=E2=80=99s possible to do this as needed with ifconfig, iwconfig, or =
NetworkManager, or to permanently configure them to enable or disable it =
at boot..
>>>>> If IWD doesn=E2=80=99t support this, it would be nice enhancement =
if IWD could when managing the adapter/connection, as some drivers do a =
poor job of handling powersave being on.
>>>>=20
>>>> Yes, I've recently seen instances of drivers handling this poorly. =
Are you envisioning something like these other tools, where power save =
is just toggled on/off?
>>>>=20
>>>> I think this could be done, and actually we do this manually every =
boot using iwconfig in the software stack I work with. The tricky part =
is PS is done per-interface and IWD doesn't have any concept of =
per-interface configurations.
>>> if anybody uses iwconfig, then the problem is already there. =
iwconfig
>>> is an WEXT tool and deprecated. The driver is broken.
>>=20
>> It doesn't have much to do with the tool, its just an NL80211 API to =
toggle power save. But yes, the driver is broken if it can't handle this =
properly... but this is the world we live in.
>>=20
>> The reason I'm interested though is because there is no nice way to =
disable power save "automatically" unless you use NetworkManager. Apart =
from hooking in a script to disable it with iw/iwconfig (which we =
currently do). An option in IWD would be convenient.
>>=20
>>>> Denis might have preferences on this? but my initial thoughts would =
be something like:
>>>>=20
>>>> [General.wlan0]
>>>> PowerSave=3D{on,off}
>>> You can't tie anything to interface names. Then can change and are
>>> basically random names. The most you can do is tie it to the phy
>>> and its mode of operation.
>>=20
>> True, it would have to be per-phy. But this too has the same problem =
if its a hotplug device...
>>=20
>> We do have this concept of driver_flags already, for interface =
removal, but I'm not sure if power save is something that EVERYONE will =
want to disable for a given driver. Maybe it works for some use cases =
but not others.
>=20
> we already have this:
>=20
> enum driver_flag {
>        DEFAULT_IF =3D 0x1,
>        FORCE_PAE =3D 0x2,
> };
>=20
> struct driver_info {
>        const char *prefix;
>        unsigned int flags;
> };
>=20
> /*
> * The out-of-tree rtl88x2bu crashes the kernel hard if default =
interface is
> * destroyed.  It seems many other drivers are built from the same =
source code
> * so we set the DEFAULT_IF flag for all of them.  Unfortunately there =
are
> * in-tree drivers that also match these names and may be fine.
> */
> static const struct driver_info driver_infos[] =3D {
>        { "rtl81*",          DEFAULT_IF },
>        { "rtl87*",          DEFAULT_IF },
>        { "rtl88*",          DEFAULT_IF },
>        { "rtw_*",           DEFAULT_IF },
>        { "brcmfmac",        DEFAULT_IF },
>        { "bcmsdh_sdmmc",    DEFAULT_IF },
> };
>=20

This is precisely the =E2=80=98Murderers Row=E2=80=99 of bad actors I =
was thinking of, with the addition that in recent times Mediatek =
acquired some chipset IP from Realtek, from which they=E2=80=99ve now =
derived a bunch of their own chipset variants, who all carry the =
powersave issue forward. These chipsets are quite popular on laptops and =
devices sold with Linux, precisely because they hit a sweet spot on =
price/performance=E2=80=A6so long as you don=E2=80=99t want power save =
handled nicely. :-)

That said, judging by the activity in the Mediatek list, those folks are =
actively interested in finding and cleaning up the technical debt =
they=E2=80=99ve inherited.

> It is hardcoded and obviously awful as that, but you could add a flag
> for power save mode. However I think this needs to move into a =
configuration
> file somewhere that can match and flag drivers and/or hardware.
>=20
> Regards
>=20
> Marcel
>=20

