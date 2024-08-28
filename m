Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE11465AC
	for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841720; cv=none; b=kG0aO9UtA7+p30sC0NmSH8f7VmTwHcHfr28Se4m5z2g9LGEwUaZ10Jjc1qtAxWJF3DYapySNyWwo0ICJymBOwlSLTn3S4/x4Xx2I+dwLQ134vq6k1fuUGxKZIXsA1peMG1j9OtvYLo7WdgwoJa0A9xVF/nziZFtwDJs6ZnN55QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841720; c=relaxed/simple;
	bh=th8JOXjoct8w+xS6jzXjk+RLoZJnW753Hgh007bpOtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=o/v41UMJFT7xdPbkCYPLZFGXY7MBsV9vHiRzMuuMc0EanYAC5EH+d2Jphs93iL+oCvOZI34i6V6yLNBBWVl8ABELe0kHOCA3+Pm6YV6jmno7vGXYZ9bSwCNG6BX7gcyXTzSR2NxH3CPcA5x4bzRAm8/cIzBqDElBrancBjT2JrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzGeWabK; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzGeWabK"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-498d7ab8fefso2443472137.1
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724841716; x=1725446516; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nBhfHgt10TXWopO5IfkPOpdEQ2KPa55c3VEUtQH7h0=;
        b=dzGeWabKSGaPdgUc075oRu7csyKrJG+Y/jGpc+kiVsgefROdkl2GlGLrmC2Ll++n1Z
         8Hh9IL4n/3WUm6EFwiryRufd8SWUN3RL5r8yYUrk1Jl/89t1xNSg8143juO6M5pJ1SiP
         +9Y45jCSweM8doi5qxqfgbtpJLu+gk6PPQGSaNzmVNavI9NFX2XffYUFKq7a45UtD8kc
         3lGWrrDrhxii5nu9HZB35E6yDiTwWu9sqzHvBuh1J732Qa4ikSq5omF9BNYn7oTgG5ip
         C+WVpKd2/AqEofffoxYOY3SJwVuUSIQ1ZJpwt14AJz3dD9kWhchifBSBzVDovhEuIDmo
         SpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724841716; x=1725446516;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nBhfHgt10TXWopO5IfkPOpdEQ2KPa55c3VEUtQH7h0=;
        b=HGw2vUTZtxpAfvwiGeeptWMjB/NNKcjfWhH92TXuR/5neizhP6ITBYk1ufPT9QcmVR
         ymkeXB4SLaIKd34TQ/a8S39uwy+QTd5e8jiyp3dIopbF+QLklh5Pjoev94YG8IWQ+jkN
         2vCAFRG111/xmvVFo/iBOUFWvuUVpfIMoh2GEGKD23X2vT++k1JhuTFFMEsw3kUekN5b
         FizGigsNRQT9jOjzsYEvYheeTLrWKKJHvb70Pz18pLQkJtIvpts9/i6pK75C+yB2iQr1
         4KSB7MX3Lqloy26efcvdWXp5MLrI5B750qRiFhw/2reyXXCgawAFrGRYcqwLv5iCY+hG
         7iHw==
X-Forwarded-Encrypted: i=1; AJvYcCVCcQOKKciJ0i59swodQtYRFE9cW81XIrl+TpVybfFvsdNmTEgyNooIJ0Ha3f2GAqT/S1U=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg9lja2E4JJuf5bw/zISCvxlNV+459/65qBSlptu1Pw0roWZcA
	/LM0VQtEjJKvvy1qOf4wl71i/VSNbfzQLacRHzHfCjCcwR0d/d42tlyiA/7LnSFJi0M58aBgqm2
	MYW7CRyWcIRmC3OspBk1BhjfrqNA=
X-Google-Smtp-Source: AGHT+IHn3aw3xRv5u/7tcHCu8nSOwfh/C8oBp/XpCmJyDxgFnEI3upugNwXuilFOy5BVXgvqfjusleTqOFe5uTi4L0E=
X-Received: by 2002:a05:6102:3a10:b0:48f:a76a:7d with SMTP id
 ada2fe7eead31-498f4b568c6mr20920260137.18.1724841715631; Wed, 28 Aug 2024
 03:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzCB-6wXch6yFu-4V9dKgz0sJRopsd7wXchccptT5hNB-A@mail.gmail.com>
 <444d59ad-9a07-4d2c-922b-e6c43b7d8cb0@gmail.com> <CA+iibzAq50zn7=J+XtH28T=XKbk_Ukoms-K4PYoTrRPEi0J1gg@mail.gmail.com>
 <1c8086ac-1d28-4c02-8c21-c7a37148a9f1@gmail.com> <CA+iibzD=UQC5sDwcoOy5_tPm=_58yp-mvV973Sq3dwJrej=89g@mail.gmail.com>
 <314a3582-0103-40e1-a7a3-274897f5950d@gmail.com> <CA+iibzDc=45P+U-xd6gxQBCqrEtb4ENFewFfzof91a9cU8OErA@mail.gmail.com>
 <4bcf6591-168a-446c-b6ff-b8ba5f7efedb@gmail.com> <CA+iibzDAZ0QSH9yXBgNd_CrOA3Z69z3yhbZMaiPjMUE8ZG8u0w@mail.gmail.com>
 <CAPv5Ue71TT7dDpe6TZQSimCztT3iQew30C7i0syZb=5JhiYCOw@mail.gmail.com>
 <CA+iibzB3j__Xe2VtpEr-5BH+kcJRM06UxcxWVmVZxHVyNMWsyg@mail.gmail.com> <CAPv5Ue6n1BF5E=c3u_cwcHZd+L++v4X8waqKmpW9sgQNvHVSxQ@mail.gmail.com>
In-Reply-To: <CAPv5Ue6n1BF5E=c3u_cwcHZd+L++v4X8waqKmpW9sgQNvHVSxQ@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Wed, 28 Aug 2024 12:41:43 +0200
Message-ID: <CA+iibzCRmWL9H2smcsW31744i6AVc2Y68Juw9dEA2BV8AsKK+Q@mail.gmail.com>
Subject: Re: IWD CMD_SET_CQM failed: Operation not supported
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James

The last commits on netdev have made the patches for the CQM problem
incompatible. I got the errors when I tried to compile with the
patches

+ git clone https://git.kernel.org/pub/scm/network/wireless/iwd.git iwd
Cloning into 'iwd'...
remote: Enumerating objects: 34807, done.
remote: Counting objects: 100% (93/93), done.
remote: Compressing objects: 100% (93/93), done.
remote: Total 34807 (delta 42), reused 0 (delta 0), pack-reused 34714
Receiving objects: 100% (34807/34807), 6.98 MiB | 678.00 KiB/s, done.
Resolving deltas: 100% (25640/25640), done.
+ cd iwd
+ git checkout e9ac7ab3783eb10e0067c35a6de2d6a7c7e104d8
Note: switching to 'e9ac7ab3783eb10e0067c35a6de2d6a7c7e104d8'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to fals=
e

