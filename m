Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2025256
	for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="uIYiAh1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704886389; x=1705491189; i=fiona.klute@gmx.de;
	bh=FmlyElvnMJZasSTCHXno0h9uVlyBtTGyiRrmh/UIFBs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=uIYiAh1IKvr2cwVKT9afemPYQ+6aYUiFpkOUNhTlQVJIcLa+Mn7VQtQAMJvJ9+YG
	 nKD6kRtQND/orrlDQQZPjbOpbY2QBGkFXHg7rg3cG7f7xDSrUeGDFx2hPk2AMSXoj
	 0xX0EvJRjcs+UJPUh0YqViBjKNd6rAZw1WaU/WhpTSCyL/PV2drnyGMY93F5B0wrh
	 xKvz13LR2kqj73GRwL1H/9VaEx9dtO2LHk3k+S6qAYPw55E/iBwi9X0kZKQcZiBFE
	 QVMxl+3ZuJ29//fxyLaWU2S4lRSLh+OrB4Xv5VR/N/rcuafdjYJ3EP0YvyzLxQCxq
	 6G4k9xrZkpXeOdfBIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.23.182]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7Jza-1rFrK525fg-007jJk; Wed, 10
 Jan 2024 12:33:09 +0100
Message-ID: <755dc5bf-1ac7-4eeb-ab16-8ded3aa6a25f@gmx.de>
Date: Wed, 10 Jan 2024 12:33:08 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Log falling back from SAE to WPA2
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240109095926.1541238-1-fiona.klute@gmx.de>
 <214422a4-25bc-4676-8a4a-8bf8d67c7ab9@gmail.com>
Content-Language: de-DE, en-US
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <214422a4-25bc-4676-8a4a-8bf8d67c7ab9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D9+osict9pH9XcFVM9fsHOxsGhkD4S0/xxv8rEEITuxqyAXjx+B
 ZhU6X5DsjJnJWVL1u5qd9ZbCtwyC1uYHJyhgRnniPjgCkbbWxBfY/Fi3Vo/TQ5g0ekTlDVu
 vVjw8/kLhBKK2J6HwLc0WNT5x3E8u1CsbIAQ22rjxVeRI0gXye3riRPy9deT48p1Y+cVyQv
 nAoxjYadNGW5X57buZPFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o2zZI9ll5MY=;LaKtR8EwhFNeGFa4nt2/PK7sK3j
 6tR3ag5ktvZM7M2+9C2TVKd4GflrrZPWOyw8JYcfyyhR92Gzw3xHgr3Eu00vGQwPzVNWSBp08
 G3JOXGYLaJMU44f4HiXeN2Neg5k31vNv/0db9EaAmJrmfMPCkq2oVya8K1dBG1bRBsU1g4PeF
 KtKEmXZvDmuAdxUiaQFkp8oNrm+0TYRr6+4aBLEfaWHBRihLHNz0j1NdA5w/h4cS6D7HeMrkT
 sQStRlQuwcNmHgUZ3+0fJPRdhChsmhA6P2x29EQ8y6VBhQn0FFvl/vIRyb8HiKfIUdPpq6H2B
 J4P9N1ncqqsLqghyl6z7I8TpgafWBUCMPyLvS/o6Gb6O434sGkQHoghXCjcFO9GI2ssV5MzU3
 JpIc4mU7FXm5LMH13H0w2F5GF45cdVUjFkPAoJfH51JIx1TiVLDVe3ulnqMbSUoYIbtivRmn3
 rRHuDcIyjrsxS1RGkn6dOR34VvpH6e7L/rqruEpzGng0MMpMb46eLqSgXgoji+sOrVm3SwKQL
 q9rmzyoK0eZPuVe7yuRn/wYRsNhfExnfsl/NVGCTb61D1ZZDJpFj4qmVTa4XanLxSIL+mkQWO
 pdO2yILA92Vb5iqcXrIF+kPLzrQhNkzcBJ69+YhXupig9DZUoKXhGAOZ6WB16YsE/NZqDomRz
 fN0qrhXwxCDG0rKhheRaLvVZX8UVzJ2EZij9QbkpUjVoPzleEquCxIW/IhPditmybTGqMcb1w
 TdB9s0tSmKt/9/P18itShWVysgMef1Ua/Ihz/hCVNwugW9oSYhFOxUUopLpHXk1uQr5W2I6GR
 uoVK8WW8Kx3Gxv2GkOBes+kudIvuE6dKK1pDp7KIyQeVqjqiha/cOmkFGukkykaxkOqUmlOWT
 W2NpGqsEjKKKUq8zDmVtTPSqx5wg2iagxC/UdVh4yTvRYpLIaIjP8ztLgJQVbzRws8qpSgdf9
 qV7FAnQAJfrKCHrz20O8rJW0WiE=

Hi Denis,

thanks for accepting the patch!

Am 10.01.24 um 04:33 schrieb Denis Kenzior:
> Interesting.=C2=A0 Last time I checked only the quantenna driver used th=
is
> feature and it wasn't very common.=C2=A0 If it isn't a secret, what card=
 /
> driver do you have?

It's the RTL8723CS chip used in Pinephone, the rtl8723cs driver
unfortunately still isn't in mainline. You can find it in the staging
directory of megi's tree:
https://codeberg.org/megi/linux/src/commit/f45c45abc5325682d06cb51c06aba1f=
817fba462/drivers/staging/rtl8723cs

I suspect getting the chip properly supported in mainline would be the
best way to get SAE working. If you have hints on how to get involved in
that I'm curious, so far my wireless driver experience is limited to
"add USB ID for a new device with already supported chip". ;-)

> There's currently no way to force WPA3-only in iwd.=C2=A0 Either configu=
re
> the AP to be WPA3 only, or have the AP enforce transition-disable bit.
> But this typically requires iwd to connect at least once with WPA3.=C2=
=A0 See
> 'TransitionDisable' and 'DisabledTransitionModes' in man 5 iwd.network

Good point, it should be a task for NetworkManager to make that clear to
the user (and possibly set those options, if the user wants to enforce
WPA3-only).

>> ---
>> =C2=A0 src/wiphy.c | 6 +++++-
>> =C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/wiphy.c b/src/wiphy.c
>> index 766df348..5530e9c6 100644
>> --- a/src/wiphy.c
>> +++ b/src/wiphy.c
>> @@ -248,6 +248,8 @@ static bool wiphy_can_connect_sae(struct wiphy
>> *wiphy)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * TODO: No=
 support for CMD_EXTERNAL_AUTH yet.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_debug("Unsupported: %s ne=
eds CMD_EXTERNAL_AUTH for SAE",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wip=
hy->driver_str);
>
> I flipped this around and made this statement an l_warn to make it
> clearer that this is an iwd limitation.

Makes sense. :-)

Best regards,
Fiona

