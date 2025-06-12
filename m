Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BE220F2A
	for <iwd@lists.linux.dev>; Thu, 12 Jun 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736296; cv=none; b=PceMh2sJlVxhtdE6GpWT0LcaKz2sFWwpGStaCSvt9mh9LO4CMTin2G65gmCL3N8GV4mkJdFkGf8KnbmRUqKXda8wfhYEq3AJhWnlyl1POLnHgMivny1Ptm2gk9RMES++pE8VImZdY0YKliGNvysQ5fJ9TIQ7n8WfuXjfh6EQo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736296; c=relaxed/simple;
	bh=SwlEgiTYOEFffETTgQecNqgfTLK86ODS4wjcObZDWxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jx7Pk+vikHV2qL1FxnXli+0APmwetDtuS8JMARw5i9F5qFGwePl8O2TfvOBX5qNFRk/QYEDtMF94RizwlWl0wIzD6Z7E1Eycfi32XklHkRU+qIFlxc8ySZ88YgbKDnz5zw0RHATr9RQqZCUdGxEU6xFLh3l5NQ7R38NonKMjSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QigI4Kzr; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QigI4Kzr"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso844100276.1
        for <iwd@lists.linux.dev>; Thu, 12 Jun 2025 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749736294; x=1750341094; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwlEgiTYOEFffETTgQecNqgfTLK86ODS4wjcObZDWxw=;
        b=QigI4KzrukQuQ7qnrRMi474XGDeqiC0J79e8MOlACdAE1j2qqZEFkFqAu3Sf5VGdCl
         i3yGKCHPAxBKYwYAnDjT9bNVIpnenqxD3m1iGh8K2hShQGI2twhCD81bGRbiqt5B2ujf
         2qQ1dJk6FZsrwXd6wbyszC0wV1SDZ0uhuMOw5DhNjmia0d93tsIM/OG9ZIx5GLCtnN9f
         C5vAB3EWeyJU8Bt13Y7QXyrsZit2tPsiv1ouL4+f7fAVq2bf50zlsQEsYvQeK59ptJFx
         +cvj5GUzxMSKlOC5zVX3wKjfkLYprlw91wfCyIwGwCqtxc02/amwlhehQiEVPtfXKFNG
         Z/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749736294; x=1750341094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwlEgiTYOEFffETTgQecNqgfTLK86ODS4wjcObZDWxw=;
        b=FZO7eUUXhHhf5FYu6L4J+wRljwuuElKA+OrMzb5km+W8CzpewGUUYL3LQIEoAwZE+I
         SD15gFR5oeVXLh7C4SibjuYn7v7agIHSJWI+IozripQErdqwOtcRkNH0w1C4efc2/mM/
         aTKgxamZESqFulV4olBcLVvuTkpFe18j7z52UhJX0OXKh5cgUxGSYYNyLnefLC6kh+5/
         D6q3rE/qkd0LDr8cCLgAK7i8cc++R9yroO3F8NNiA4f99KbSfowxBMifK3rKKcpigWI+
         7GTQrI4TE+oaeRaCj6riaCJTJKwygp5cwhZsjjHif+ZNGABPYN7K5MEG59Ys7d8RrlZ0
         0b5w==
X-Forwarded-Encrypted: i=1; AJvYcCVfbaMCFpYzkUrX/OvHTGCe0qPN5gVR75Op9qFyjPcld4EBEgqGCdTgRg8B26vN9AhZ4Bg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2pAbTAzYP4Bkq05KYbG0sdZFum7uSscDGD0llJSOM3HD77xR6
	V2iKsFzojzx2s4lk2RMC71XcRcs4PjFmVx5ZTX2j4TG7xFfP6rWv7HNxfBkwhYft8QPwPJjc66T
	f3KR0Y2fg93vcg7jw5AQSx0czx9cl8tM=