HEAD is now at e9ac7ab3 netdev: add critical signal threshold level
+ patch -Np1 -i /tmp/work/src/patch1.patch
patching file src/wiphy.c
Hunk #2 succeeded at 940 (offset 1 line).
Hunk #3 succeeded at 1391 (offset 1 line).
patching file src/wiphy.h
+ patch -Np1 -i /tmp/work/src/patch2.patch
patching file src/station.c
Hunk #1 succeeded at 2105 (offset 101 lines).
Hunk #2 succeeded at 2134 (offset 101 lines).
Hunk #3 succeeded at 2607 (offset 101 lines).
+ patch -Np1 -i /tmp/work/src/patch3.patch
patching file src/netdev.c
Hunk #1 succeeded at 190 (offset 3 lines).
Hunk #2 FAILED at 207.
Hunk #3 succeeded at 651 (offset 8 lines).
Hunk #4 succeeded at 727 (offset 8 lines).
Hunk #5 succeeded at 1085 (offset 12 lines).
Hunk #6 FAILED at 1107.
Hunk #7 FAILED at 1134.
Hunk #8 succeeded at 1430 (offset 9 lines).
Hunk #9 succeeded at 1444 (offset 9 lines).
Hunk #10 succeeded at 3698 (offset 10 lines).
Hunk #11 succeeded at 3763 (offset 10 lines).
Hunk #12 succeeded at 4343 (offset 48 lines).
Hunk #13 succeeded at 5404 (offset 50 lines).
3 out of 13 hunks FAILED -- saving rejects to file src/netdev.c.rej
=3D=3D=3D=3D=3D=3D=3D> ERROR: Building 'iwd.sources1724830340any.cards.tar.=
xz' failed.

I have remove them and know the error is back

Best regards

Daniel

Le ven. 26 juil. 2024 =C3=A0 19:29, James Prestwood <prestwoj@gmail.com> a =
=C3=A9crit :
>
> Good to hear. I think we'll need to upstream this now that we know this i=
s even possible for drivers to do. Thanks for testing it
>
> On Fri, Jul 26, 2024, 10:25=E2=80=AFAM daniel antoine <univac55@gmail.com=
> wrote:
>>
>> Hi James
>>
>> I have removed the /etc/iwd/main.conf and installed the 3 patches and
>> the error is gone
>>
>> juil. 26 19:15:53 grat-os1 iwd[537]: Wireless daemon version 2.19
>> juil. 26 19:15:53 grat-os1 iwd[537]: station: Network configuration is d=
isabled.
>> juil. 26 19:15:53 grat-os1 iwd[537]: Wiphy: 0, Name: phy0
>> juil. 26 19:15:53 grat-os1 iwd[537]:         Permanent Address:
>> 50:c2:e8:0b:58:bd
>> juil. 26 19:15:53 grat-os1 iwd[537]:         2.4GHz Band:
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 Bitrates (non-HT):
>> juil. 26 19:15:53 grat-os1 iwd[537]:                          1.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                          2.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                          5.5 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         11.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                          6.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                          9.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         12.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         18.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         24.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         36.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         48.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         54.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 HT Capabilities:
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         HT40
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Short GI fo=
r 20Mhz
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Short GI fo=
r 40Mhz
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 HT RX MCS indexes:
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         0-15
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 HE Capabilities
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Interface T=
ypes: ap
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE RX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE TX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Interface
>> Types: station
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE RX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE TX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:         5GHz Band:
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 Bitrates (non-HT):
>> juil. 26 19:15:53 grat-os1 iwd[537]:                          6.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                          9.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         12.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         18.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         24.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         36.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         48.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         54.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 HT Capabilities:
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         HT40
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Short GI fo=
r 20Mhz
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Short GI fo=
r 40Mhz
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 HT RX MCS indexes:
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         0-15
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 VHT Capabilities:
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Short GI fo=
r 80Mhz
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max RX
>> MCS: 0-9 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max TX
>> MCS: 0-9 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 HE Capabilities
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Interface T=
ypes: ap
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE RX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE TX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Interface
>> Types: station
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE RX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE TX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:         6GHz Band:
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 Bitrates (non-HT):
>> juil. 26 19:15:53 grat-os1 iwd[537]:                          6.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                          9.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         12.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         18.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         24.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         36.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         48.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         54.0 Mbps
>> juil. 26 19:15:53 grat-os1 iwd[537]:                 HE Capabilities
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Interface T=
ypes: ap
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE RX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE TX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Interface
>> Types: station
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE RX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:                         Max HE TX
>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> juil. 26 19:15:53 grat-os1 iwd[537]:         Ciphers: BIP-CMAC-256
>> BIP-GMAC-256 BIP-GMAC-128 CCMP-256
>> juil. 26 19:15:53 grat-os1 iwd[537]:                  GCMP-256
>> GCMP-128 BIP-CMAC-128 CCMP-128
>> juil. 26 19:15:53 grat-os1 iwd[537]:                  TKIP
>> juil. 26 19:15:53 grat-os1 iwd[537]:         Supported iftypes: station =
ap
>> juil. 26 19:15:54 grat-os1 iwd[537]: event: state, old: disconnected,
>> new: autoconnect_quick
>> juil. 26 19:15:54 grat-os1 iwd[537]: udev interface=3Dwlan0 ifindex=3D4
>> juil. 26 19:15:54 grat-os1 iwd[537]: udev interface=3Dvirbr0 ifindex=3D5
>> juil. 26 19:15:55 grat-os1 iwd[537]: event: state, old:
>> autoconnect_quick, new: autoconnect_full
>> juil. 26 19:15:55 grat-os1 iwd[537]: event: connect-info, ssid:
>> Livebox-xxxxxxxxxxxxxx:5c:90, signal: -52, load: 6/255
>> juil. 26 19:15:55 grat-os1 iwd[537]: event: state, old:
>> autoconnect_full, new: connecting
>> juil. 26 19:15:58 grat-os1 iwd[537]: event: state, old: connecting,
>> new: connected
>> juil. 26 19:15:58 grat-os1 iwd[537]: event: roam-scan,
>> juil. 26 19:16:30 grat-os1 iwd[537]: event: roam-scan,
>> juil. 26 19:16:31 grat-os1 iwd[537]: event: roam-info, bss:
>> xxxxxxxxxx5c:95, signal: -48, load: 1/255
>> juil. 26 19:16:31 grat-os1 iwd[537]: event: state, old: connected, new: =
roaming
>> juil. 26 19:16:32 grat-os1 iwd[537]: event: state, old: roaming, new: co=
nnected
>>
>>
>>
>> The last commit is also installed d8803b309dd307728e9ccca8151ac7910dbe3a=
e5
>>
>> Thanks a lot and good job
>>
>> Best regards
>>
>> Daniel
>>
>> Le ven. 26 juil. 2024 =C3=A0 19:01, James Prestwood <prestwoj@gmail.com>=
 a =C3=A9crit :
