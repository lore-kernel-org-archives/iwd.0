Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A554915
	for <iwd@lists.linux.dev>; Tue,  5 Mar 2024 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634074; cv=none; b=bFRWtwiZcDN4SuO6NHsJhFNqzoMgOhekwOubmMAFVNG7LoqISIToF1DTW71+iUw5lwtBPwhG9qrTwUv+ZG6WvhH0OH2IiyKeFblE0YdkhfB8OKXpeojjUifpL8gtaIhOpFoO3iqDNqZkUrHj0WfjiIhsWyUT1+Z1KjMUvK5P+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634074; c=relaxed/simple;
	bh=UKea7BxMuJ+A7YClcCv7rZHBgdZslP4iZRsBjUPIVjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFcJoBI3u8C4e6CjYljEfT939Q4TCeGOnSkMqhV8vnK8V5sBtn/SrBuE3rNurXeLaOAm+8hB5Gn0g57Bh7E7QTZmadGfeXbGrh/rNASKlcaKqjrKE4wrOq21/PDsbXLSgEoP9u466rmoTWwvFOoO9+hRIU8pH0ACx30u+DLmR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duZ9qvxy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duZ9qvxy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56781070f38so1228201a12.0
        for <iwd@lists.linux.dev>; Tue, 05 Mar 2024 02:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709634070; x=1710238870; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/9gyTchy96ywWRy+pPbNWF4V36unaIMDq7CxZH9Yao=;
        b=duZ9qvxyT8UXsn3zBSjk9/ixWZ4pGx1Y5BOnp3gFU6TxM4WGc3Umxm6TEpwQnL5kUf
         1UGhQ2BIeP+6P04tccNOxuCHr/UvnMJHF+/vz0rtPFJc6WMEj8z+w854srzIs+y4rPb0
         7qnRj+TCTBXX13J7wI+9zYRD6XPygt1jaQAB3R7L78/wSjFtcm9O0wGybPeuz1yeQ7pN
         pxvBNzcr/kSy1oFk/yTquKMhQgJkxonJjP221OKpUzR1pBWyNcjZVTmdjwWxqlk7GfGV
         riwo4Bnt9KH8Oqq77XGNB1kne0afpHcNHWhsWZPEHDK1L83PXbRslftwoht8frERpSSa
         y4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709634070; x=1710238870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/9gyTchy96ywWRy+pPbNWF4V36unaIMDq7CxZH9Yao=;
        b=FbfDQdubbYT5P0ao/IhyaPjfmklJMUuulb79JqUTyofgLglDWYAKmZlXoLSTPCup4E
         Gh61PPHa6BrZOQrRb0uq/Ol0sgtzj0fkLXF5T85odsAKC9+7Jemqx0SxiO5mizeme9Pj
         NoINAMKN6GarXFupLTiyVx17+AhRQafEUk0B5LxJkHBeHRhtXgSgU/KNkHAXi3ybokM7
         akEtqMbEqZ4w9bs9+1dvLNEtWsINDh+DMVF68NlufPiGLiDQ4oGhQsFwHsELOHrFjQjZ
         KfL3JdeLb724VSiv+u8HcilC4jyOUr//FxRgrGObShlZ8ax0r7pNU0wiz4vANivHQz0E
         pvfQ==
X-Gm-Message-State: AOJu0Yxwc3H6v7xzKRvzEQFcIHRelJc8mYGXtTh19X/J/Tx5WEjqi49o
	K1zXApB7OQrwg9KPTohhJJ+kglXo0lzCrUiWxNPY2sLYHi8STuh5Bv1SsUPxrXrrWJ3Vf2tq0y/
	S9fi5mkPWh9nPJhSgHISRzeffYMriJwAzGNU=
X-Google-Smtp-Source: AGHT+IGZP5h96pwWnZF/7jq7O9RoiqKEsNdik2A0v7Jg0UB14qi2AFdEeT0pbqdgnGspj5pPuM4fiCcuSYBpZE+UnCA=
X-Received: by 2002:a17:906:d95:b0:a45:6d38:60aa with SMTP id
 m21-20020a1709060d9500b00a456d3860aamr2131833eji.30.1709634070277; Tue, 05
 Mar 2024 02:21:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKbf6axbkp5E1M8Pvm1SbPOQFtzxX8Cdwj9YjbYNy0aekHDHzw@mail.gmail.com>
 <1aebf48a-0ed4-4605-a03b-5f6e0706ed71@gmail.com>
In-Reply-To: <1aebf48a-0ed4-4605-a03b-5f6e0706ed71@gmail.com>
From: Kentaro Yamaguchi <kentaro.y@gmail.com>
Date: Tue, 5 Mar 2024 19:20:59 +0900
Message-ID: <CAKbf6aw-So-y=NuHTo-GqTRmjPR7pN1j8UOmHOvvRETBM-3XoA@mail.gmail.com>
Subject: Re: How to connect specifying the BSSID?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,
Thank you for answering.
I tried it right away, but unfortunately I couldn't connect to the
desired BSSID.
Even if you specify the BSSID, if the same SSID exists, it seems that
the connection will be made according to the RANK.

