Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7281D6DA8
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795059; cv=none; b=MePW9bF8XS+bumfLAfQd1Id24iBwkj0hosRXUbI6HLYF92ag6ByZTA/tRta3vOuerfu2u0ORzcsbCbnRNnWn4+HJzShQFaBY3br6BebrU4TrR/uywcUirlrCn6wr0UnL2kbaVDcLEs9tcCIdJMJWBxVYF0ktpxFo0mc8GgblAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795059; c=relaxed/simple;
	bh=TyS89bElmz9znXwzVjNz4SBzyunCexsPwRDzjqr2Wqg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m6r/MIM4LnQo9+UnO8H0BLxypjLHHrIONYDYSkGY1K5eXyJbQ/O9tlXTC/yvOJHIJ+qgOd9EF8ShZF5D2bXWWBdZkyI5Rd9FQPx/JbHY5QN4/JZXx1Z6sHbC919JP1ZND3Apj24+uK+B4VZ5yqzu6mZm5UF7RL63S8tMpvY7+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L28zNeke; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L28zNeke"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso1608690a12.0
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729795055; x=1730399855; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD9NDiwE7Md6d2QvECLqmmzZ2bHfq7EXONZJ9Nteo70=;
        b=L28zNekee49iCt0/7bwyoqJe74t8Jal0x1tshHgw389MKoEI3whiRZV0kaIlF6+0R0
         yCsKhEkuaMGTCA5NK6sISujA8pK0Vp9AebMcVctOEvsP5Ay1nlE0/fO5K8DOrDFRGG93
         8QBI1YVc7e0g8Bpl6yxLFIHOBv4ywYOXCPLMrDbAORCg6+Yv2pT+j1Fppn5cRjzTwofN
         NLZqYgRH5PBXqkAwmBGHQrHri4poh5BKjLmkypJpwKB7Z+qTGC9S6uRxZd7IyrvAeTYn
         pBN2Nxc+X5kr9siXN3sxxZesegRtvlvsGyfJeDJ3NZnuTCvpcYGFwGWGpacGDS3vZP8b
         I8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795055; x=1730399855;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD9NDiwE7Md6d2QvECLqmmzZ2bHfq7EXONZJ9Nteo70=;
        b=CcMMZ3ClYvQukDZLTx2cjkR1edD0N0nlYaZvojNqn3Enz6g9KAkXXxF1RQ3qhZ0Ncb
         5EyKjvWMiqEz+0/2Qm5jlvD7G+W7lN8R5btW+xxv6m8PnVUNS3gWdkKZzLB965wjMa1t
         Rpni/4BToHfbjIHQgk/T6/WnJKCnrN6Wq6nO232Z6QVH2/XODyezchdz7g3dmwIVwoqd
         TauCL0MIcVfP8OGvWP1+uq7LJ8h6Rxe8MBsNu9aK6YNtPgKxf3t05bPoDcGkjA0MfXm9
         dDCCsh4B0FNOt0VsRu4w3kqgjS0LQFbpuVXPSK1keCa0WwkhEWrzY+CHpp9++5MukXhl
         JooQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGLwI9JXF0yKOXR0DVusS3Vh82o9XyXO2uwnPvKNiZpFYXxQzm34B74L1Ni84QY/Jwo90=@lists.linux.dev
X-Gm-Message-State: AOJu0Yysv2NbF4vvDX3ivWQo/LZqLz4rKREGCyb3LzpvuB/A9bNeNzPR
	iWnLjhXabR8uj+4xlTAmFUcMBudAaeX515HyxuN//FYMGWBzNvh+