>> >
>> > The 3 patches are on the mailing list, not merged yet. So you'll have =
to download/apply those to test
>> >
>> > On Fri, Jul 26, 2024, 9:54=E2=80=AFAM daniel antoine <univac55@gmail.c=
om> wrote:
>> >>
>> >> Hi James
>> >>
>> >> I have installed the commit d8803b309dd307728e9ccca8151ac7910dbe3ae5
>> >> but there is always the same error
>> >>
>> >> CMD_SET_CQM failed: Operation not supported
>> >> juil. 26 18:47:59 grat-os1 iwd[529]: event: state, old: connecting,
>> >> new: connected
>> >> juil. 26 18:48:01 grat-os1 iwd[529]: event: roam-scan,
>> >> juil. 26 18:48:02 grat-os1 iwd[529]: event: roam-info,
>> >> bssxxxxxx:5c:95, signal: -45, load: 1/255
>> >> juil. 26 18:48:02 grat-os1 iwd[529]: event: state, old: connected, ne=
w: roaming
>> >> juil. 26 18:48:02 grat-os1 iwd[529]: CMD_SET_CQM failed: Operation no=
t supported
>> >> juil. 26 18:48:03 grat-os1 iwd[529]: event: state, old: roaming, new:=
 connected
>> >>
>> >> you talked about 3 patches , is it the commit
>> >>
>> >> Best regards
>> >>
>> >> Daniel
>> >>
>> >> Le ven. 26 juil. 2024 =C3=A0 18:41, James Prestwood <prestwoj@gmail.c=
om> a =C3=A9crit :
>> >> >
>> >> > Hi Daniel,
>> >> >
>> >> > I sent 3 patches to the list which you could try out. It should wor=
k
>> >> > around the issue your seeing.
>> >> >
>> >> > On 7/26/24 4:59 AM, daniel antoine wrote:
>> >> > > Hi James
>> >> > >
>> >> > > Thanks a lot. I will try to send a mail
>> >> > >
>> >> > > Best regards
>> >> > >
>> >> > > Daniel
>> >> > >
>> >> > > Le ven. 26 juil. 2024 =C3=A0 13:51, James Prestwood <prestwoj@gma=
il.com> a =C3=A9crit :
>> >> > >> Hi Daniel,
>> >> > >>
>> >> > >> On 7/25/24 2:29 PM, daniel antoine wrote:
>> >> > >>> Hi James
>> >> > >>>
>> >> > >>> Hi have created a .etc.iwd/main.conf file with
>> >> > >>> [DriverQuirks]
>> >> > >>> PowerSaveDisable=3Dmt*
>> >> > >>>
>> >> > >>> the error is always here
>> >> > >>>
>> >> > >>> juil. 25 22:58:26 grat-os1 iwd[536]: Wireless daemon version 2.=
19
>> >> > >>> juil. 25 22:58:26 grat-os1 iwd[536]: Loaded configuration from
>> >> > >>> /etc/iwd/main.conf
>> >> > >>> juil. 25 22:58:26 grat-os1 iwd[536]: station: Network configura=
tion is disabled.
>> >> > >>>
>> >> > >>>
>> >> > >>> juil. 25 22:58:27 grat-os1 iwd[536]: event: state, old:
>> >> > >>> autoconnect_full, new: connecting
>> >> > >>> juil. 25 22:58:27 grat-os1 iwd[536]: CMD_SET_CQM failed: Operat=
ion not supported
>> >> > >>> juil. 25 22:58:31 grat-os1 iwd[536]: event: state, old: connect=
ing,
>> >> > >>> new: connected
>> >> > >>> juil. 25 22:58:32 grat-os1 iwd[536]: event: roam-scan,
>> >> > >>> juil. 25 22:59:03 grat-os1 iwd[536]: event: roam-scan,
>> >> > >>> juil. 25 22:59:03 grat-os1 iwd[536]: event: roam-info, bss:
>> >> > >>> xx;xx;xx;xx:5c:95, signal: -48, load: 3/255
>> >> > >>> juil. 25 22:59:03 grat-os1 iwd[536]: event: state, old: connect=
ed, new: roaming
>> >> > >>> juil. 25 22:59:03 grat-os1 iwd[536]: CMD_SET_CQM failed: Operat=
ion not supported
>> >> > >>> juil. 25 22:59:04 grat-os1 iwd[536]: event: state, old: roaming=
, new: connected
>> >> > >>>
>> >> > >>> now the log with the -d option
>> >> > >>> root@grat-os1:~# /usr/lib/iwd/iwd -d
>> >> > >>> Wireless daemon version 2.19
>> >> > >>> src/main.c:main() Using configuration directory /etc/iwd
>> >> > >>> Loaded configuration from /etc/iwd/main.conf
>> >> > >>> src/storage.c:storage_create_dirs() Using state directory /var/=
lib/iwd
>> >> > >>> src/main.c:nl80211_appeared() Found nl80211 interface
>> >> > >>> src/module.c:iwd_modules_init()
>> >> > >>> station: Network configuration is disabled.
>> >> > >>> src/wsc.c:wsc_init()
>> >> > >>> src/udev.c:udev_init()
>> >> > >>> src/eap.c:__eap_method_enable()
>> >> > >>> src/eap-wsc.c:eap_wsc_init()
>> >> > >>> src/eap-md5.c:eap_md5_init()
>> >> > >>> src/eap-tls.c:eap_tls_init()
>> >> > >>> src/eap-ttls.c:eap_ttls_init()
>> >> > >>> src/eap-mschapv2.c:eap_mschapv2_init()
>> >> > >>> src/eap-sim.c:eap_sim_init()
>> >> > >>> src/eap-aka.c:eap_aka_prime_init()
>> >> > >>> src/eap-aka.c:eap_aka_init()
>> >> > >>> src/eap-peap.c:eap_peap_init()
>> >> > >>> src/eap-gtc.c:eap_gtc_init()
>> >> > >>> src/eap-pwd.c:eap_pwd_init()
>> >> > >>> src/manager.c:manager_wiphy_dump_callback() New wiphy phy0 adde=
d (0)
>> >> > >>> src/manager.c:manager_wiphy_dump_done()
>> >> > >>> src/manager.c:manager_filtered_wiphy_dump_done()
>> >> > >>> Wiphy: 0, Name: phy0
>> >> > >>>     Permanent Address: 50:c2:e8:0b:58:bd
>> >> > >>>     2.4GHz Band:
>> >> > >>>             Bitrates (non-HT):
>> >> > >>>                        1.0 Mbps
>> >> > >>>                        2.0 Mbps
>> >> > >>>                        5.5 Mbps
>> >> > >>>                       11.0 Mbps
>> >> > >>>                        6.0 Mbps
>> >> > >>>                        9.0 Mbps
>> >> > >>>                       12.0 Mbps
>> >> > >>>                       18.0 Mbps
>> >> > >>>                       24.0 Mbps
>> >> > >>>                       36.0 Mbps
>> >> > >>>                       48.0 Mbps
>> >> > >>>                       54.0 Mbps
>> >> > >>>             HT Capabilities:
>> >> > >>>                       HT40
>> >> > >>>                       Short GI for 20Mhz
>> >> > >>>                       Short GI for 40Mhz
>> >> > >>>             HT RX MCS indexes:
>> >> > >>>                       0-15
>> >> > >>>             HE Capabilities
>> >> > >>>                       Interface Types: ap
>> >> > >>>                       Max HE RX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>                       Max HE TX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>                       Interface Types: station
>> >> > >>>                       Max HE RX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>                       Max HE TX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>     5GHz Band:
>> >> > >>>             Bitrates (non-HT):
>> >> > >>>                        6.0 Mbps
>> >> > >>>                        9.0 Mbps
>> >> > >>>                       12.0 Mbps
>> >> > >>>                       18.0 Mbps
>> >> > >>>                       24.0 Mbps
>> >> > >>>                       36.0 Mbps
>> >> > >>>                       48.0 Mbps
>> >> > >>>                       54.0 Mbps
>> >> > >>>             HT Capabilities:
>> >> > >>>                       HT40
>> >> > >>>                       Short GI for 20Mhz
>> >> > >>>                       Short GI for 40Mhz
>> >> > >>>             HT RX MCS indexes:
>> >> > >>>                       0-15
>> >> > >>>             VHT Capabilities:
>> >> > >>>                       Short GI for 80Mhz
>> >> > >>>                       Max RX MCS: 0-9 for NSS: 2
>> >> > >>>                       Max TX MCS: 0-9 for NSS: 2
>> >> > >>>             HE Capabilities
>> >> > >>>                       Interface Types: ap
>> >> > >>>                       Max HE RX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>                       Max HE TX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>                       Interface Types: station
>> >> > >>>                       Max HE RX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>                       Max HE TX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>     6GHz Band:
>> >> > >>>             Bitrates (non-HT):
>> >> > >>>                        6.0 Mbps
>> >> > >>>                        9.0 Mbps
>> >> > >>>                       12.0 Mbps
>> >> > >>>                       18.0 Mbps
>> >> > >>>                       24.0 Mbps
>> >> > >>>                       36.0 Mbps
>> >> > >>>                       48.0 Mbps
>> >> > >>>                       54.0 Mbps
>> >> > >>>             HE Capabilities
>> >> > >>>                       Interface Types: ap
>> >> > >>>                       Max HE RX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>                       Max HE TX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>                       Interface Types: station
>> >> > >>>                       Max HE RX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>                       Max HE TX <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>     Ciphers: BIP-CMAC-256 BIP-GMAC-256 BIP-GMAC-128 CCMP-256
>> >> > >>>              GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
>> >> > >>>              TKIP
>> >> > >>>     Supported iftypes: station ap
>> >> > >>>     Driver Flags: PowerSaveDisable
>> >> > >>> src/agent.c:agent_register() agent register called
>> >> > >>> src/agent.c:agent_register() agent :1.5 path /net/connman/iwd_a=
gent
>> >> > >>> src/manager.c:manager_interface_dump_done()
>> >> > >>> src/manager.c:manager_create_interfaces() creating wlan0
>> >> > >>> src/wiphy.c:wiphy_update_reg_domain() New reg domain country co=
de for
>> >> > >>> (global) is FR
>> >> > >>> src/manager.c:manager_config_notify() Notification of command N=
ew Interface(7)
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/manager.c:manager_new_station_interface_cb()
>> >> > >>> src/netdev.c:netdev_create_from_genl() Created interface wlan0[=
6 3]
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_set_4addr() netdev: 6 use_4addr: 0
>> >> > >>> src/netdev.c:netdev_initial_up_cb() Interface 6 initialized
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/manager.c:manager_config_notify() Notification of command S=
et Interface(6)
>> >> > >>> src/netdev.c:netdev_disable_ps_cb() Disabled power save for ifi=
ndex 6
>> >> > >>> event: state, old: disconnected, new: autoconnect_quick
>> >> > >>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
>> >> > >>> src/wiphy.c:wiphy_radio_work_next() Starting work item 1
>> >> > >>> src/rrm.c:rrm_add_frame_watches()
>> >> > >>> src/scan.c:scan_notify() Scan notification Trigger Scan(33)
>> >> > >>> src/scan.c:scan_request_triggered() Active scan triggered for w=
dev 3
>> >> > >>> src/station.c:station_quick_scan_triggered() Quick scan trigger=
ed for wlan0
>> >> > >>> udev interface=3Dwlan0 ifindex=3D6
>> >> > >>> src/scan.c:scan_notify() Scan notification New Scan Results(34)
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/station.c:station_print_scan_bss() Processing BSS
>> >> > >>> 'xx;xx;xx;xx:5c:90' with SSID: Livebox-5XXX, freq: 2412, rank: =
591,
>> >> > >>> strength: -5700, data_rate: 72.2, load: 7/255
>> >> > >>> src/station.c:station_add_seen_bss() Added new Network "Livebox=
-5XXX"
>> >> > >>> security psk
>> >> > >>> src/station.c:station_autoconnect_start()
>> >> > >>> src/station.c:station_autoconnect_next() autoconnect: Trying SS=
ID: Livebox-5XXX
>> >> > >>> src/station.c:station_autoconnect_next() autoconnect:
>> >> > >>> 'xx;xx;xx;xx:5c:90' freq: 2412, rank: 591, strength: -5700
>> >> > >>> src/station.c:station_autoconnect_next() autoconnect:
>> >> > >>> network_autoconnect: Operation not permitted (-1)
>> >> > >>> event: state, old: autoconnect_quick, new: autoconnect_full
>> >> > >>> src/scan.c:scan_periodic_start() Starting periodic scan for wde=
v 3
>> >> > >>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
>> >> > >>> src/wiphy.c:wiphy_radio_work_done() Work item 1 done
>> >> > >>> src/wiphy.c:wiphy_radio_work_next() Starting work item 2
>> >> > >>> src/scan.c:scan_notify() Scan notification Trigger Scan(33)
>> >> > >>> src/scan.c:scan_request_triggered() Passive scan triggered for =
wdev 3
>> >> > >>> src/scan.c:scan_periodic_triggered() Periodic scan triggered fo=
r wdev 3
>> >> > >>> src/network.c:network_connect()
>> >> > >>> src/network.c:network_connect_psk() ask_passphrase: false
>> >> > >>> src/netdev.c:netdev_cqm_rssi_update()
>> >> > >>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 3
>> >> > >>> event: connect-info, ssid: Livebox-5XXX, bss: xx;xx;xx;xx:5c:90=
,
>> >> > >>> signal: -57, load: 7/255
>> >> > >>> event: state, old: autoconnect_full, new: connecting
>> >> > >>> src/scan.c:scan_periodic_stop() Stopping periodic scan for wdev=
 3
