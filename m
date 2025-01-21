Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF211F3D44
	for <iwd@lists.linux.dev>; Tue, 21 Jan 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469464; cv=none; b=f5BPg9Ci+tJWB4iqfBOR2ybvdaNgBokWkzwRjTSuEPhGKS8RaOWd/IQnMaUSWAjApflLzc2OC/WMJ+AQ6gAgHW/Ogv+tSqM5NTsOrqBHyTGH/NsMCJRr42EKLb4DhrcRkrQwF/la+rhGZehkC7qlPl1hc5d8WYmZKw+dMXf3bCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469464; c=relaxed/simple;
	bh=kz+nR2AuDYrSl2V8UAYHWRrZU6DmiizHCKcdZ4wKBtM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fIWPLwZiRzOffYr+z2Ze1nf5uOdNpamzWoDXZMzZwSxiyWKW2HzK6Aca1Uzatdmk1fv/2cYey+sW/TspVQPyHAUcHkC39f2V47EPtEZqFhjPgO8dxVefHvegXIybs2D7gNeBFvtkmuGioL2xNZjvBwqts7Fs+H/o+UEp8zFY+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gElqSDG3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gElqSDG3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3863494591bso3112851f8f.1
        for <iwd@lists.linux.dev>; Tue, 21 Jan 2025 06:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737469460; x=1738074260; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6H4et8gzlxk8ducQlqF7v5PlAc0tCblnmZ4/THc4uw=;
        b=gElqSDG39XVlkrpkjQ1Qa83cMNrZPWkL+EqUd+RCkvt8IPAqlvlb1asehUSEzSIy9A
         u8W6ScVX9w07ME0NjZo1Wfo60IUzGWKysAjKMyR4Bud4LNKKfTvpNj4Tqt1CRxAz8NGo
         SPIifZlIUPfRJC7Gp6nogfdbdnfnT4SgRiku+VFOSDVXm9juQhlohFztAUfU9wjyWHa7
         N5BFjX29HY/fnif5h3r/feClT2Bov/Uv3xMAxv6xBlVfKvu6PaolWcpREX7UmHuhW33b
         Q/WfZRl0dRMlp1JQLV+JT5ebFMoxaaGjMCUP6YaUKQNITCfHLr9zdGgu9hmNxQYW8RzP
         s67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469460; x=1738074260;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6H4et8gzlxk8ducQlqF7v5PlAc0tCblnmZ4/THc4uw=;
        b=O3FmwLbxZlmow8i5rSl5Mdm66Tg0y+ygT0JFmaxpx3BEUcUHxf+2JLUJwqmIQL5I67
         9WigvPLyTlFkVqa1qSVLp5uJh5u4gdg9VHX4Is+rOfk+HsXJd9RKj03Awk4r4QMy+aq9
         HsGBa2+YsucwH4pHWUleY+C6auFpCMjC/WvqbVBjzlaYaueN7R7JyuhjFfXywzHAZjoY
         i2wuyCTV20qHuaHyQ/X43Hk5h6nvWTg42LvlJCiB1NKCDBdLIQIkWEhNhSjFjYo2pVDU
         j+ElGDoyBr65DtLwWyFNN/OdToDZou2uXFj2IJjEyo/ELUbO6GjRNyR8a5Nsa7wCj3iA
         amjA==
X-Forwarded-Encrypted: i=1; AJvYcCVsthbSojeohh1O/3H6ma50poQdkHlD6hAer9uhSk4O9vP0hUoU56CYOZ7io8ncmqncpMk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxlbb/aaNDHdHsGjae2Ozbh79nvoQiybnln1KueDtMo37YidGZi
	uD5xobgrqofTz3um+fDJeZ3IF5ppIa/i001OOvQRIJvTv1IDILlO
X-Gm-Gg: ASbGnctTLRcEdaL2Ap2HjXPAlFBuBGNY/LJ3DchFlLalqr6rBvknV/wG5rMzdJAtG2v
	XgIMYe92eSDPvuCF4OJVzNb0x5T9lqQBR2dvhqZyHEg9cTcJOgPLjcisgglWw9B4OXyyKtzS+XQ
	HKX1frCpRzm541qYDQdF1zJYu0pxVRga+mSXKY2jbgy4m+nqgDIuqGvMdRZ/yGTrAYWPsqeVBLZ
	HO6PTJJF1aGfUAoYxGueySVKuqAzEQZP3RRnWdbc433mOsfzYSnjOqJJxYYqUXW6YIQjVfjEdwb
	msYaI44X1ED+OkKO