X-Google-Smtp-Source: AGHT+IGM7qfDXqGcwwvgdBl8I8mnPW18rV+ty/S5zgq7qT1VQA+5IZfjV3ZiXW7yHrMTUemYRFB09g==
X-Received: by 2002:a17:907:9620:b0:a9a:825:4c46 with SMTP id a640c23a62f3a-a9ad275d4d7mr275279866b.28.1729795054923;
        Thu, 24 Oct 2024 11:37:34 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91598f05sm651638866b.196.2024.10.24.11.37.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2024 11:37:34 -0700 (PDT)
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
In-Reply-To: <ec368cb3-325e-4df5-aeaa-f84dc0641da6@gmail.com>
Date: Thu, 24 Oct 2024 20:37:23 +0200
Cc: Denis Kenzior <denkenz@gmail.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <14BEDE0F-7548-4C4C-876B-8E651406734C@gmail.com>
References: <CF5A13CE-18AF-4A33-98F9-13FA353657C4@gmail.com>
 <38b1af93-83c8-4cfb-ae63-5e480ac4420b@gmail.com>
 <D6BB0209-39DB-430B-977A-955928ED3701@gmail.com>
 <d27c9f76-ee7f-4509-a05e-6e05ee444181@gmail.com>
 <A112F6DF-E1BE-4350-86DD-7A85BA4FC1CA@gmail.com>
 <ec368cb3-325e-4df5-aeaa-f84dc0641da6@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)



> Wiadomo=C5=9B=C4=87 napisana przez James Prestwood =
<prestwoj@gmail.com> w dniu 24.10.2024, o godz. 18:51:
>=20
> Hi Piotr,
>=20
> On 10/24/24 7:32 AM, Piotr Oniszczuk wrote:
>>=20
>>=20
>> Btw: all was working ok few versions back of iwd/kernel
>> Unfortunately I can=E2=80=99t say which change: iwd or kernel breaks =
iwd operation on uwe5622 wifi=E2=80=A6.
>>   =20
> Thank you for the iwmon logs, that really helped diagnose the issue. =
There are a few patches on the list that I just sent which will =
hopefully fix your problem. We identified a few separate issues:
>=20
>  - Incorrect starting frequency for operating class 136
>  - No check for the correct band when checking the e4 table
>  - No check for the correct band when parsing the advertised =
frequencies from the kernel/driver
>=20
>  Your hardware seems to be advertising some frequencies [1] which are =
not exactly common and this threw IWD for a loop and exposed several =
bugs. These fixes will basically disallow those frequencies, but we need =
to take a closer look at them to be able to parse them correctly.
>=20
> [1] =
https://en.wikipedia.org/wiki/List_of_WLAN_channels#5.9_GHz_(802.11p)
>=20
> Thanks,
>=20
> James
>=20

James,=20

Fantastic work!

With patches I=E2=80=99m getting:

root@myth-frontend-0200dd63cc00:~ # iwctl
NetworkConfigurationEnabled: disabled
StateDirectory: /var/lib/iwd
Version: 3.0
[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
                               Available networks
=
--------------------------------------------------------------------------=
------
      Network name                      Security            Signal
=
--------------------------------------------------------------------------=
------
  >   WarpedNET-2.4                     psk                 ****
      WarpedNET-5                       psk                 ****
      Toshiba1                          psk                 ****
      PLAY_Swiatlowodowy_4B0F           psk                 ****
      UHF7DRX                           psk                 ****
      PLAY_Swiatlowodowy_3CC8_5G        psk                 ****

[iwd]# station wlan0 connect WarpedNET-2.4
Type the network passphrase for WarpedNET-2.4 psk.
Passphrase: ***********
[iwd]# station wlan0 show
                                 Station: wlan0
=
--------------------------------------------------------------------------=
------
  Settable  Property              Value
=
--------------------------------------------------------------------------=
------
            Scanning              no
            State                 connected
            Connected network     WarpedNET-2.4
            No IP addresses       Is DHCP client configured?
            ConnectedBss          8c:53:c3:e6:bb:8f
            Frequency             2452
            Channel               9
            Security              WPA2-Personal
            RSSI                  -49 dBm
            TxMode                802.11n
            TxMCS                 7
            TxBitrate             65000 Kbit/s

[iwd]#

Many thx for fixing this!


