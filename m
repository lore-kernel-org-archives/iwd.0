Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EC2594A8
	for <iwd@lists.linux.dev>; Fri, 20 Dec 2024 03:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667076; cv=none; b=IZsuC12ijvo9bfNP1bFgFfC5IIWAA/tuzh5krWSf8JxH9RVzaKEYWkmRdIto8OK1uE6Cyy1RtF7UQd9apDG8WPHQc7NAwsRa1ZmQguNta8nQdKW2kJOUAC+wQqXRDDZkDq03ef8mG2CyGCY0cWY2n6VNROr03d3839QWvc+Bhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667076; c=relaxed/simple;
	bh=80kCbMa5roC8FFU6p9s9CbzRSYxCVL+27U5ixEOs9Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqtGNVa7QR0xZ48PTUpRDJZi27jeqjIs54XLNoBRE2hmAYSH6SzggYm3VvrchosSSs6Puc+esoIgayfsz4ZQ3Fc/lL7PqN155T0Pl837TwucBw+eZOrHESnbg2eviyt5dav/1IlOuaZkYvrhmKKoK1bvAQtE9hxaFCmn/6dhlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQvlbwat; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQvlbwat"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so876458a12.3
        for <iwd@lists.linux.dev>; Thu, 19 Dec 2024 19:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734667074; x=1735271874; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ocWAsDCsfvC8/k5ydrxtkbjX9etylD+lcDdTnRnUbg=;
        b=JQvlbwatTUVI/cXB3WKZIiyLo6Vqy0U396YkDpk6fC2V3ITPWoKpA7eRboIY28+ysu
         6+9tpVkbB5QZa6FB89qNVG3dqxJSi5oRfADNY6gfp5IaeSsfldbVlzqpqphgLUOM3xkj
         3TGEsbS5/6uQnHZLkcI/aWTRRko3Ec12p73p2dTPKtfRii9TjoolnITLWOTfJ0gmgDI+
         a27BBnKS1/XXx9/D6jt2+8jty2HZLMSFZYo+VQ+XBulJruTXgPI9DaDWa/EmujAmj5p3
         xsZpJqXL0GAqYfjtL9/cMS2nRqKywOgO/i+YmYQ+moTOLtU7Zlh3svEsCM56y14gIirz
         7keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734667074; x=1735271874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ocWAsDCsfvC8/k5ydrxtkbjX9etylD+lcDdTnRnUbg=;
        b=sYiX5YYVsmRk+KiIQx98/ZtvdzVEUYV8AE83bN98A+0/bHpNu8dWOh44CC/qKnJoPb
         L1ficJLD65QOqgEhP9iTZZu9MFsUqos63y/L9Z5TtfjmzTm08Yk3T8joBEPld4suX+MO
         bSYzABCdmmfqfkfOqC6hvfXkGt4iC3qgU6MX6CXORHZ6uxvRt4UYLChyqPnrsgmjaxgD
         LsRa2+oGjF6tq/3VLEcoEZxohHtAvNLhNfhxGAsOfb2ycFxp6pTpza9MJNjnoyMycMmX
         LPrl7kUWvIr/2PUOqT97Db5VtzVmEW2cS4wdkyzv13zb/X9UkIPsc9gnupPg9pmbv6RC
         A0Gg==
X-Gm-Message-State: AOJu0YyZhRbiDTYbCk+loryAJGFUS2gFaPIW5dg9PMGAm2kaMxSzhZPy
	MdffyY3iiGnmDshw/GUyCoTIC1pPcRiSNQOW4twp8fu8/LxR/RJ4KM/l3C9baSWFVEEaPHos9FC
	n4Jm7QvVuWJ8w+j/jzaqf8Sztf7bAttBB
X-Gm-Gg: ASbGncvXsbMkU1adU5JURVP8aKeFZIcntAj+2yzSyyVdXNvXkwFS376FEzB8Ew5csRZ
	C3opFh6eMxnq5vfQJdhxDhw1AmoXnrBd/2HFhlg==
