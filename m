Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2957CAC
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522942; cv=none; b=sJO8uitrSk+Ll1dq9vEU0qypo0W2TG1f2rTUS0TrC5WYl8v5iKx953VnUoR9dfcRC4+CuztGXd4f/iOKofV7pd0DRc6iMuDWpFc6m4XeLQLYH6NuGY4OY3S8QUAEnTwvEA/bf8acKo9tnx1pxi1WHefzH+L/GOs3pKL8R+f3WtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522942; c=relaxed/simple;
	bh=1Hk3BCiChDEExzMegPDewo7aYdXc8wvRQVV7TCRVnDk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Hh8V/Sm7Vdkh0wWqor+uJDEksHnUGr4e2dooZfx3+1CMuGKqU2cy3YIdz3P5sOac2axo2YErYzFTUCvKc6AxJX0InSHRQZxEErgaGrOwvLIImMONsZ1m9S8CUYgczIGOw0tlCZGSFCOp4Q9P2XHKGZ0mwzCQXlPeJOIdsRCEgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=DrJXgj9U; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="DrJXgj9U"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4XXJGg1pxnz9vBr;
	Mon, 21 Oct 2024 16:53:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729522427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Bc4AHl3SZ5bPrdfYKme/XuGKseL+0Fvghbw5iBZLiw=;
	b=DrJXgj9UHHiTAZ7ANTKDrxMoGvIQ9YSaUwTwvDO8Hc0zYm56fyw0h6rf8xwnYMAmtcSo4T
	yio2rz7CJkTMtSMF7a6ihfwmeDa/e2U8Ba3bFQHRIvVq4YttZcPxhBS5BYxc9M0NM2n1UI
	YlIbIymfMOj3J9OHMUxZbvRqzYGQe8dHGvaoOgMB/p9bdoUbIU3oJ/B1Si3ZguWU9Wb1Z1
	bNsmrAkWDop/+jgTvsfMKARr2YDlLFK933Ru50t0nSgY4vrvssJowCHKBLJA/6LNxuuBPF
	j4MY3qTCIIERyiP2o4y7PLMsQklm9UxasKWSx/LnYYKlfkDPoB8Kg2HSmqNU3w==
Content-Type: multipart/mixed; boundary="------------4IZdGWP8hHS0yZzwVwXLzy2J"
Message-ID: <aa18ac9b-ae51-4530-8808-c723c383e3ea@tavla.de>
Date: Mon, 21 Oct 2024 16:53:45 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>

This is a multi-part message in MIME format.
--------------4IZdGWP8hHS0yZzwVwXLzy2J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Arend,