When I specified the BSSID on the 2GHz side below and connected, it
connected to the BSSID on the 5GHz side.
I tried it 3 times and got the same result all three times.

access point
-------------------------------------------------------
    SSID  BSSID              RSSI  Freq    Rank      MDE
---------------------------------------------------------------------------=
-----
    tp-link_be85
          4e:91:e3:xx:xx:70  -25   6135    16384     000000
          5a:91:e3:xx:xx:7d  -25   5240    16384     000000
          56:91:e3:xx:xx:7c  -6    2417    3912      000000


connection
-------------------------------------------------------
Execute the commands in the following order.

$ sudo /usr/libexec/iwd -E &
$ sudo iwctl station wlp4s0 scan
$ sudo iwctl debug wlp4s0 connect 56:91:e3:xx:xx:7c
Type the network passphrase for tp-link_be85 psk.
Passphrase: ********


Check the connection destination
-------------------------------------------------------

$ iw dev wlp4s0 link
Connected to 5a:91:e3:xx:xx:7d (on wlp4s0)
        SSID: tp-link_be85
        freq: 5240.0
        RX: 7401 bytes (70 packets)
        TX: 8867 bytes (77 packets)
        signal: -19 dBm
        rx bitrate: 1441.3 MBit/s 160MHz EHT-MCS 7 EHT-NSS 2 EHT-GI 0
        tx bitrate: 576.4 MBit/s 160MHz EHT-MCS 3 EHT-NSS 2 EHT-GI 0
        bss flags: short-slot-time
        dtim period: 1
        beacon int: 100

Thanks,

Kentaro Yamaguchi

2024=E5=B9=B43=E6=9C=884=E6=97=A5(=E6=9C=88) 21:23 James Prestwood <prestwo=
j@gmail.com>:
>
> Hi Kentaro,
>
> On 3/3/24 8:31 PM, Kentaro Yamaguchi wrote:
> > Dear iwd users and developers,
> >
> > With mesh, I would like to check whether it is faster to connect
> > directly to the child device or the parent device.
> > Therefore, please tell me how to connect using iwd from the client and
> > specifying the BSSID.
> >
> > According to the comment made 5 years ago at the link below, there is
> > no way to connect by specifying the BSSID.
> > This has been answered, but is the situation still the same?
> > https://bbs.archlinux.org/viewtopic.php?id=3D237074&p=3D5
>
> Yes IWD connections are SSID based and IWD chooses the best BSS based on
> how it ranks.
>
> For testing IWD does have a "developer mode" which lets you connect to
> BSSID's specifically but this mode isn't something meant for
> general/production use. But if you only want to test one vs the other
> you could use it:
>
> # Start IWD in developer mode (-E)
> iwd -E
> # Scan first (developer mode doesn't autoconnect)
> iwctl station wlan0 scan
> iwctl debug wlan0 get-networks
> iwctl wlan0 connect <bssid>
>
> Thanks,
>
> James
>
> >
> > I tried the following, but I was unable to connect due to an error.
> > I know that using wpa_supplicant as the Network Manager backend will
> > work. However, in that case I would like to use IWD because I have
> > problems with 6GHz connectivity.
> >
> > 1. Specify iwd as wifi.backend of NetworkManager and restart.
> > 2. nmcli device wifi connect [SSID] password [Password]
> > 3. nmcli connection down [SSID]
> > 4. nmcil connection modify [SSID] wifi.bssid [BSSID]
> > 5. nmcli connection up [SSID]
> >
> > Error (from journal log)
> > -------------------------------------
> > Mar 01 16:38:48 livazplusNetworkManager[1408]: <info>
> > [1709278728.5365] device (wlp4s0): Activation: starting connection
> > 'Buf-MLO' (019cd427-8f11-4c84-9625-db03895b510b)
> > Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
> > [1709278728.5367] device (wlp4s0): state change: disconnected ->
> > prepare (reason 'none', sys-iface-state: 'managed')
> > Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
> > [1709278728.5370] device (wlp4s0): state change: prepare -> failed
> > (reason 'none', sys-iface-state: 'managed')
> > Mar 01 16:38:48 livazplus NetworkManager[1408]: <warn>
> > [1709278728.5374] device (wlp4s0): Activation: failed for connection
> > 'Buf-MLO'
> >
> > My environment is below.
> > --------------------------------------
> > Lubuntu 23.10
> > Kernel 6.7.6
> > IWD 2.8
> > NetworkManager 1.44.2
> > Intel BE200
> > [    5.297551] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> > Version: 0.0.4.125
> > [    5.302086] iwlwifi 0000:01:00.0: loaded firmware version
> > 86.fb5c9aeb.0 gl-c0-fm-c0-86.ucode op_mode iwlmvm
> > [    5.764947] iwlwifi 0000:01:00.0: loaded PNVM version 8443a58d
> > --------------------------------------
> >
> > Thanks in advance!
> > Kentaro Yamaguchi
> >