>> >> > >>> src/scan.c:scan_cancel() Trying to cancel scan id 2 for wdev 3
>> >> > >>> src/scan.c:scan_cancel() Scan has been triggered, wait for it t=
o complete
>> >> > >>> CMD_SET_CQM failed: Operation not supported
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/scan.c:scan_notify() Scan notification New Scan Results(34)
>> >> > >>> src/wiphy.c:wiphy_radio_work_done() Work item 2 done
>> >> > >>> src/wiphy.c:wiphy_radio_work_next() Starting work item 3
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification New Station=
(19)
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Authenticat=
e(37)
>> >> > >>> src/netdev.c:netdev_authenticate_event()
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Associate(3=
8)
>> >> > >>> src/netdev.c:netdev_associate_event()
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
>> >> > >>> src/netdev.c:netdev_connect_event()
>> >> > >>> src/netdev.c:netdev_connect_event() aborting and ignore_connect=
_event
>> >> > >>> not set, proceed
>> >> > >>> src/netdev.c:netdev_connect_event() expect_connect_failure not =
set, proceed
>> >> > >>> src/netdev.c:parse_request_ies()
>> >> > >>> src/netdev.c:netdev_connect_event() Request / Response IEs pars=
ed
>> >> > >>> src/netdev.c:netdev_get_oci()
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/wiphy.c:wiphy_reg_notify() Notification of command Reg Chan=
ge(36)
>> >> > >>> src/netdev.c:netdev_get_oci_cb() Obtained OCI: freq: 2412, widt=
h: 1,
>> >> > >>> center1: 2412, center2: 0
>> >> > >>> src/eapol.c:eapol_start()
>> >> > >>> src/station.c:station_handshake_event() Handshaking
>> >> > >>> src/netdev.c:netdev_unicast_notify() Unicast notification Contr=
ol Port
>> >> > >>> Frame(129)
>> >> > >>> src/netdev.c:netdev_control_port_frame_event()
>> >> > >>> src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D6
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Control Por=
t TX Status(139)
>> >> > >>> src/netdev.c:netdev_unicast_notify() Unicast notification Contr=
ol Port
>> >> > >>> Frame(129)
>> >> > >>> src/netdev.c:netdev_control_port_frame_event()
>> >> > >>> src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D6
>> >> > >>> src/netdev.c:netdev_set_gtk() ifindex=3D6 key_idx=3D1
>> >> > >>> src/station.c:station_handshake_event() Setting keys
>> >> > >>> src/netdev.c:netdev_set_tk() ifindex=3D6 key_idx=3D0
>> >> > >>> src/netdev.c:netdev_set_rekey_offload() 6
>> >> > >>> src/netdev.c:netdev_new_group_key_cb() ifindex: 6, err: 0
>> >> > >>> src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_ins=
talled:
>> >> > >>> 1, igtk_installed: 1
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Control Por=
t TX Status(139)
>> >> > >>> src/netdev.c:netdev_set_station_cb()
>> >> > >>> src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_ins=
talled:
>> >> > >>> 1, igtk_installed: 1
>> >> > >>> src/netdev.c:try_handshake_complete() nhs->complete: 0
>> >> > >>> src/netdev.c:try_handshake_complete() Invoking handshake_event(=
)
>> >> > >>> src/netdev.c:netdev_connect_ok()
>> >> > >>> src/station.c:station_connect_cb() 6, result: 0
>> >> > >>> src/station.c:station_connect_ok()
>> >> > >>> event: state, old: connecting, new: connected
>> >> > >>> src/wiphy.c:wiphy_radio_work_done() Work item 3 done
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX St=
atus(60)
>> >> > >>> src/station.c:station_early_neighbor_report_cb() ifindex: 6, er=
ror: 0()
>> >> > >>> src/station.c:parse_neighbor_report() Neighbor report received =
for
>> >> > >>> 00:00:00:00:00:00: ch 104 (oper class 128), MD not set
>> >> > >>> src/netdev.c:netdev_unicast_notify() Unicast notification Frame=
(59)
>> >> > >>> src/netdev.c:netdev_unicast_notify() Unicast notification Frame=
(59)
>> >> > >>> src/station.c:station_ap_directed_roam() ifindex: 6
>> >> > >>> src/station.c:station_ap_directed_roam() roam: BSS transition r=
eceived
>> >> > >>> from AP: xx;xx;xx;xx:5c:90, Disassociation Time: 15, Validity
>> >> > >>> interval: 0, Address3: xx;xx;xx;xx:5c:90
>> >> > >>> src/station.c:station_ap_directed_roam() roam: AP sent a prefer=
red
>> >> > >>> candidate list
>> >> > >>> src/station.c:station_neighbor_report_cb() ifindex: 6, error: 0=
()
>> >> > >>> src/station.c:parse_neighbor_report() Neighbor report received =
for
>> >> > >>> xx;xx;xx;xx:5c:95: ch 104 (oper class 128), MD not set
>> >> > >>> src/station.c:station_roam_scan() ifindex: 6
>> >> > >>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 4
>> >> > >>> src/wiphy.c:wiphy_radio_work_next() Starting work item 4
>> >> > >>> src/netdev.c:netdev_unicast_notify() Unicast notification Frame=
(59)
>> >> > >>> src/scan.c:scan_notify() Scan notification Trigger Scan(33)
>> >> > >>> src/scan.c:scan_request_triggered() Active scan triggered for w=
dev 3
>> >> > >>> event: roam-scan,
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/scan.c:scan_notify() Scan notification New Scan Results(34)
>> >> > >>> src/station.c:station_roam_scan_notify() Current BSS
>> >> > >>> 'xx;xx;xx;xx:5c:90' with SSID: Livebox-5XXX
>> >> > >>> src/station.c:station_print_scan_bss() Processing BSS
>> >> > >>> 'xx;xx;xx;xx:5c:90' with SSID: Livebox-5XXX, freq: 2412, rank: =
591,
>> >> > >>> strength: -4600, data_rate: 72.2, load: 9/255
>> >> > >>> src/station.c:station_print_scan_bss() Processing BSS
>> >> > >>> 'xx;xx;xx;xx:5c:95' with SSID: Livebox-5XXX, freq: 5520, rank: =
7093,
>> >> > >>> strength: -4300, data_rate: 866.7, load: 1/255
>> >> > >>> event: roam-info, bss: xx;xx;xx;xx:5c:95, signal: -43, load: 1/=
255
>> >> > >>> src/netdev.c:netdev_cqm_rssi_update()
>> >> > >>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5
>> >> > >>> src/station.c:station_transition_reassociate()
>> >> > >>> event: state, old: connected, new: roaming
>> >> > >>> src/wiphy.c:wiphy_radio_work_done() Work item 4 done
>> >> > >>> src/wiphy.c:wiphy_radio_work_next() Starting work item 5
>> >> > >>> CMD_SET_CQM failed: Operation not supported
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Del Station=
(20)
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Deauthentic=
ate(39)
>> >> > >>> src/netdev.c:netdev_deauthenticate_event()
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification New Station=
(19)
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Authenticat=
e(37)
>> >> > >>> src/netdev.c:netdev_authenticate_event()
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Associate(3=
8)
>> >> > >>> src/netdev.c:netdev_associate_event()
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
>> >> > >>> src/netdev.c:netdev_connect_event()
>> >> > >>> src/netdev.c:netdev_connect_event() aborting and ignore_connect=
_event
>> >> > >>> not set, proceed
>> >> > >>> src/netdev.c:netdev_connect_event() expect_connect_failure not =
set, proceed
>> >> > >>> src/netdev.c:parse_request_ies()
>> >> > >>> src/netdev.c:netdev_connect_event() Request / Response IEs pars=
ed
>> >> > >>> src/netdev.c:netdev_get_oci()
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_get_oci_cb() Obtained OCI: freq: 5520, widt=
h: 3,
>> >> > >>> center1: 5530, center2: 0
>> >> > >>> src/eapol.c:eapol_start()
>> >> > >>> src/station.c:station_handshake_event() Handshaking
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_unicast_notify() Unicast notification Contr=
ol Port
>> >> > >>> Frame(129)
>> >> > >>> src/netdev.c:netdev_control_port_frame_event()
>> >> > >>> src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D6
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Control Por=
t TX Status(139)
>> >> > >>> src/netdev.c:netdev_unicast_notify() Unicast notification Contr=
ol Port
>> >> > >>> Frame(129)
>> >> > >>> src/netdev.c:netdev_control_port_frame_event()
>> >> > >>> src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D6
>> >> > >>> src/netdev.c:netdev_set_gtk() ifindex=3D6 key_idx=3D1
>> >> > >>> src/station.c:station_handshake_event() Setting keys
>> >> > >>> src/netdev.c:netdev_set_tk() ifindex=3D6 key_idx=3D0
>> >> > >>> src/netdev.c:netdev_set_rekey_offload() 6
>> >> > >>> src/netdev.c:netdev_new_group_key_cb() ifindex: 6, err: 0
>> >> > >>> src/netdev.c:try_handshake_complete() ptk_installed: 0, gtk_ins=
talled:
>> >> > >>> 1, igtk_installed: 1
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Control Por=
t TX Status(139)
>> >> > >>> src/netdev.c:netdev_set_station_cb()
>> >> > >>> src/netdev.c:try_handshake_complete() ptk_installed: 1, gtk_ins=
talled:
>> >> > >>> 1, igtk_installed: 1
>> >> > >>> src/netdev.c:try_handshake_complete() nhs->complete: 0
>> >> > >>> src/netdev.c:try_handshake_complete() Invoking handshake_event(=
)
>> >> > >>> src/netdev.c:netdev_connect_ok()
>> >> > >>> src/station.c:station_reassociate_cb() 6, result: 0
>> >> > >>> event: state, old: roaming, new: connected
>> >> > >>> src/wiphy.c:wiphy_radio_work_done() Work item 5 done
>> >> > >>> src/netdev.c:netdev_link_notify() event 16 on ifindex 6
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX St=
atus(60)
>> >> > >>> src/netdev.c:netdev_unicast_notify() Unicast notification Frame=
(59)
>> >> > >>> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX St=
atus(60)
>> >> > >>> src/station.c:station_early_neighbor_report_cb() ifindex: 6, er=
ror: 0()
>> >> > >>> src/netdev.c:netdev_unicast_notify() Unicast notification Frame=
(59)
>> >> > >> I actually happened to have this same card and tested it, and I =
see the
>> >> > >> same failure. I think this is a driver issue as all drivers shou=
ld
>> >> > >> support a single CQM threshold. I would suggest asking on the
>> >> > >> linux-wireless mailing list as to why this card does not support=
 CQM.