Am 21.10.24 um 16:40 schrieb Arend Van Spriel:
> On October 21, 2024 3:34:46 PM Martin Petzold 
> <martin.petzold@tavla.de> wrote:
>
>> Hi Denis,
>>
>> Am 19.10.24 um 16:41 schrieb Denis Kenzior:
>>>
>>>>
>>>> This is a more or less common setup for embedded environments. Would
>>>> be glad if you could double-check if this could cause wrong initial
>>>> connection (weaker AP).
>>>
>>> We can't help you unless you provide logs.
>>
>> We are now in an enterprise grade Cisco roaming environment. Initial
>> connection to the (open) network was possible and routable with
>> connection to our servers (!). However after like an hour or so the
>> connection was lost. And then re-connection was NOT possible (both
>> autoconnect and also not manual connect via iwctl fail).
>>
>> Please find attached the log output: logfile_tavla.txt (with brcm and
>
> The log output is not hard to read. The brcmfmac indicates it does not 
> support the requested akm suite 00-0F-AC:12 (Suite B 192b).
>
> What capabilities does iw command show for the wifi device? Maybe the 
> driver announces something which the firmware does not support.

Please find attached the capabilities.

Best regards,

Martin

>
> Regards,
> Arend
>> iwd - no debug) and logfile_tavla_debug.txt (iwd with debug and manual
>> re-connect attempt).
>>
>> I have now enabled "--debug" and it would also be possible to remove the
>> network and do another full reproduction with initial connection.
>>
>> SETUP:
>>
>> SoM: Variscite DART-IMX8M-PLUS
>> SoC: NXP i.MX8M Plus
>> Wi-Fi Chip: Laird Sterling LWB5 (Infineon CYW43353)
>> Antenna: Laird FlexPIFA
>> RootFS: Debian bookworm
>> Kernel: NXP Kernel 6.1.36 (with Variscite patches)
>> Driver: brcmfmac (from Kernel, only minor patches - device tree)
>> Firmware: Laird 12.29.0.22 (loaded via scripts)
>> Network Daemon: systemd-networkd 252.30
>> Wi-Fi Daemon: IWD 2.22+ (c459dc75c080dcbff6f9b9389344e11328dec411) + ELL
>> 0.69 (7bed251f8020ef896043f008276f41cd13fdd43f)
>>
>> KERNEL:
>>
>> REPOSITORY=https://github.com/tavla/linux-imx.git (fork from
>> https://github.com/varigit/linux-imx)
>> BRANCH=lf-6.1.y_var03
>> COMMIT=a4b3cc1dbbb396284e501b938aa79d2dfd4f1a98
>>
>> FIRMWARE:
>>
>> summit-lwb5-etsi-firmware-12.29.0.22.tar.bz2
>>
>> From:
>> https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/ 
>>
>
>
>
-- 
Martin Petzold (Inhaber & Geschäftsführer)

TAVLA Technology GmbH
Im Dau 14
50678 Köln
Deutschland

Telefon: +49 (0)221 / 3466 0885
Mobil: +49 (0)179 / 9220154
E-Mail: martin.petzold@tavla.de

--------------4IZdGWP8hHS0yZzwVwXLzy2J
Content-Type: text/plain; charset=UTF-8; name="capabilities.txt"
Content-Disposition: attachment; filename="capabilities.txt"
Content-Transfer-Encoding: base64