X-Google-Smtp-Source: AGHT+IG5INjTjo7j+wWygA7GZtA2/ItbBcaChMQm9p7XVzFRGBFikG9SCO0w7jV5DTzrWK8XDV14q2K5yfB6JjpH6uc=
X-Received: by 2002:a05:6a21:1645:b0:1e5:a79e:3c7e with SMTP id
 adf61e73a8af0-1e5e044da6emr2799836637.9.1734667073814; Thu, 19 Dec 2024
 19:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241219181701.164349-1-prestwoj@gmail.com> <ee05cb0c-d317-4bd8-8736-6ffaba6d7b62@gmail.com>
In-Reply-To: <ee05cb0c-d317-4bd8-8736-6ffaba6d7b62@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 19 Dec 2024 21:57:42 -0600
Message-ID: <CAG17S_P=O9P1EKFZk939SNQWA6-Q4dePvrrecBwHLXw6VBRKXA@mail.gmail.com>
Subject: Re: [PATCH] netdev: destroy auth-proto after external auth
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 12:18=E2=80=AFPM James Prestwood <prestwoj@gmail.co=
m> wrote:
>
> Hi Keith,
>
> On 12/19/24 10:17 AM, James Prestwood wrote:
> > With external auth there is no associate event meaning the auth proto
> > never gets freed, which prevents eapol from starting inside the
> > OCI callback. Check for this specific case and free the auth proto
> > after signaling that external auth has completed.
> > ---
> >   src/netdev.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/src/netdev.c b/src/netdev.c
> > index 02496c92..2a6d94fc 100644
> > --- a/src/netdev.c
> > +++ b/src/netdev.c
> > @@ -3483,6 +3483,13 @@ static void netdev_external_auth_sae_tx_associat=
e(void *user_data)
> >
> >       netdev_send_external_auth(netdev, MMPDU_STATUS_CODE_SUCCESS);
> >       netdev_ensure_eapol_registered(netdev);
> > +
> > +     /*
> > +      * Free the auth proto now. With external auth there is no associ=
ate
> > +      * event which is where this normally gets cleaned up.
> > +      */
> > +     auth_proto_free(netdev->ap);
> > +     netdev->ap =3D NULL;
> >   }
> >
> >   struct rtnl_data {
>
> Could you give this version of the patch a try to verify it still works
> on brcmfmac? This is just a bit simpler and more straight forward.
>
> Thanks,
>
> James
>
James,

This patch seems to work just like the previous one. I am able to get
a connection, collect a DHCP address and then ping the AP from the
RPi.

I use connman/iwd

Dec 19 21:49:45 jackrune iwd[346]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Dec 19 21:49:47 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd022 fail, reason -52
Dec 19 21:49:47 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd026 fail, reason -52
Dec 19 21:49:47 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd02a fail, reason -52
Dec 19 21:49:47 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd02e fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd034 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd038 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd03c fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd040 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd064 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd068 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd06c fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd070 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd074 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd078 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd07c fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd080 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd084 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd088 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd08c fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd090 fail, reason -52
Dec 19 21:49:48 jackrune iwd[346]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Dec 19 21:49:49 jackrune connmand[454]: Adding configuration wifi_6465736b5=
34145
Dec 19 21:49:49 jackrune connmand[454]: Adding service configuration
6465736b534145
Dec 19 21:49:49 jackrune connmand[454]: Interface wlan0 [ wifi ] state
is association
Dec 19 21:49:49 jackrune connmand[454]: ipconfig state 2 ipconfig method 1
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, ssid: deskSAE,
bss: d8:3a:dd:60:a3:0c, signal: -58, load: 0/255
Dec 19 21:49:49 jackrune iwd[346]: event: state, old:
autoconnect_full, new: connecting
Dec 19 21:49:49 jackrune connmand[454]: Interface wlan0 [ wifi ] state
is configuration
Dec 19 21:49:49 jackrune connmand[454]: ipconfig state 3 ipconfig method 1
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, External Auth
to SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {RX} 1 packets 121 bytes
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {TX} 0 packets 0 bytes
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {update} flags 69635 <UP,LOWE=
R_UP>
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd074 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd078 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd07c fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd080 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd084 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd088 fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd08c fail, reason -52
Dec 19 21:49:48 jackrune kernel: brcmfmac: brcmf_set_channel: set
chanspec 0xd090 fail, reason -52
Dec 19 21:49:48 jackrune iwd[346]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Dec 19 21:49:49 jackrune connmand[454]: Adding configuration wifi_6465736b5=
34145
Dec 19 21:49:49 jackrune connmand[454]: Adding service configuration
6465736b534145
Dec 19 21:49:49 jackrune connmand[454]: Interface wlan0 [ wifi ] state
is association
Dec 19 21:49:49 jackrune connmand[454]: ipconfig state 2 ipconfig method 1
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, ssid: deskSAE,
bss: d8:3a:dd:60:a3:0c, signal: -58, load: 0/255
Dec 19 21:49:49 jackrune iwd[346]: event: state, old:
autoconnect_full, new: connecting
Dec 19 21:49:49 jackrune connmand[454]: Interface wlan0 [ wifi ] state
is configuration
Dec 19 21:49:49 jackrune connmand[454]: ipconfig state 3 ipconfig method 1
Dec 19 21:49:49 jackrune iwd[346]: event: connect-info, External Auth
to SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {RX} 1 packets 121 bytes
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {TX} 0 packets 0 bytes
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {update} flags 69635 <UP,LOWE=
R_UP>
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {newlink} index 3
address B8:27:EB:A4:6E:0F mtu 1500
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {newlink} index 3
operstate 5 <DORMANT>
Dec 19 21:49:49 jackrune systemd-networkd[163]: wlan0: Connected WiFi
access point: deskSAE (d8:3a:dd:60:a3:0c)
Dec 19 21:49:49 jackrune iwd[346]: hardware_rekey not supported
Dec 19 21:49:49 jackrune iwd[346]: event: state, old: connecting, new:
connecting (netconfig)
Dec 19 21:49:49 jackrune systemd-networkd[163]: wlan0: Gained carrier
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {RX} 3 packets 356 bytes
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {TX} 4 packets 652 bytes
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {update} flags 69699
<UP,RUNNING,LOWER_UP>
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {newlink} index 3
address B8:27:EB:A4:6E:0F mtu 1500
Dec 19 21:49:49 jackrune connmand[454]: wlan0 {newlink} index 3 operstate 6=
 <UP>
Dec 19 21:49:50 jackrune systemd-networkd[163]: wlan0: Gained IPv6LL
Dec 19 21:49:52 jackrune iwd[346]: event: state, old: connecting
(netconfig), new: connected
Dec 19 21:49:52 jackrune systemd-resolved[316]: wlan0: Bus client set
DNS server list to: 192.168.5.1
Dec 19 21:49:52 jackrune connmand[454]: wlan0 {add} address
192.168.5.207/24 label wlan0 family 2
Dec 19 21:49:53 jackrune kernel: sh (18913): drop_caches: 3
Dec 19 21:49:54 jackrune connmand[454]: rp_filter set to 2 (loose mode
routing), old value was 0
Dec 19 21:49:54 jackrune connmand[454]: Interface wlan0 [ wifi ] state is r=
eady

# ping 192.168.5.1
PING 192.168.5.1 (192.168.5.1) 56(84) bytes of data.
64 bytes from 192.168.5.1: icmp_seq=3D1 ttl=3D64 time=3D26.7 ms
64 bytes from 192.168.5.1: icmp_seq=3D2 ttl=3D64 time=3D4.79 ms
64 bytes from 192.168.5.1: icmp_seq=3D3 ttl=3D64 time=3D4.39 ms
64 bytes from 192.168.5.1: icmp_seq=3D4 ttl=3D64 time=3D4.42 ms

# ifconfig wlan0
wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.5.207  netmask 255.255.255.0  broadcast 192.168.5.255
        ether b8:27:eb:a4:6e:0f  txqueuelen 1000  (Ethernet)
        RX packets 15  bytes 2718 (2.6 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 32  bytes 4668 (4.5 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