>> >> > >>
>> >> > >> Thanks,
>> >> > >>
>> >> > >> James
>> >> > >>
>> >> > >>>
>> >> > >>> best regards
>> >> > >>>
>> >> > >>> Daniel
>> >> > >>>
>> >> > >>>
>> >> > >>>
>> >> > >>>
>> >> > >>> Le jeu. 25 juil. 2024 =C3=A0 20:45, James Prestwood <prestwoj@g=
mail.com> a =C3=A9crit :
>> >> > >>>> Hi Daniel,
>> >> > >>>>
>> >> > >>>> On 7/25/24 11:15 AM, daniel antoine wrote:
>> >> > >>>>> Hi James
>> >> > >>>>>
>> >> > >>>>> I send you the lspci display for the wifi device
>> >> > >>>>>
>> >> > >>>>> 04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi=
-Fi 6E 80MHz
>> >> > >>>>> Subsystem: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
>> >> > >>>>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr-
>> >> > >>>>> Stepping- SERR- FastB2B- DisINTx+
>> >> > >>>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbo=
rt-
>> >> > >>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >> > >>>>> Latency: 0, Cache Line Size: 64 bytes
>> >> > >>>>> Interrupt: pin A routed to IRQ 68
>> >> > >>>>> IOMMU group: 14
>> >> > >>>>> Region 0: Memory at fe30300000 (64-bit, prefetchable) [size=
=3D1M]
>> >> > >>>>> Region 2: Memory at fe30400000 (64-bit, prefetchable) [size=
=3D16K]
>> >> > >>>>> Region 4: Memory at fe30404000 (64-bit, prefetchable) [size=
=3D4K]
>> >> > >>>>> Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
>> >> > >>>>>            DevCap:MaxPayload 128 bytes, PhantFunc 0, Latency =
L0s
>> >> > >>>>> unlimited, L1 unlimited
>> >> > >>>>>                    ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLR=
eset+
>> >> > >>>>> SlotPowerLimit 75W TEE-IO-
>> >> > >>>>>            DevCtl:CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>> >> > >>>>>                    RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoo=
p+ FLReset-
>> >> > >>>>>                    MaxPayload 128 bytes, MaxReadReq 512 bytes
>> >> > >>>>>            DevSta:CorrErr+ NonFatalErr- FatalErr- UnsupReq+ A=
uxPwr- TransPend-
>> >> > >>>>>            LnkCap:Port #1, Speed 5GT/s, Width x1, ASPM L0s L1=
, Exit
>> >> > >>>>> Latency L0s <2us, L1 <8us
>> >> > >>>>>                    ClockPM- Surprise- LLActRep- BwNot- ASPMOp=
tComp+
>> >> > >>>>>            LnkCtl:ASPM L1 Enabled; RCB 64 bytes, LnkDisable- =
CommClk+
>> >> > >>>>>                    ExtSynch- ClockPM- AutWidDis- BWInt- AutBW=
Int-
>> >> > >>>>>            LnkSta:Speed 5GT/s, Width x1
>> >> > >>>>>                    TrErr- Train- SlotClk+ DLActive- BWMgmt- A=
BWMgmt-
>> >> > >>>>>            DevCap2: Completion Timeout: Range ABCD, TimeoutDi=
s+ NROPrPrP- LTR+
>> >> > >>>>>                     10BitTagComp- 10BitTagReq- OBFF Not Suppo=
rted,
>> >> > >>>>> ExtFmt+ EETLPPrefix-
>> >> > >>>>>                     EmergencyPowerReduction Not Supported,
>> >> > >>>>> EmergencyPowerReductionInit-
>> >> > >>>>>                     FRS- TPHComp- ExtTPHComp-
>> >> > >>>>>                     AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>> >> > >>>>>            DevCtl2: Completion Timeout: 50us to 50ms, Timeout=
Dis-
>> >> > >>>>>                     AtomicOpsCtl: ReqEn-
>> >> > >>>>>                     IDOReq- IDOCompl- LTR+ EmergencyPowerRedu=
ctionReq-
>> >> > >>>>>                     10BitTagReq- OBFF Disabled, EETLPPrefixBl=
k-
>> >> > >>>>>            LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crossli=
nk- Retimer-
>> >> > >>>>> 2Retimers- DRS-
>> >> > >>>>>            LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance=
- SpeedDis-
>> >> > >>>>>                     Transmit Margin: Normal Operating Range,
>> >> > >>>>> EnterModifiedCompliance- ComplianceSOS-
>> >> > >>>>>                     Compliance Preset/De-emphasis: -6dB de-em=
phasis, 0dB preshoot
>> >> > >>>>>            LnkSta2: Current De-emphasis Level: -3.5dB,
>> >> > >>>>> EqualizationComplete- EqualizationPhase1-
>> >> > >>>>>                     EqualizationPhase2- EqualizationPhase3-
>> >> > >>>>> LinkEqualizationRequest-
>> >> > >>>>>                     Retimer- 2Retimers- CrosslinkRes: unsuppo=
rted
>> >> > >>>>> Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
>> >> > >>>>>            Address: 00000000fee00000  Data: 0000
>> >> > >>>>>            Masking: fffffffe  Pending: 00000000
>> >> > >>>>> Capabilities: [f8] Power Management version 3
>> >> > >>>>>            Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
>> >> > >>>>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>> >> > >>>>>            Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=
=3D0 PME-
>> >> > >>>>> Capabilities: [100 v1] Vendor Specific Information: ID=3D1556=
 Rev=3D1 Len=3D008 <?>