dGF2bGFAdGF2bGE6fiQgc3VkbyBpdyBsaXN0CldpcGh5IHBoeTAKCXdpcGh5IGluZGV4OiAw
CgltYXggIyBzY2FuIFNTSURzOiAxMAoJbWF4IHNjYW4gSUVzIGxlbmd0aDogMjA0OCBieXRl
cwoJbWF4ICMgc2NoZWQgc2NhbiBTU0lEczogMTYKCW1heCAjIG1hdGNoIHNldHM6IDE2CglS
ZXRyeSBzaG9ydCBsaW1pdDogNwoJUmV0cnkgbG9uZyBsaW1pdDogNAoJQ292ZXJhZ2UgY2xh
c3M6IDAgKHVwIHRvIDBtKQoJRGV2aWNlIHN1cHBvcnRzIHJvYW1pbmcuCglTdXBwb3J0ZWQg
Q2lwaGVyczoKCQkqIFdFUDQwICgwMC0wZi1hYzoxKQoJCSogV0VQMTA0ICgwMC0wZi1hYzo1
KQoJCSogVEtJUCAoMDAtMGYtYWM6MikKCQkqIENDTVAtMTI4ICgwMC0wZi1hYzo0KQoJCSog
Q01BQyAoMDAtMGYtYWM6NikKCUF2YWlsYWJsZSBBbnRlbm5hczogVFggMCBSWCAwCglTdXBw
b3J0ZWQgaW50ZXJmYWNlIG1vZGVzOgoJCSAqIElCU1MKCQkgKiBtYW5hZ2VkCgkJICogQVAK
CQkgKiBQMlAtY2xpZW50CgkJICogUDJQLUdPCgkJICogUDJQLWRldmljZQoJQmFuZCAxOgoJ
CUNhcGFiaWxpdGllczogMHgxMDIyCgkJCUhUMjAvSFQ0MAoJCQlTdGF0aWMgU00gUG93ZXIg
U2F2ZQoJCQlSWCBIVDIwIFNHSQoJCQlObyBSWCBTVEJDCgkJCU1heCBBTVNEVSBsZW5ndGg6
IDM4MzkgYnl0ZXMKCQkJRFNTUy9DQ0sgSFQ0MAoJCU1heGltdW0gUlggQU1QRFUgbGVuZ3Ro
IDY1NTM1IGJ5dGVzIChleHBvbmVudDogMHgwMDMpCgkJTWluaW11bSBSWCBBTVBEVSB0aW1l
IHNwYWNpbmc6IDE2IHVzZWMgKDB4MDcpCgkJSFQgVFgvUlggTUNTIHJhdGUgaW5kZXhlcyBz
dXBwb3J0ZWQ6IDAtNwoJCUJpdHJhdGVzIChub24tSFQpOgoJCQkqIDEuMCBNYnBzCgkJCSog
Mi4wIE1icHMgKHNob3J0IHByZWFtYmxlIHN1cHBvcnRlZCkKCQkJKiA1LjUgTWJwcyAoc2hv
cnQgcHJlYW1ibGUgc3VwcG9ydGVkKQoJCQkqIDExLjAgTWJwcyAoc2hvcnQgcHJlYW1ibGUg
c3VwcG9ydGVkKQoJCQkqIDYuMCBNYnBzCgkJCSogOS4wIE1icHMKCQkJKiAxMi4wIE1icHMK
CQkJKiAxOC4wIE1icHMKCQkJKiAyNC4wIE1icHMKCQkJKiAzNi4wIE1icHMKCQkJKiA0OC4w
IE1icHMKCQkJKiA1NC4wIE1icHMKCQlGcmVxdWVuY2llczoKCQkJKiAyNDEyIE1IeiBbMV0g
KDIwLjAgZEJtKQoJCQkqIDI0MTcgTUh6IFsyXSAoMjAuMCBkQm0pCgkJCSogMjQyMiBNSHog
WzNdICgyMC4wIGRCbSkKCQkJKiAyNDI3IE1IeiBbNF0gKDIwLjAgZEJtKQoJCQkqIDI0MzIg
TUh6IFs1XSAoMjAuMCBkQm0pCgkJCSogMjQzNyBNSHogWzZdICgyMC4wIGRCbSkKCQkJKiAy
NDQyIE1IeiBbN10gKDIwLjAgZEJtKQoJCQkqIDI0NDcgTUh6IFs4XSAoMjAuMCBkQm0pCgkJ
CSogMjQ1MiBNSHogWzldICgyMC4wIGRCbSkKCQkJKiAyNDU3IE1IeiBbMTBdICgyMC4wIGRC
bSkKCQkJKiAyNDYyIE1IeiBbMTFdICgyMC4wIGRCbSkKCQkJKiAyNDY3IE1IeiBbMTJdICgy
MC4wIGRCbSkKCQkJKiAyNDcyIE1IeiBbMTNdICgyMC4wIGRCbSkKCQkJKiAyNDg0IE1IeiBb
MTRdICgyMC4wIGRCbSkKCUJhbmQgMjoKCQlDYXBhYmlsaXRpZXM6IDB4MTA2MgoJCQlIVDIw
L0hUNDAKCQkJU3RhdGljIFNNIFBvd2VyIFNhdmUKCQkJUlggSFQyMCBTR0kKCQkJUlggSFQ0
MCBTR0kKCQkJTm8gUlggU1RCQwoJCQlNYXggQU1TRFUgbGVuZ3RoOiAzODM5IGJ5dGVzCgkJ
CURTU1MvQ0NLIEhUNDAKCQlNYXhpbXVtIFJYIEFNUERVIGxlbmd0aCA2NTUzNSBieXRlcyAo
ZXhwb25lbnQ6IDB4MDAzKQoJCU1pbmltdW0gUlggQU1QRFUgdGltZSBzcGFjaW5nOiAxNiB1
c2VjICgweDA3KQoJCUhUIFRYL1JYIE1DUyByYXRlIGluZGV4ZXMgc3VwcG9ydGVkOiAwLTcK
CQlWSFQgQ2FwYWJpbGl0aWVzICgweDAwMDAxODIwKToKCQkJTWF4IE1QRFUgbGVuZ3RoOiAz
ODk1CgkJCVN1cHBvcnRlZCBDaGFubmVsIFdpZHRoOiBuZWl0aGVyIDE2MCBub3IgODArODAK
CQkJc2hvcnQgR0kgKDgwIE1IeikKCQkJU1UgQmVhbWZvcm1lcgoJCQlTVSBCZWFtZm9ybWVl
CgkJVkhUIFJYIE1DUyBzZXQ6CgkJCTEgc3RyZWFtczogTUNTIDAtOQoJCQkyIHN0cmVhbXM6
IG5vdCBzdXBwb3J0ZWQKCQkJMyBzdHJlYW1zOiBub3Qgc3VwcG9ydGVkCgkJCTQgc3RyZWFt
czogbm90IHN1cHBvcnRlZAoJCQk1IHN0cmVhbXM6IG5vdCBzdXBwb3J0ZWQKCQkJNiBzdHJl
YW1zOiBub3Qgc3VwcG9ydGVkCgkJCTcgc3RyZWFtczogbm90IHN1cHBvcnRlZAoJCQk4IHN0
cmVhbXM6IG5vdCBzdXBwb3J0ZWQKCQlWSFQgUlggaGlnaGVzdCBzdXBwb3J0ZWQ6IDAgTWJw
cwoJCVZIVCBUWCBNQ1Mgc2V0OgoJCQkxIHN0cmVhbXM6IE1DUyAwLTkKCQkJMiBzdHJlYW1z
OiBub3Qgc3VwcG9ydGVkCgkJCTMgc3RyZWFtczogbm90IHN1cHBvcnRlZAoJCQk0IHN0cmVh
bXM6IG5vdCBzdXBwb3J0ZWQKCQkJNSBzdHJlYW1zOiBub3Qgc3VwcG9ydGVkCgkJCTYgc3Ry
ZWFtczogbm90IHN1cHBvcnRlZAoJCQk3IHN0cmVhbXM6IG5vdCBzdXBwb3J0ZWQKCQkJOCBz
dHJlYW1zOiBub3Qgc3VwcG9ydGVkCgkJVkhUIFRYIGhpZ2hlc3Qgc3VwcG9ydGVkOiAwIE1i
cHMKCQlWSFQgZXh0ZW5kZWQgTlNTOiBub3Qgc3VwcG9ydGVkCgkJQml0cmF0ZXMgKG5vbi1I
VCk6CgkJCSogNi4wIE1icHMKCQkJKiA5LjAgTWJwcwoJCQkqIDEyLjAgTWJwcwoJCQkqIDE4
LjAgTWJwcwoJCQkqIDI0LjAgTWJwcwoJCQkqIDM2LjAgTWJwcwoJCQkqIDQ4LjAgTWJwcwoJ
CQkqIDU0LjAgTWJwcwoJCUZyZXF1ZW5jaWVzOgoJCQkqIDUxNzAgTUh6IFszNF0gKDIwLjAg
ZEJtKQoJCQkqIDUxODAgTUh6IFszNl0gKDIwLjAgZEJtKQoJCQkqIDUxOTAgTUh6IFszOF0g
KDIwLjAgZEJtKQoJCQkqIDUyMDAgTUh6IFs0MF0gKDIwLjAgZEJtKQoJCQkqIDUyMTAgTUh6
IFs0Ml0gKDIwLjAgZEJtKQoJCQkqIDUyMjAgTUh6IFs0NF0gKDIwLjAgZEJtKQoJCQkqIDUy
MzAgTUh6IFs0Nl0gKDIwLjAgZEJtKQoJCQkqIDUyNDAgTUh6IFs0OF0gKDIwLjAgZEJtKQoJ
CQkqIDUyNjAgTUh6IFs1Ml0gKDIwLjAgZEJtKQoJCQkqIDUyODAgTUh6IFs1Nl0gKDIwLjAg
ZEJtKQoJCQkqIDUzMDAgTUh6IFs2MF0gKDIwLjAgZEJtKQoJCQkqIDUzMjAgTUh6IFs2NF0g
KDIwLjAgZEJtKQoJCQkqIDU1MDAgTUh6IFsxMDBdICgyMC4wIGRCbSkKCQkJKiA1NTIwIE1I
eiBbMTA0XSAoMjAuMCBkQm0pCgkJCSogNTU0MCBNSHogWzEwOF0gKDIwLjAgZEJtKQoJCQkq
IDU1NjAgTUh6IFsxMTJdICgyMC4wIGRCbSkKCQkJKiA1NTgwIE1IeiBbMTE2XSAoMjAuMCBk
Qm0pCgkJCSogNTYwMCBNSHogWzEyMF0gKDIwLjAgZEJtKQoJCQkqIDU2MjAgTUh6IFsxMjRd
ICgyMC4wIGRCbSkKCQkJKiA1NjQwIE1IeiBbMTI4XSAoMjAuMCBkQm0pCgkJCSogNTY2MCBN
SHogWzEzMl0gKDIwLjAgZEJtKQoJCQkqIDU2ODAgTUh6IFsxMzZdICgyMC4wIGRCbSkKCQkJ
KiA1NzAwIE1IeiBbMTQwXSAoMjAuMCBkQm0pCgkJCSogNTcyMCBNSHogWzE0NF0gKDIwLjAg
ZEJtKQoJCQkqIDU3NDUgTUh6IFsxNDldICgyMC4wIGRCbSkKCQkJKiA1NzY1IE1IeiBbMTUz
XSAoMjAuMCBkQm0pCgkJCSogNTc4NSBNSHogWzE1N10gKDIwLjAgZEJtKQoJCQkqIDU4MDUg
TUh6IFsxNjFdICgyMC4wIGRCbSkKCQkJKiA1ODI1IE1IeiBbMTY1XSAoMjAuMCBkQm0pCglT
dXBwb3J0ZWQgY29tbWFuZHM6CgkJICogbmV3X2ludGVyZmFjZQoJCSAqIHNldF9pbnRlcmZh
Y2UKCQkgKiBuZXdfa2V5CgkJICogc3RhcnRfYXAKCQkgKiBqb2luX2lic3MKCQkgKiBzZXRf
cG1rc2EKCQkgKiBkZWxfcG1rc2EKCQkgKiBmbHVzaF9wbWtzYQoJCSAqIHJlbWFpbl9vbl9j
aGFubmVsCgkJICogZnJhbWUKCQkgKiBzZXRfd2lwaHlfbmV0bnMKCQkgKiBzZXRfY2hhbm5l
bAoJCSAqIHN0YXJ0X3NjaGVkX3NjYW4KCQkgKiBzdGFydF9wMnBfZGV2aWNlCgkJICogY29u
bmVjdAoJCSAqIGRpc2Nvbm5lY3QKCQkgKiBjcml0X3Byb3RvY29sX3N0YXJ0CgkJICogY3Jp
dF9wcm90b2NvbF9zdG9wCgkJICogdXBkYXRlX2Nvbm5lY3RfcGFyYW1zCglzb2Z0d2FyZSBp
bnRlcmZhY2UgbW9kZXMgKGNhbiBhbHdheXMgYmUgYWRkZWQpOgoJdmFsaWQgaW50ZXJmYWNl
IGNvbWJpbmF0aW9uczoKCQkgKiAjeyBtYW5hZ2VkIH0gPD0gMSwgI3sgUDJQLWRldmljZSB9
IDw9IDEsICN7IFAyUC1jbGllbnQsIFAyUC1HTyB9IDw9IDEsCgkJICAgdG90YWwgPD0gMywg
I2NoYW5uZWxzIDw9IDIKCQkgKiAjeyBtYW5hZ2VkIH0gPD0gMSwgI3sgQVAgfSA8PSAxLCAj
eyBQMlAtY2xpZW50IH0gPD0gMSwgI3sgUDJQLWRldmljZSB9IDw9IDEsCgkJICAgdG90YWwg
PD0gNCwgI2NoYW5uZWxzIDw9IDEKCURldmljZSBzdXBwb3J0cyBzY2FuIGZsdXNoLgoJbWF4
ICMgc2NhbiBwbGFuczogMQoJbWF4IHNjYW4gcGxhbiBpbnRlcnZhbDogNTA4CgltYXggc2Nh
biBwbGFuIGl0ZXJhdGlvbnM6IDAKCVN1cHBvcnRlZCBUWCBmcmFtZSB0eXBlczoKCQkgKiBt
YW5hZ2VkOiAweDAwIDB4MTAgMHgyMCAweDMwIDB4NDAgMHg1MCAweDYwIDB4NzAgMHg4MCAw
eDkwIDB4YTAgMHhiMCAweGMwIDB4ZDAgMHhlMCAweGYwCgkJICogQVA6IDB4MDAgMHgxMCAw
eDIwIDB4MzAgMHg0MCAweDUwIDB4NjAgMHg3MCAweDgwIDB4OTAgMHhhMCAweGIwIDB4YzAg
MHhkMCAweGUwIDB4ZjAKCQkgKiBQMlAtY2xpZW50OiAweDAwIDB4MTAgMHgyMCAweDMwIDB4
NDAgMHg1MCAweDYwIDB4NzAgMHg4MCAweDkwIDB4YTAgMHhiMCAweGMwIDB4ZDAgMHhlMCAw
eGYwCgkJICogUDJQLUdPOiAweDAwIDB4MTAgMHgyMCAweDMwIDB4NDAgMHg1MCAweDYwIDB4
NzAgMHg4MCAweDkwIDB4YTAgMHhiMCAweGMwIDB4ZDAgMHhlMCAweGYwCgkJICogUDJQLWRl
dmljZTogMHgwMCAweDEwIDB4MjAgMHgzMCAweDQwIDB4NTAgMHg2MCAweDcwIDB4ODAgMHg5
MCAweGEwIDB4YjAgMHhjMCAweGQwIDB4ZTAgMHhmMAoJU3VwcG9ydGVkIFJYIGZyYW1lIHR5
cGVzOgoJCSAqIG1hbmFnZWQ6IDB4NDAgMHhkMAoJCSAqIEFQOiAweDAwIDB4MjAgMHg0MCAw
eGEwIDB4YjAgMHhjMCAweGQwCgkJICogUDJQLWNsaWVudDogMHg0MCAweGQwCgkJICogUDJQ
LUdPOiAweDAwIDB4MjAgMHg0MCAweGEwIDB4YjAgMHhjMCAweGQwCgkJICogUDJQLWRldmlj
ZTogMHg0MCAweGQwCglTdXBwb3J0ZWQgZXh0ZW5kZWQgZmVhdHVyZXM6CgkJKiBbIENRTV9S
U1NJX0xJU1QgXTogbXVsdGlwbGUgQ1FNX1JTU0lfVEhPTEQgcmVjb3JkcwoJCSogWyBERlNf
T0ZGTE9BRCBdOiBERlMgb2ZmbG9hZAo=

--------------4IZdGWP8hHS0yZzwVwXLzy2J--
