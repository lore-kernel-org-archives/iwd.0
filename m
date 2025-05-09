Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56E2033A
	for <iwd@lists.linux.dev>; Fri,  9 May 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813696; cv=none; b=cca9PrqOQlq7zODCyQg/QuGY7cV/kFpM910H5ETxBla94Loi0RwcrMAw82IxI07tGiwM1/g5wMtgW4S2+knyWFmrktw6Gfp+wUVeV7ntOn0CEx2TZYoMAqv3ay3qncQXhhW7FTkWavVCsiArHsavPQGiLyVDC1OfvTIP/Vif310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813696; c=relaxed/simple;
	bh=XddP2xmdXDMBTK5zlyhAu4kURfZ/GINz1PWbEXshEeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpB0yBjl0fDaVPDNsQpH6JZb0GbPytWCyRxw0W+hor4r66gXC2FRu9l6iEcppXhkVgXLpry6JIdjoA9YaaTqu2urfcYH6mbXUxT5tDcbhowEQijjof/wYi58Xut5uKTSmNhSeznowRG3wqG2NhRxgdMTlhuFGOqoXz0f+yJt+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlf9KiLs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlf9KiLs"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30abb2d5663so2425455a91.2
        for <iwd@lists.linux.dev>; Fri, 09 May 2025 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746813694; x=1747418494; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XddP2xmdXDMBTK5zlyhAu4kURfZ/GINz1PWbEXshEeU=;
        b=Dlf9KiLsCWw3Jti9Lfpo0k+KR8DCz/kUdMz8vbO8vHf6oPqDhNGMvnTVYExvv5KeX4
         v/amickhfkRazQDfsp+yx27E7hj0mq8Mt6Zrda+rEZPqGVASS6Be7A3aUQXDR01TfxC4
         qr1RLWiWq/SJKavaLpIO21J9dHCp6ggq19z9BuFzl3oKRM+i+B/Mm2ZVekdMz73H25mz
         Fgoq0lulNdSBcvG9zQVp6eeI7WKg+1vvc1x96usN+SmoUIMvLgFyqKlJ/2eJ3LuuwBcb
         x/3zo6zhMAcMKH6bLKK0YiLexLY9adFhQfSBhRdcwn8Dc9/QW88bMEhB1H+xEL1J+Y2M
         KrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746813694; x=1747418494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XddP2xmdXDMBTK5zlyhAu4kURfZ/GINz1PWbEXshEeU=;
        b=pFCfomwo8/NcPAcS95v7kvmvBJu5qqQyJ/rgQHH+GClbsFxDu7T7rrZRVLLt+PhzOo
         h3TkuwpfWrvl06P2VoW5b6wTyxB8QjRQ+fNLF4+r1n6AnG/5sk3yB7OomG+N7r9YoZEp
         8goz1lRixU16A1yZ+RzhYI6Cynh0CCTi722Wfk3f6G7lul+0EqXp4HMObrHWBjnrGQh3
         2IaJklgXLRBXXqBvxrqnUnvxQZpFygpxzUC2pp9o0RDx8yQpULNhmUqqZp8dhTLFTC3p
         acOrxW4Ea1NcFvVMQcN27KLvDKMGOTn7ZNhJ5SPguTQaVNHierWr10oLw5R9yzDa9UZk
         +atg==
X-Forwarded-Encrypted: i=1; AJvYcCV9pXZtPdhSIFz4UmdzjJis7g1EH2JccNvMOZ++xjp3mksCopRCfuLc5s8A7J6EQAhevmc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzBxBUXJ2VqZl6pUgkkyGM4nppg0YqDEKw9dRnkP+QzlBUFslJj
	77kZb1gI0ygPnOQPopF4NfD+f+vniKKlc/BJEbl3peW+5ApB7Bl2/IraFeGbZzKIt/bnVdlJfzi
	//tQ2v8BdZ0/9grCL+uEbarVY6Bg=
X-Gm-Gg: ASbGncvJDa+pnjh5w66WVS668YhWhEDvVLbiH2B7rKkSjz87aJVCeERDG8iCGevvg1/
	jipXChaAaZft3rtboT22lAUtP3sDCeLpwTMk4YhBQGxhdOrwyLj7tKE6aLSam2JXAZoRn3GAzjE
	ZXfOIiLSJbtE98gx0YX+nB+Bvs
X-Google-Smtp-Source: AGHT+IGJNXtwXz/WkgjkCZznCB+n7jA/GyPMQ1QlNeJioLKLPSAOCdFsN8sgk4yNXEhkCdlYKMRYqj1YQdilJq/0U4Y=
X-Received: by 2002:a17:90b:1810:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-30c3cff2aa5mr6886478a91.8.1746813694344; Fri, 09 May 2025
 11:01:34 -0700 (PDT)
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
 <CAG17S_PxYNxLpAMzXOuS6riv46G22zpOM0rT0D7Xp-usbWyo+A@mail.gmail.com> <196b5fd2b70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <196b5fd2b70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 9 May 2025 13:01:22 -0500
X-Gm-Features: ATxdqUGhjrVh0ZK_5dP30zn_BlRVWAgJIha7SpupKR9DrA9kMfIO2CCw4ntbjxs
Message-ID: <CAG17S_PzWmDmFekBgtBj7VHPt-g2qU0+LSa9WzYi75aNR5Mb_g@mail.gmail.com>
Subject: Re: brcmfmac disconnects when iwd scans
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> >
> > With this setup, things work really well and the only strange thing I
> > am getting is a 'failed scheduled scan' message in the log every ~6
> > sec.
> >
> > May 09 08:53:50 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> > sched scan
> > May 09 08:53:57 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> > sched scan
> > May 09 08:54:03 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> > sched scan
> > May 09 08:54:09 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> > sched scan
> > May 09 08:54:16 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> > sched scan
> > May 09 08:54:22 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
> > sched scan
>
> I thought wpa_supplicant had a config option to disable scheduled scan, but
> can not find it. You can disable it in brcmfmac using feature_disable=2
> modparam.
>
> Regards,
> Arend
>
>
Arend,

Thanks. I must be doing something wrong as I still get the 'Failed to
initiate scan' spammed in the log with this config:

# cat /etc/modprobe.d/brcmfmac.conf
options brcmfmac feature_disable=0x200000
options brcmfmac feature_disable=2

Do I have it formatted wrong?

Keith

I think you suggested the the first line due to a different log
spamming message.