>> >> > >>>>> Capabilities: [108 v1] Latency Tolerance Reporting
>> >> > >>>>>            Max snoop latency: 1048576ns
>> >> > >>>>>            Max no snoop latency: 1048576ns
>> >> > >>>>> Capabilities: [110 v1] L1 PM Substates
>> >> > >>>>>            L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASP=
M_L1.1+
>> >> > >>>>> L1_PM_Substates+
>> >> > >>>>>                      PortCommonModeRestoreTime=3D3us PortTPow=
erOnTime=3D28us
>> >> > >>>>>            L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ AS=
PM_L1.1+
>> >> > >>>>>                       T_CommonMode=3D0us LTR1.2_Threshold=3D1=
66912ns
>> >> > >>>>>            L1SubCtl2: T_PwrOn=3D150us
>> >> > >>>>> Capabilities: [200 v2] Advanced Error Reporting
>> >> > >>>>>            UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- Un=
xCmplt- RxOF- MalfTLP-
>> >> > >>>>>                    ECRC- UnsupReq- ACSViol- UncorrIntErr- Blo=
ckedTLP-
>> >> > >>>>> AtomicOpBlocked- TLPBlockedErr-
>> >> > >>>>>                    PoisonTLPBlocked- DMWrReqBlocked- IDECheck=
- MisIDETLP-
>> >> > >>>>> PCRC_CHECK- TLPXlatBlocked-
>> >> > >>>>>            UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- Un=
xCmplt- RxOF- MalfTLP-
>> >> > >>>>>                    ECRC- UnsupReq- ACSViol- UncorrIntErr+ Blo=
ckedTLP-
>> >> > >>>>> AtomicOpBlocked- TLPBlockedErr-
>> >> > >>>>>                    PoisonTLPBlocked- DMWrReqBlocked- IDECheck=
- MisIDETLP-
>> >> > >>>>> PCRC_CHECK- TLPXlatBlocked-
>> >> > >>>>>            UESvrt:DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- Un=
xCmplt- RxOF- MalfTLP+
>> >> > >>>>>                    ECRC- UnsupReq- ACSViol- UncorrIntErr+ Blo=
ckedTLP-
>> >> > >>>>> AtomicOpBlocked- TLPBlockedErr-
>> >> > >>>>>                    PoisonTLPBlocked- DMWrReqBlocked- IDECheck=
- MisIDETLP-
>> >> > >>>>> PCRC_CHECK- TLPXlatBlocked-
>> >> > >>>>>            CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>> >> > >>>>> AdvNonFatalErr- CorrIntErr- HeaderOF-
>> >> > >>>>>            CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout-
>> >> > >>>>> AdvNonFatalErr+ CorrIntErr+ HeaderOF-
>> >> > >>>>>            AERCap:First Error Pointer: 00, ECRCGenCap- ECRCGe=
nEn-
>> >> > >>>>> ECRCChkCap- ECRCChkEn-
>> >> > >>>>>                    MultHdrRecCap- MultHdrRecEn- TLPPfxPres- H=
drLogCap-
>> >> > >>>>>            HeaderLog: 00000000 00000000 00000000 00000000
>> >> > >>>>> Kernel driver in use: mt7921e
>> >> > >>>>> Kernel modules: mt7921e
>> >> > >>>>>
>> >> > >>>>> How to put iwd in debug mode, is it an option to add to the c=
ommand
>> >> > >>>>> line ExecStart=3D/usr/lib/iwd/iwd
>> >> > >>>>> in the file iwd.service like -d ?
>> >> > >>>> Yeah -d in the service file would do it. I think this would be=
 more of a