X-Gm-Gg: ASbGncvdDMAceQkm1ucz7SRaAagMJH1zW3Kzs6B6YMubabwKs4V7WGJC6nq3RYC1rY2
	lQeAnDJiyrdyrM4/YSlOGTdw5aOYBOOUproEbegbe0CHX/LXpIkBZtcKdmplyq64llH++fmFkYN
	MPc3XvXZyJRVlmKvt2j3hk5bOWODoxLyAEnVq5/yqtFahRfw==
X-Google-Smtp-Source: AGHT+IGRNlpqSZjjUpr5a8+48CLMYRtVJNcQdkSnffvYIMOuy9MztHZ4/65IObtdwEP5mo3p1XWpaTtyk2u8/Z1isDo=
X-Received: by 2002:a05:6902:18d0:b0:e81:b872:8469 with SMTP id
 3f1490d57ef6-e820b6e9bd8mr5022669276.32.1749736293720; Thu, 12 Jun 2025
 06:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com> <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
 <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com> <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
 <19691dcb210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com>
 <1fb12821-1707-4478-941b-9fbc007c4e9a@broadcom.com> <CAG17S_M9_-TG4YnHAwx2+O2bJ6sbEE75X=V0y4Pbxy222O3ZJg@mail.gmail.com>
 <CAG17S_Njkt7rFTk4Tn-KnLVS8kzA61KJGyWgNQ9kqx5M=s7DnA@mail.gmail.com>
 <38be0ddf-50ff-4ef9-bd98-748ffcfed2e1@broadcom.com> <CAG17S_NCAmDPa+jK=OPdF18H8Yuuio3czytaa2q5hMSJiKO9bw@mail.gmail.com>
 <CAG17S_MbUsp6Nu=idnk0p9sQLRJWg=G8oaE1X2kdjwZ_uH4KAA@mail.gmail.com>
 <CAG17S_PxYNxLpAMzXOuS6riv46G22zpOM0rT0D7Xp-usbWyo+A@mail.gmail.com>
 <196b5fd2b70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAG17S_PzWmDmFekBgtBj7VHPt-g2qU0+LSa9WzYi75aNR5Mb_g@mail.gmail.com>
In-Reply-To: <CAG17S_PzWmDmFekBgtBj7VHPt-g2qU0+LSa9WzYi75aNR5Mb_g@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 12 Jun 2025 08:51:22 -0500
X-Gm-Features: AX0GCFsqlRk4wIVeAI40VyqEDoO30TKcYO8G2497BNYPdcEwcH25uQx41wgeuLc
Message-ID: <CAG17S_NMk44gBa2B=xNyjhXVJuaeYVn-+T9u_8fid+r7k--56A@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Arend,

I am still seeing this:
wpa_supplicant[431]: wlan0: Failed to initiate sched scan

I tried the brcmfmac options listed above and got no change? Still
getting this every 6 seconds in the log.
Did I get the command in the modprobe conf wrong?

On Fri, May 9, 2025 at 1:01=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> > >
> > > With this setup, things work really well and the only strange thing I
> > > am getting is a 'failed scheduled scan' message in the log every ~6
> > > sec.
> > >
> > > May 09 08:53:50 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiat=
e
> > > sched scan
> > > May 09 08:53:57 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiat=
e
> > > sched scan
> > > May 09 08:54:03 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiat=
e
> > > sched scan
> > > May 09 08:54:09 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiat=
e
> > > sched scan
> > > May 09 08:54:16 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiat=
e
> > > sched scan
> > > May 09 08:54:22 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiat=
e
> > > sched scan
> >
> > I thought wpa_supplicant had a config option to disable scheduled scan,=
 but
> > can not find it. You can disable it in brcmfmac using feature_disable=
=3D2
> > modparam.
> >
> > Regards,
> > Arend
> >
> >
> Arend,
>
> Thanks. I must be doing something wrong as I still get the 'Failed to
> initiate scan' spammed in the log with this config:
>
> # cat /etc/modprobe.d/brcmfmac.conf
> options brcmfmac feature_disable=3D0x200000
> options brcmfmac feature_disable=3D2
>
> Do I have it formatted wrong?
>
> Keith
>
> I think you suggested the the first line due to a different log
> spamming message.