X-Google-Smtp-Source: AGHT+IGjSq0rEDLt7EJEJS2StrkUk88dZlf5ATAFDIBjU4/frfGgAkV8tmyN1nOIBZoZpT1Kd8qP7w==
X-Received: by 2002:a05:6000:2ce:b0:38a:a117:3da1 with SMTP id ffacd0b85a97d-38bf566e683mr14187310f8f.5.1737469460343;
        Tue, 21 Jan 2025 06:24:20 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322ab42sm13248178f8f.44.2025.01.21.06.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2025 06:24:20 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: How to triage an "Invalid Key" error message?
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <ba94e034-df99-41c8-8da6-3ddaa3fb1f66@gmail.com>
Date: Tue, 21 Jan 2025 18:24:07 +0400
Cc: KeithG <ys3al35l@gmail.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <87E0B927-2A75-4737-9D45-B3E8809B2E43@gmail.com>
References: <345AE010-CAD8-4A38-BAE1-3BCD4930414C@gmail.com>
 <60c1b2cf-95be-4a4b-9195-f141adf45a6c@gmail.com>
 <CAG17S_NS18ubECyF0sz0AmtFq3wufjTVjQV2QpWLxCqV8ei1UA@mail.gmail.com>
 <578421A3-35DA-431A-9319-96D847AA4CB2@gmail.com>
 <ba94e034-df99-41c8-8da6-3ddaa3fb1f66@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)

> On 21 Jan 2025, at 5:50=E2=80=AFpm, James Prestwood =
<prestwoj@gmail.com> wrote:
>=20
> Hi Christian,
>=20
> On 1/20/25 7:36 AM, Christian Hewitt wrote:
>>> On 18 Jan 2025, at 8:38=E2=80=AFpm, KeithG <ys3al35l@gmail.com> =
wrote:
>>>=20
>>> Christian,
>>>=20
>>> Is this, perhaps, on devices with the brcmfmac chip? I have seen =
this
>>> recently with on my Pis with wpa2 and wpa3 APs.
>> The majority of reports are from RPi 4/5 users which have brcmfmac
>> chips, but 85% of our distro installed base runs an RPi board so
>> that mostly reflects our demographics. I=E2=80=99ve also seen reports =
on
>> Amlogic and Rockchip SoC devices (also using brcmfmac); but to
>> offset theories on it being brcmfmac specific, we=E2=80=99ve also had
>> reports from users with Intel iwlwifi hardware and someone using
>> an RTL8723BS chip. So it=E2=80=99s more likely to be an interaction =
with
>> common code not driver code.
>>=20
>> At one point we suspected an issue with WPA3, but that was triaged
>> with RPi developers and we now disable SAE offload which allows
>> boards to connect to mixed WPA2/WPA3 networks, see:
>>=20
>> https://forum.libreelec.tv/thread/29155-rpi5-network-disappeared
>> https://github.com/LibreELEC/LibreELEC.tv/pull/9477/files
>>=20
>> In the following forum and GitHub issue threads. There=E2=80=99s lots =
of
>> assumptions, guesswork, and false conclusions, but among the noise
>> there are some snippets of iwd debug log:
>>=20
>> https://github.com/LibreELEC/LibreELEC.tv/issues/7166
>=20
> This one actually has some iwmon logs. Looks like the kernel is =
sending a failure within ~100ms of the connection which is odd. IWD =
waits for a successful connect event before starting the 4-way handshake =
so its not even getting to that point:
>=20
> < Request: Connect (0x2e) len 172 [ack]                                =
5.644853
> ...
> > Event: Connect (0x2e) len 36                                         =
5.735838
>     Wiphy: 0 (0x00000000)
>     Interface Index: 3 (0x00000003)
>     MAC Address 00:00:00:00:00:00
>     Status Code: 16 (0x0010)
>=20
> There is also a core dump attached, but the back trace isn't of much =
use.
>=20
>> https://github.com/LibreELEC/LibreELEC.tv/issues/8731
>=20
> This issue _appears_ as if wpa_supplicant is also running along side =
IWD. That is generally why you see this log:
>=20
> Mar 16 21:10:35 pineh64-b iwd[1046]: Unexpected connection related =
event -- is another supplicant running?

100% guaranteed wpa is not installed at the same time. LibreELEC has =
embedded style packaging with a read-only filesystem and no package =
manager. The iwd/wpa selection is baked into the image at distro image =
creation time and can=E2=80=99t be changed afterwards.

>> https://github.com/LibreELEC/LibreELEC.tv/issues/8760
> This seems the same as #7166.
>> https://github.com/LibreELEC/LibreELEC.tv/issues/8762
> Not a whole lot in here, but apparently resolved.
>>=20
>> I=E2=80=99ll need to rig a distro image for greater debug (as per =
James=E2=80=99
>> instructions) to see if we can obtain more log output.
>>=20
>> Christian
>>=20
> So overall the "invalid-key" issue seems to be due to brcmfmac =
signalling a failure very early on. In a perfect world it would be great =
if we could capture debug/iwmon logs of both IWD trying to connect and =
wpa_supplicant, so we can compare the iwmon logs and see what each =
supplicant is sending to the kernel. The messages _looked_ ok from IWD =
but if wpa_supplicant works fine there is obviously a difference =
somewhere. As Keith knows, brcmfmac is kinda a pain to support as its =
the odd-ball as far as drivers go. IWD doesn't get much contributions =
from wifi vendors so any odd quirks only get solved by trial and error.

It=E2=80=99s been seen on other chips too, but if it=E2=80=99s timing =
related it could simply be that brcmfmac trips the issue more frequently =
and that plus distro demographics skews the volume of reports.

I=E2=80=99ll prepare some end-user debug instructions around debug/iwmon =
and then attempt to recruit some affected users in a GitHub thread. =
Let=E2=80=99s see where things take us. Thx :)

Christian