>> >> > >>>> linux-wireless question or question to mediatek. I believe thi=
s driver
>> >> > >>>> is hitting the case I described on my last email. I see one ca=
se it
>> >> > >>>> unsets it when power save is disabled so you could maybe try t=
hat. IWD
>> >> > >>>> can do that automatically with a main.conf option:
>> >> > >>>>
>> >> > >>>> [DriverQuirks]
>> >> > >>>> PowerSaveDisable=3Dmt*
>> >> > >>>>
>> >> > >>>> (mt* is just a glob match for something like mt7921e)
>> >> > >>>>
>> >> > >>>>> Best regards
>> >> > >>>>>
>> >> > >>>>> Daniel
>> >> > >>>>>
>> >> > >>>>> Le jeu. 25 juil. 2024 =C3=A0 18:41, James Prestwood <prestwoj=
@gmail.com> a =C3=A9crit :
>> >> > >>>>>> Hi Daniel,
>> >> > >>>>>>
>> >> > >>>>>> On 7/25/24 9:15 AM, daniel antoine wrote:
>> >> > >>>>>>> Hi
>> >> > >>>>>>>
>> >> > >>>>>>> I always have this error when iwd connect. It's not a probl=
em, it
>> >> > >>>>>>> works perfectly. How to get rid of it.
>> >> > >>>>>>>
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]: Wireless daemon versio=
n 2.19
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]: station: Network confi=
guration is disabled.
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]: Wiphy: 0, Name: phy0
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:         Permanent Addr=
ess:
>> >> > >>>>>>> 50:c2:e8:0b:58:bd
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:         2.4GHz Band:
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrat=
es (non-HT):
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
   1.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
   2.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
   5.5 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  11.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
   6.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
   9.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  12.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  18.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  24.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  36.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  48.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  54.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Cap=
