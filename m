Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F31B4F02
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764278; cv=none; b=YLPrShhSLZNz4DKb1C+K0QDnzGFfvhuO02G/OYqUZBoLK8QImJl04dauSdHSJYK1t/X/RELvF/W3f/PWBQB472TKtkBPku2/0pSptR7/sHHqbVTyiG3gEvZR695FzlfKIGrX9g5+qyX4enNYz/5LN06kaOJ4+nWBZ5G2SjLUcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764278; c=relaxed/simple;
	bh=u8/QroND86c5ZF2zmJya43eI0c/JX+rKKMoaGEgEWUQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LObisi/a9Np4/UIajTnTusoDdau8NUnn8CCt+pA40rWcidBcUTgsCyA/OiNl37f0qC4SGnI6YWP4VUvh47nE8XriM+dGBD+3Y42AsmkCohA9ASui9H5rhBrHyosL1UjfnkVzYW+CK5s5a4E9pqnjTs7zWgdrHUn7aZSFXlaBMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDAXZcMG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDAXZcMG"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f629a7aaso118027466b.1
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729764274; x=1730369074; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dlB5+xkTqvo2v9RiHyLVAgvU3yQukVyG0p4dot1Rcs=;
        b=JDAXZcMGmrON11Sb+abf9y/jizP+zgB8aioAzZaqUCgZxxxT7Pp6MOvD4BjKBcem8b
         umsOW3RsLfOQf0u2iVA1l86WJ6zHz1szOZ8t6KRDd8SFf2c6MReqq2Ea7uwoJX2QTQjI
         2vHQHEsX4PbwF1oufP0u46+PAnfkCa/oJuAPY6hEi/LFw+uvA2QFYxhXPvzGpYTtK0Hl
         0NnDh+PyFHsP95iDKvyAluctesnEKjMh56UMWX1TwcHRoDUc2S8ssEx4CDcbfMFMHlFq
         g0YSLjdfbteINQUdaNLyi3xc/s2O5AlwPYINNQHieLP79Lwc64qaSqcFG6Zu34wmAATi
         9CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729764274; x=1730369074;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dlB5+xkTqvo2v9RiHyLVAgvU3yQukVyG0p4dot1Rcs=;
        b=GDm1UQyyJ8zE8KTnTOlTXwl0XFzsMzS2wU7MW93Fo9T2JBAJocQU8IUDemYRCTdVRb
         fH9tcq1wcqFDm2G2jEL27d9b1ohAdBq+a0uYgUI0Ngjg46UH/ZZWS6ltxLDMcqP+NqvB
         6SvWIx/pKVcjz68qCF9alrUgnj+HHNDC5xwgs2FgK7+pAVVFirym6Xi5/7XNs1sKG98j
         vCC6x7mcXVf/JXQIXUQmRHJVhA6fMY/XfgDaMLi/0sfvhlyI0ObMMKEpvXC5A8zoYRBk
         3qASn1Re7QhRZ0SUGEoNVJP4Dd4Siu/TrLAblHyDEfOqCxzywuzP2r4Q+wdTQEZsmv1A
         Hmlg==
X-Gm-Message-State: AOJu0YyZyyG1p9AsBGlGl339uRxNwrcGFPZ9FyFQDRkcFZbOGDvJ27Ud
	Jg4U4zcK7T14fmpmQODAFxBeaEj76u1/J6FtP78qFF/UL5iKQscy91bjuA==
X-Google-Smtp-Source: AGHT+IFtSTmVZ3LCCd/2S8f+r4a8xdSBpBSNwZruLRFXUBDmMdqbYUEkDc57rdAFGs/zNUiejgJ0jg==
X-Received: by 2002:a17:907:1c84:b0:a9a:8263:d2c7 with SMTP id a640c23a62f3a-a9ad199c2c5mr154918066b.7.1729764274180;
        Thu, 24 Oct 2024 03:04:34 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912f65e9sm594540866b.74.2024.10.24.03.04.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2024 03:04:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: iwd 2.22 scan fails but... works ok with ConnMan
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <38b1af93-83c8-4cfb-ae63-5e480ac4420b@gmail.com>
Date: Thu, 24 Oct 2024 12:04:22 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6BB0209-39DB-430B-977A-955928ED3701@gmail.com>
References: <CF5A13CE-18AF-4A33-98F9-13FA353657C4@gmail.com>
 <38b1af93-83c8-4cfb-ae63-5e480ac4420b@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Denis,
thx for picking this up :)
pls see inline

> Wiadomo=C5=9B=C4=87 napisana przez Denis Kenzior <denkenz@gmail.com> w =
dniu 24.10.2024, o godz. 00:04:
>=20
> Hi Piotr,
>=20
> On 10/15/24 3:56 AM, Piotr Oniszczuk wrote:
>> Hi,
>> I=E2=80=99m using iwd 2.22 as default way of automated wifi =
connection in my project (https://github.com/warpme/minimyth2)
>> Some of my users started to report issues about not able to establish =
wifi connections.
>> I asked to do 1st step verification: launch ConnMan =
(https://wiki.archlinux.org/title/ConnMan) to verify is HW working ok.
>> With ConnMan users are able to connect so HW is OK.
>> It looks to me like issue is specific to iwd.
>> With iwd log says like below.
>> May somebody from iwd team help me to solve this issue?
>=20
> What hardware is being used?


this is allwinner h618 zero3 sbc with uwe5622 wifi chip.
Kernel is 6.11.5 with uwe5622 driver backported from vendor bsp =
(https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.11/=
files/0630-net-wireless-add-uwe5622-support-v20231020.patch)


>  Can you include iwmon output?
> =
https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html#iwmo=
n

Trying to use iwmon shows me:

root@myth-frontend-0200dd63cc00:~ # ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq qlen 1000
    link/ether 02:00:dd:63:cc:00 brd ff:ff:ff:ff:ff:ff
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast =
qlen 1000
    link/ether 24:b7:2a:45:f4:e5 brd ff:ff:ff:ff:ff:ff
root@myth-frontend-0200dd63cc00:~ # iwmon -i wlan0
Wireless monitor ver 3.0
Failed to create monitor interface wlan0: Unknown error -17
root@myth-frontend-0200dd63cc00:~ #