abilities:
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  HT40
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Short GI for 20Mhz
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Short GI for 40Mhz
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX =
MCS indexes:
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  0-15
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Cap=
abilities
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Interface Types: ap
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE RX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE TX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Interface
>> >> > >>>>>>> Types: station
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE RX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE TX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:         5GHz Band:
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrat=
es (non-HT):
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
   6.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
   9.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  12.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  18.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  24.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  36.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  48.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  54.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Cap=
abilities:
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  HT40
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Short GI for 20Mhz
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Short GI for 40Mhz
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX =
MCS indexes:
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  0-15
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 VHT Ca=
pabilities:
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Short GI for 80Mhz
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max RX
>> >> > >>>>>>> MCS: 0-9 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max TX
>> >> > >>>>>>> MCS: 0-9 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Cap=
abilities
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Interface Types: ap
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE RX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE TX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Interface
>> >> > >>>>>>> Types: station
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE RX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE TX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:         6GHz Band:
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrat=
es (non-HT):
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
   6.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
   9.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  12.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  18.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  24.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  36.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  48.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  54.0 Mbps
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Cap=
abilities
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Interface Types: ap
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE RX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE TX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Interface
>> >> > >>>>>>> Types: station
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE RX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                       =
  Max HE TX
>> >> > >>>>>>> <=3D 80MHz MCS: 0-11 for NSS: 2
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:         Ciphers: BIP-C=
MAC-256
>> >> > >>>>>>> BIP-GMAC-256 BIP-GMAC-128 CCMP-256
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                  GCMP-=
256
>> >> > >>>>>>> GCMP-128 BIP-CMAC-128 CCMP-128
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:                  TKIP
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]:         Supported ifty=
pes: station ap
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=3Dwlan0=
 ifindex=3D3
>> >> > >>>>>>> juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=3Dvirbr=
0 ifindex=3D4
>> >> > >>>>>>> juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old: dis=
connected,
>> >> > >>>>>>> new: autoconnect_quick
>> >> > >>>>>>> juil. 25 17:35:06 grat-os1 iwd[530]: udev interface=3Dwlan0=
 ifindex=3D5
>> >> > >>>>>>> juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
>> >> > >>>>>>> autoconnect_quick, new: autoconnect_full
>> >> > >>>>>>> juil. 25 17:35:06 grat-os1 iwd[530]: event: connect-info, s=
sid:
>> >> > >>>>>>> Livebox-XXXX xx.xx.xx.xx.xx.xx, signal: -45, load: 6/255
>> >> > >>>>>>> juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
>> >> > >>>>>>> autoconnect_full, new: connecting
>> >> > >>>>>>> juil. 25 17:35:06 grat-os1 iwd[530]: CMD_SET_CQM failed: Op=
eration not supported
>> >> > >>>>>>> juil. 25 17:35:10 grat-os1 iwd[530]: event: state, old: con=
necting,
>> >> > >>>>>>> new: connected
>> >> > >>>>>>> juil. 25 17:35:10 grat-os1 iwd[530]: event: roam-scan,
>> >> > >>>>>>> juil. 25 17:35:12 grat-os1 iwd[530]: event: roam-info, bss:
>> >> > >>>>>>> yy:yy:yy:yy:yy:yy, signal: -49, load: 1/255
>> >> > >>>>>>> juil. 25 17:35:12 grat-os1 iwd[530]: event: state, old: con=
nected, new: roaming
>> >> > >>>>>>> juil. 25 17:35:12 grat-os1 iwd[530]: CMD_SET_CQM failed: Op=
eration not supported
>> >> > >>>>>>> juil. 25 17:35:13 grat-os1 iwd[530]: event: state, old: roa=
ming, new: connected
>> >> > >>>>>>>
>> >> > >>>>>>> I have found one commit referring to CMD_SET_CQM it's the c=
ommit
>> >> > >>>>>>> 2dc785982d29ebd72b7cc6ed5548454f386ce222  netdev: Check
>> >> > >>>>>>> EXT_FEATURE_CQM_RSSI_LIST before sending CMD_SET_CQM
>> >> > >>>>>> There is that extended feature for RSSI lists, but most like=
ly that's
>> >> > >>>>>> not the reason because IWD will only use a single threshold =
unless your
>> >> > >>>>>> using a signal agent, which I assume your not. Looking at th=
e kernel I
>> >> > >>>>>> did find one case where driver support is checked, and if th=
at fails it
>> >> > >>>>>> returns not supported:
>> >> > >>>>>>
>> >> > >>>>>> net/mac80211/cfg.c: ieee80211_set_cqm_rssi_config()
>> >> > >>>>>>
>> >> > >>>>>> if (sdata->vif.driver_flags & IEEE80211_VIF_BEACON_FILTER &&
>> >> > >>>>>>             !(sdata->vif.driver_flags & IEEE80211_VIF_SUPPOR=
TS_CQM_RSSI))
>> >> > >>>>>>             return -EOPNOTSUPP;
>> >> > >>>>>>
>> >> > >>>>>> What hardware are you using? Also could you enable debugging=
 because it
>> >> > >>>>>> would appear that CQM is still working as you are able to ro=
am, so this
>> >> > >>>>>> error may be related to something else.
>> >> > >>>>>>
>> >> > >>>>>> Thanks,
>> >> > >>>>>>
>> >> > >>>>>> James
>> >> > >>>>>>
>> >> > >>>>>>> Best regards
>> >> > >>>>>>>
>> >> > >>>>>>> Daniel
>> >> > >>>>>>>
