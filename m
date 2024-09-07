Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB53165EE6
	for <iwd@lists.linux.dev>; Sat,  7 Sep 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734620; cv=none; b=Wu2fTzi4QmDabCkyXuXjfywZNtFGJJY6hb0hKI4MYaXruomOeIb/33AwvsW007A3o7KMfxkpFiQGJWOYijz9Q71uJ00IwijXqfBnHg01E2nq4VCS/IzLHjvWnMsVvgwiWNTJEeBA3vA7qefvrAx8hPDHgjy5QwUp1v4Io5SUO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734620; c=relaxed/simple;
	bh=WYjmNcLl2Gh7+k64KEVtdeOYH11hvbOA5MK3iK7w/HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrzYcagvKr0uTO1isqzO0BKcdnqQubY0i5a32JEGXINesHp032ce9J03Wx7NG0pxEO0zar+jnGFBao61RSrobyEVoChjdBvNdCoPDvyJrQj7oxcXO6638LBsLDyGvgYxzTx+1KC08co2l2QkV1RuTQReURcTPlNRDXQgyf/azhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqDR4Kt5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqDR4Kt5"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718a3b8a2dcso1601397b3a.2
        for <iwd@lists.linux.dev>; Sat, 07 Sep 2024 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734617; x=1726339417; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvweiBhTFRaFyA2VYKgUgMW5XcgcFF/pD1ZPx1pFtp0=;
        b=jqDR4Kt5EWnmMCI3EsJhsdI7RR/eTk/mPoMCy/87pKJycHyxTMi1QmhiiL1OoKKdQ8
         Giv1P+VFdylo3ACoarNsPfFD8DSXrJ28ki1ZzScvcnqrMx6o86nxJjca2XcZqUylhbQW
         H9xGw/9o7m6w1hKHKFaW4bMkzsYvc6v/D3ccopv6lBZJeA6TDRx3UXZT9dP+uIXYhBik
         Y5+bUfgUQ8TndFINIp2QezG3pG4nsRwH2SqPMco1Lr9vAzFTDeraj2FZJZV0fJD7WFIt
         eYqOLay9q2Z6CcbKxrrUUOL+wTiKhGpUDEXQ45xWy720YTQVxSkrRk8a0BoId9zdFxOk
         D62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734617; x=1726339417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvweiBhTFRaFyA2VYKgUgMW5XcgcFF/pD1ZPx1pFtp0=;
        b=n0xUkYOkdCVMe/75mboxKgB33DODQSOE6ib2L/JgR/GTdjfdyh1w07YWS6KtUmSUMg
         AtWKyVaSr6fK7kW8MRNERw2VgRs7H/ktd2GW693MD3ajcg6osuZ/vYL0pDsdfvm5Mwam
         3iqNsdPXl/MNs9z1RV5rXNtiXjgsNCdSd+Ya+XTvLKiJP0XtyELE2mV2XAjJpserlsOH
         u7k5FoFf7x4nPQGkm5sQchxAQ0VTj/B0oktZ3x2pQ0o6kUqcvtVRdiUnLsPwu5bG794F
         bxgUqhHV1iv/im9fDZAryJIU2TlFkznIlnuMGcDb1y+cVyfCx+SbjUjkXmP2Pb81Btec
         Susw==
X-Forwarded-Encrypted: i=1; AJvYcCVrYMVmNaRApgJwXsW2PVy1VIoepGujAZ2yW+urPsywvfz1iqLtpbGEyDLETbCSC/h3N5s=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3O2d93OnRR6TiIJx8HPnu5ig9sfjfBz8f+k6x+CEQnUhWC1xA
	xOHjkpF12Q7BWc8OIgi42B8bQtLiU8niidGuDgygiKC5KvoTlbTz3TiXwvZIbq0rDiQn6bqHabo
	IrlmyBYxXsd/jiInoaPLZYquA0o8=
X-Google-Smtp-Source: AGHT+IGlE0Di5naP5YjqhvX0tnXDcdDtPwqlz3RlVRDTg4CZj5Bsp+PKKaBBgEOFMHmOZYyHWrYs+6jra67yXMhnkBw=
X-Received: by 2002:a05:6a21:8cc5:b0:1c6:cb01:db61 with SMTP id
 adf61e73a8af0-1cf1d130f93mr6005585637.28.1725734616186; Sat, 07 Sep 2024
 11:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823174220.498594-1-denkenz@gmail.com> <CAG17S_NjMwU4=qn_jJzUJwPEOTT1H-SPVb7Re0P4fyPNUg=WqA@mail.gmail.com>
 <f36d03e4-e85a-438e-adef-b6c2da0c8f72@gmail.com> <CAG17S_P615tCPt0Jy+-BLzFx0N9JiksVXdUj4-iRAA9JTWdotg@mail.gmail.com>
 <CAG17S_Oe0_DnVZW32GrArC9XCQUHh3QEYXxvXatWQiuwV5_QkA@mail.gmail.com>
 <93c94dfc-2121-4b7d-b069-8b6ce22290fb@gmail.com> <1918f9c64c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PoX724ePjUp86pp73DyzA7TWVxK2dbg-rs-aVAWjf=Cg@mail.gmail.com>
In-Reply-To: <CAG17S_PoX724ePjUp86pp73DyzA7TWVxK2dbg-rs-aVAWjf=Cg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 7 Sep 2024 13:43:25 -0500
Message-ID: <CAG17S_N5Om4Mais_fVQouLYfwrBbLHjHResRiY04jD=b_XePJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 2:32=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Mon, Aug 26, 2024 at 11:54=E2=80=AFAM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On August 26, 2024 5:43:23 PM Denis Kenzior <denkenz@gmail.com> wrote:
> >
> > > Hi Keith,
> > >
> > >>>
> > >>> iwctl looks like it is trying something:
> > >>> [iwd]# station wlan0 connect deskSAE
> > >>> Type the network passphrase for deskSAE psk.
> > >>> Passphrase: *********
> > >>> [iwd]#
> > >>>
> > >>> but it never connects. I do notice that connman thinks it is up and
> > >>> assigns a 169.254.x.x address
> > >>>
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Netw=
ork
> > >>> is WPA3-Personal...
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver=
:
> > >>> brcmfmac using SAE.  Expect EXTERNAL_AUTH
> > >>> Aug 24 11:18:06 pi5 iwd[28085]:
> > >>> src/network.c:network_generate_sae_pt() Generating PT for Group 19
> > >>> Aug 24 11:18:06 pi5 iwd[28085]:
> > >>> src/network.c:network_generate_sae_pt() Generating PT for Group 20
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Netw=
ork
> > >>> is WPA3-Personal...
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver=
:
> > >>> brcmfmac using SAE.  Expect EXTERNAL_AUTH
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_cqm_rssi_update=
()
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_insert=
()
> > >>> Inserting work item 4
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_next()
> > >>> Starting work item 4
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, ssid: deskSAE,
> > >>> bss: d8:3a:dd:60:a3:0c, signal: -63, load: 0/255
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: event: state, old: autoconnect_full=
,
> > >>> new: connecting
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/scan.c:scan_periodic_stop()
> > >>> Stopping periodic scan for wdev 1
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: CMD_SET_CQM failed: Operation not s=
upported
> > >>> Aug 24 11:18:06 pi5 connmand[635]: Interface wlan0 [ wifi ] state i=
s
> > >>> configuration
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify(=
)
> > >>> Unicast notification External Auth(127)
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, External Auth =
to
> > >>> SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> > >>> Aug 24 11:18:06 pi5 iwd[28085]:
> > >>> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() M=
LME
> > >>> notification Frame TX Status(60)
> > >>> Aug 24 11:18:06 pi5 iwd[28085]:
> > >>> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify(=
)
> > >>> Unicast notification Frame(59)
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() M=
LME
> > >>> notification Frame TX Status(60)
> > >>> Aug 24 11:18:06 pi5 iwd[28085]:
> > >>> src/netdev.c:netdev_external_auth_sae_tx_associate()
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify(=
)
> > >>> Unicast notification Frame(59)
> > >>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_external_auth_c=
b()
> > >>> Failed to send External Auth: Invalid exchange(52)
> > >
> > > You're seeing the exact broken behavior I'm seeing.  To summarize:
> > >
> > > - IWD issues CMD_CONNECT
> > > - Firmware/Kernel sends CMD_EXTERNAL_AUTH to iwd
> > > - IWD performs SAE handshake using CMD_FRAME successfully
> > > - IWD sends CMD_EXTERNAL_AUTH with a success status_code to kernel/fi=
rmware
> > > - Kernel/Firmware rplies with error 52, Invalid Exchange.
> > >
> > >>> Aug 24 11:18:06 pi5 kernel: ieee80211 phy0:
> > >>> brcmf_cfg80211_external_auth: auth_status iovar failed: ret=3D-52
> > >>> Aug 24 11:18:46 pi5 connmand[635]: Interface wlan0 [ wifi ] state i=
s ready
> > >>> Aug 24 11:18:46 pi5 connmand[635]: wlan0 {add} address
> > >>> 169.254.242.107/16 label wlan0 family 2
> > >>>
> > >>>
> > >>> Need a log of some sort or is this adequate?
> > >
> > > No.  We need someone who can tell us how this firmware is supposed to=
 operate.
> > > Perhaps Arend can help?
> >
> > Hi Denis,
> >
> > Perhaps I can. I am working on porting/implementing this for upstream
> > linux. I guess this is running an Infineon downstream kernel, right? If
> > brcmfmac is compiled with CONFIG_BRCMDBG you can load the driver with d=
ebug
> > module param, ie.:
> >
> > # modprobe brcmfmac debug=3D0x5416
> >
> > That will log some more details. Error -52 is generic code that somethi=
ng
> > went wrong in communication with firmware. The debug level above will a=
mong
> > other things show the actual firmware error code. Another interesting t=
hing
> > shown are the firmware capabilities which can also be examined through =
debugfs.
> >
> > Regards,
> > Arend
> >
> >
>
> It appears that this is do-able on the 64 bit RPiOS installed on my Pi5:
>
> I loaded the debug parameters and used the latest iwd 2.20 with the 2
> SAE patches applied and now get this:
> first with iwd running:
> root@pi5(rw):~# nmcli dev wifi list
> IN-USE  BSSID              SSID        MODE   CHAN  RATE       SIGNAL
> BARS  SECURITY
>         00:01:02:00:00:03  deskSAE     Infra  2     65 Mbit/s  79
> =E2=96=82=E2=96=84=E2=96=86_  WPA2
> root@pi5(rw):~# nmcli --ask dev wifi connect deskSAE
> Password: =E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=
=E2=80=A2=E2=80=A2
> Error: Timeout 90 sec expired.
>
> log with iwd:
> Sep 02 13:56:18 pi5 NetworkManager[37130]: <info>  [1725303378.8140]
> device (wlan0): Activation: starting connection 'deskSAE'
> (306466e3-8c0c-4925-920f-3d5d1d24189f)
> Sep 02 13:56:18 pi5 NetworkManager[37130]: <error> [1725303378.8160]
> audit: failed to open auditd socket: Protocol not supported
> Sep 02 13:56:18 pi5 NetworkManager[37130]: <info>  [1725303378.8161]
> audit: op=3D"connection-add-activate"
> uuid=3D"306466e3-8c0c-4925-920f-3d5d1d24189f" name=3D"deskSAE" pid=3D3781=
2
> uid=3D0 result=3D"success"
> Sep 02 13:56:18 pi5 NetworkManager[37130]: <info>  [1725303378.8167]
> device (wlan0): state change: disconnected -> prepare (reason 'none',
> sys-iface-state: 'managed')
> Sep 02 13:56:18 pi5 NetworkManager[37130]: <info>  [1725303378.8170]
> device (wlan0): state change: prepare -> config (reason 'none',
> sys-iface-state: 'managed')
> Sep 02 13:56:18 pi5 iwd[37306]: event: connect-info, FullMAC driver:
> brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Sep 02 13:56:18 pi5 iwd[37306]: event: connect-info, FullMAC driver:
> brcmfmac using SAE.  Expect EXTERNAL_AUTH
> Sep 02 13:56:18 pi5 iwd[37306]: event: connect-info, ssid: deskSAE,
> bss: d8:3a:dd:60:a3:0c, signal: -55, load: 0/255
> Sep 02 13:56:18 pi5 iwd[37306]: event: state, old: autoconnect_full,
> new: connecting
> Sep 02 13:56:18 pi5 NetworkManager[37130]: <info>  [1725303378.8201]
> device (wlan0): new IWD device state is connecting
> Sep 02 13:56:18 pi5 iwd[37306]: CMD_SET_CQM failed: Operation not support=
ed
> Sep 02 13:56:18 pi5 kernel: brcmfmac: _brcmf_set_multicast_list Enter,
> bsscfgidx=3D0
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_set
> ifidx=3D0, name=3Dmcast_list, len=3D16
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 02 00 00 00 33 33 00 00 00 01 01
> 00 5e 00 00 01  ....33......^...
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_kso_control Enter: on=3D=
1
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_cfg80211_connect Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 43 expected 43
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_set
> ifidx=3D0, name=3Dallmulti, len=3D4
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 00 00 00 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 29 expected 29
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_set
> ifidx=3D0, name=3Dwpaie, len=3D22
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 30 14 01 00 00 0f ac 04 01 00 00
> 0f ac 04 01 00  0...............
> Sep 02 13:56:18 pi5 kernel: 00000010: 00 0f ac 08 80 00
>                 ......
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 44 expected 44
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_vif_set_mgmt_ie bsscfgidx
> 0, pktflag : 0x20
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_cmd_int_set ifidx=3D0,
> cmd=3D10, value=3D0
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_cfg80211_connect Applied
> Vndr IEs for Assoc request
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_cfg80211_connect ie
> (00000000da8c1efd), ie_len (34)
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 20 expected 20
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_set
> ifidx=3D0, name=3Darp_ol, len=3D4
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 09 00 00 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 27 expected 27
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dwpa_auth, len=3D4
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 00 00 04 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 29 expected 29
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dauth, len=3D4
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 03 00 00 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 25 expected 25
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dwsec, len=3D4
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 04 00 00 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 25 expected 25
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 29 expected 29
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_get
> ifidx=3D0, bsscfgidx=3D0, name=3Dwpa_auth, len=3D4, err=3D0
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 00 00 04 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dmfp, len=3D4
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 01 00 00 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 24 expected 24
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dwpa_auth, len=3D4
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 00 00 04 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 29 expected 29
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_set
> ifidx=3D0, name=3Darpoe, len=3D4
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 01 00 00 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 26 expected 26
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_configure_arp_nd_offload
> successfully configured (1) ARP offload to 0x9
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_cmd_int_set ifidx=3D0,
> cmd=3D205, value=3D0
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 20 expected 20
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_set
> ifidx=3D0, name=3Djoin_pref, len=3D8
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 04 02 08 01 01 02 00 00
>                 ........
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 34 expected 34
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_set
> ifidx=3D0, name=3Dndoe, len=3D4
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 01 00 00 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 25 expected 25
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_configure_arp_nd_offload
> successfully configured (1) ND offload to 0x9
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Djoin, len=3D70
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 07 00 00 00 64 65 73 6b 53 41 45
> 00 00 00 00 00  ....deskSAE.....
> Sep 02 13:56:18 pi5 kernel: 00000010: 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00  ................
> Sep 02 13:56:18 pi5 kernel: 00000020: 00 00 00 00 ff 00 00 00 10 00 00
> 00 40 01 00 00  ............@...
> Sep 02 13:56:18 pi5 kernel: 00000030: 90 01 00 00 ff ff ff ff d8 3a dd
> 60 a3 0c 00 00  .........:.`....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 91 expected 91
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_cfg80211_connect Exit
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_kso_control Enter: on=3D=
0
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_kso_control Enter: on=3D=
1
> Sep 02 13:56:18 pi5 iwd[37306]: event: connect-info, External Auth to
> SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_rx_event Enter:
> mmc1:0001:1: rxp=3D00000000fdc96f1d
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fweh_event_worker event
> EXT_AUTH_REQ (187) ifidx 0 bsscfg 0 addr a4:c8:5c:11:2f:b9
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fweh_event_worker
> version 2 flags 0 status 0 reason 0
> Sep 02 13:56:18 pi5 kernel: brcmutil: event payload, len=3D60
> Sep 02 13:56:18 pi5 kernel: 00000000: 00 00 d8 3a dd 60 a3 0c 07 00 00
> 00 64 65 73 6b  ...:.`......desk
> Sep 02 13:56:18 pi5 kernel: 00000010: 53 41 45 00 00 00 00 00 00 00 00
> 00 24 00 00 00  SAE.........$...
> Sep 02 13:56:18 pi5 kernel: 00000020: 00 00 00 00 00 00 00 00 e0 86 19
> 00 7a 35 18 00  ............z5..
> Sep 02 13:56:18 pi5 kernel: 00000030: e0 86 19 00 7a 35 18 00 03 00 00
> 00              ....z5......
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_notify_ext_auth_request
> Enter: event EXT_AUTH_REQ (187) received
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_cfg80211_mgmt_tx Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 20 expected 20
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_cmd_int_get ifidx=3D0,
> cmd=3D29, value=3D1
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_cfg80211_mgmt_tx Auth
> frame, cookie=3D0, fc=3D00b0, len=3D104, channel=3D12626
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dmgmt_frame, len=3D136
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 00 00 00 00 a0 0f 00 00 68 00 b0
> 00 52 31 d8 3a  ........h...R1.:
> Sep 02 13:56:18 pi5 kernel: 00000010: dd 60 a3 0c d8 3a dd 60 a3 0c 00
> 00 00 00 00 00  .`...:.`........
> Sep 02 13:56:18 pi5 kernel: 00000020: 03 00 01 00 00 00 13 00 8c 8c d6
> 84 5b 94 b5 0e  ............[...
> Sep 02 13:56:18 pi5 kernel: 00000030: 51 2b 0d 9d a0 78 14 bb 93 25 de
> 7e c3 69 32 0e  Q+...x...%.~.i2.
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 163 expected 163
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_rx_event Enter:
> mmc1:0001:1: rxp=3D00000000cc427a80
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fweh_event_worker event
> MGMT_FRAME_TXSTATUS (189) ifidx 0 bsscfg 0 addr a1:e5:f5:86:a2:ba
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fweh_event_worker
> version 2 flags 0 status 0 reason 0
> Sep 02 13:56:18 pi5 kernel: brcmutil: event payload, len=3D4
> Sep 02 13:56:18 pi5 kernel: 00000000: 00 00 00 00
>                 ....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_notify_mgmt_tx_status
> Enter: event MGMT_FRAME_TXSTATUS (189), status=3D0
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_cfg80211_mgmt_tx TX Auth
> frame operation is success
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_rx_event Enter:
> mmc1:0001:1: rxp=3D00000000cc427a80
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fweh_event_worker event
> EXT_AUTH_FRAME_RX (188) ifidx 0 bsscfg 0 addr d8:3a:dd:60:a3:0c
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fweh_event_worker
> version 2 flags 0 status 0 reason 0
> Sep 02 13:56:18 pi5 kernel: brcmutil: event payload, len=3D144
> Sep 02 13:56:18 pi5 kernel: 00000000: 00 01 10 01 ff ff ff c9 00 01 46
> 35 00 01 00 02  ..........F5....
> Sep 02 13:56:18 pi5 kernel: 00000010: b0 00 3a 01 d8 3a dd d2 ae 3c d8
> 3a dd 60 a3 0c  ..:..:...<.:.`..
> Sep 02 13:56:18 pi5 kernel: 00000020: d8 3a dd 60 a3 0c 20 88 03 00 01
> 00 00 00 13 00  .:.`.. .........
> Sep 02 13:56:18 pi5 kernel: 00000030: d1 ae 95 46 66 ea 04 6f 59 0a 2c
> 5e d4 e9 d6 2e  ...Ff..oY.,^....
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_notify_auth_frame_rx
> Enter: event EXT_AUTH_FRAME_RX (188) received
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 22 expected 22
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_cmd_data Firmware
> error: BCME_NOTASSOCIATED (-17)
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_fil_cmd_data_get ifidx=3D0,
> cmd=3D23, len=3D6, err=3D-52
> Sep 02 13:56:18 pi5 kernel: brcmutil: data
> Sep 02 13:56:18 pi5 kernel: 00000000: 00 00 00 00 00 00
>                 ......
> Sep 02 13:56:18 pi5 kernel: brcmfmac: brcmf_sdio_kso_control Enter: on=3D=
0
> Sep 02 13:57:48 pi5 polkitd[551]: Unregistered Authentication Agent
> for unix-process:37812:208342 (system bus name :1.1193, object path
> /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8)
> (disconnected from bus)
>
> Now trial with wpa_supplicant:
> root@pi5(rw):~# nmcli --ask dev wifi connect deskSAE
> Password: =E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=
=E2=80=A2=E2=80=A2
> Device 'wlan0' successfully activated with
> '87cd00bc-9664-4827-8a00-d98bcb7b9877'.
>
> Log with wpa_supplicant and a connect:
> Sep 02 14:08:10 pi5 kernel: brcmfmac: brcmf_cfg80211_escan_handler
> ESCAN Partial result
> Sep 02 14:08:10 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:08:10 pi5 kernel: brcmfmac: brcmf_rx_event Enter:
> mmc1:0001:1: rxp=3D0000000039214d1f
> Sep 02 14:08:10 pi5 kernel: brcmfmac: brcmf_fweh_event_worker event
> ESCAN_RESULT (69) ifidx 0 bsscfg 0 addr d8:3a:dd:60:a3:0c
> Sep 02 14:08:10 pi5 kernel: brcmfmac: brcmf_fweh_event_worker
> version 2 flags 0 status 8 reason 0
> Sep 02 14:08:10 pi5 kernel: brcmutil: event payload, len=3D208
> Sep 02 14:08:10 pi5 kernel: 00000000: d0 00 00 00 6d 00 00 00 34 12 01
> 00 6d 00 00 00  ....m...4...m...
> Sep 02 14:08:10 pi5 kernel: 00000010: c4 00 00 00 d8 3a dd 60 a3 0c 64
> 00 11 04 07 64  .....:.`..d....d
> Sep 02 14:08:10 pi5 kernel: 00000020: 65 73 6b 53 41 45 00 00 00 00 00
> 00 00 00 00 00  eskSAE..........
> Sep 02 14:08:10 pi5 kernel: 00000030: 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00  ................
> Sep 02 14:08:10 pi5 kernel: brcmfmac: brcmf_cfg80211_escan_handler
> ESCAN Partial result
> ...
> this was what I think was the snippet where it connected with the SSID
> after NetworkManager was restarted:
>
> Sep 02 14:17:14 pi5 wpa_supplicant[43594]: wlan0: Trying to associate
> with SSID 'deskSAE'
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_cfg80211_connect Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_set
> ifidx=3D0, name=3Dwpaie, len=3D44
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 30 2a 01 00 00 0f ac 04 01 00 00
> 0f ac 04 01 00  0*..............
> Sep 02 14:17:14 pi5 kernel: 00000010: 00 0f ac 08 c0 00 01 00 c9 b9 cd
> 8f 08 b5 a5 a0  ................
> Sep 02 14:17:14 pi5 kernel: 00000020: b2 c0 3a f3 1e ef d4 12 00 0f ac
> 06              ..:.........
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 66 expected 66
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_vif_set_mgmt_ie bsscfgidx
> 0, pktflag : 0x20
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_cfg80211_connect Applied
> Vndr IEs for Assoc request
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_cfg80211_connect ie
> (00000000c11a8d64), ie_len (79)
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dwpa_auth, len=3D4
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 00 00 04 00
>                 ....
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 29 expected 29
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dauth, len=3D4
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 00 00 00 00
>                 ....
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 25 expected 25
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dwsec, len=3D4
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 04 00 00 00
>                 ....
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 25 expected 25
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 29 expected 29
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_get
> ifidx=3D0, bsscfgidx=3D0, name=3Dwpa_auth, len=3D4, err=3D0
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 00 00 04 00
>                 ....
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dmfp, len=3D4
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 02 00 00 00
>                 ....
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 24 expected 24
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Dwpa_auth, len=3D4
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 00 00 04 00
>                 ....
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 29 expected 29
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_cmd_int_set ifidx=3D0,
> cmd=3D205, value=3D0
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 20 expected 20
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_set
> ifidx=3D0, name=3Djoin_pref, len=3D8
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 04 02 08 01 01 02 00 00
>                 ........
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 34 expected 34
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_bsscfg_data_set
> ifidx=3D0, bsscfgidx=3D0, name=3Djoin, len=3D70
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 07 00 00 00 64 65 73 6b 53 41 45
> 00 00 00 00 00  ....deskSAE.....
> Sep 02 14:17:14 pi5 kernel: 00000010: 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00  ................
> Sep 02 14:17:14 pi5 kernel: 00000020: 00 00 00 00 ff 00 00 00 10 00 00
> 00 40 01 00 00  ............@...
> Sep 02 14:17:14 pi5 kernel: 00000030: 90 01 00 00 ff ff ff ff d8 3a dd
> 60 a3 0c 00 00  .........:.`....
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 91 expected 91
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_cfg80211_connect Exit
> Sep 02 14:17:14 pi5 NetworkManager[57939]: <info>  [1725304634.0622]
> device (wlan0): supplicant interface state: scanning -> associating
> Sep 02 14:17:14 pi5 NetworkManager[57939]: <info>  [1725304634.0622]
> device (p2p-dev-wlan0): supplicant management interface state:
> scanning -> associating
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_kso_control Enter: on=3D=
0
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_kso_control Enter: on=3D=
1
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_rx_event Enter:
> mmc1:0001:1: rxp=3D0000000062bff4bd
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fweh_event_worker event
> LINK (16) ifidx 0 bsscfg 0 addr d8:3a:dd:60:a3:0c
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fweh_event_worker
> version 2 flags 1 status 0 reason 0
> Sep 02 14:17:14 pi5 kernel: brcmutil: event payload, len=3D22
> Sep 02 14:17:14 pi5 kernel: 00000000: 30 14 01 00 00 0f ac 04 01 00 00
> 0f ac 04 01 00  0...............
> Sep 02 14:17:14 pi5 kernel: 00000010: 00 0f ac 08 c0 00
>                 ......
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_kso_control Enter: on=3D=
0
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_kso_control Enter: on=3D=
1
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_rx_event Enter:
> mmc1:0001:1: rxp=3D00000000aafdfb7d
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fweh_event_worker event
> SET_SSID (0) ifidx 0 bsscfg 0 addr d8:3a:dd:60:a3:0c
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fweh_event_worker
> version 2 flags 0 status 0 reason 0
> Sep 02 14:17:14 pi5 kernel: brcmutil: event payload, len=3D7
> Sep 02 14:17:14 pi5 kernel: 00000000: 64 65 73 6b 53 41 45
>                 deskSAE
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_bss_connect_done Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 wpa_supplicant[43594]: wlan0: Associated with
> d8:3a:dd:60:a3:0c
> Sep 02 14:17:14 pi5 wpa_supplicant[43594]: wlan0:
> CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 539 expected 539
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_get
> ifidx=3D0, name=3Dassoc_info, len=3D512, err=3D0
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 66 00 00 00 20 00 00 00 00 00 00
> 00 31 04 0a 00  f... .......1...
> Sep 02 14:17:14 pi5 kernel: 00000010: 00 00 00 cc 00 00 11 04 00 00 01
> c0 0c 64 00 11  .............d..
> Sep 02 14:17:14 pi5 kernel: 00000020: 04 07 64 65 73 6b 53 41 45 00 00
> 00 00 00 00 00  ..deskSAE.......
> Sep 02 14:17:14 pi5 kernel: 00000030: 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00  ................
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 542 expected 542
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_get
> ifidx=3D0, name=3Dassoc_req_ies, len=3D512, err=3D0
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 00 07 64 65 73 6b 53 41 45 01 08
> 82 84 8b 96 24  ..deskSAE......$
> Sep 02 14:17:14 pi5 kernel: 00000010: 30 48 6c 32 04 0c 12 18 60 21 02
> 03 14 24 02 01  0Hl2....`!...$..
> Sep 02 14:17:14 pi5 kernel: 00000020: 0b 30 2a 01 00 00 0f ac 04 01 00
> 00 0f ac 04 01  .0*.............
> Sep 02 14:17:14 pi5 kernel: 00000030: 00 00 0f ac 08 c0 00 01 00 c9 b9
> cd 8f 08 b5 a5  ................
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 543 expected 543
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_get
> ifidx=3D0, name=3Dassoc_resp_ies, len=3D512, err=3D0
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 01 08 82 84 8b 96 0c 12 18 24 32
> 04 30 48 60 6c  .........$2.0H`l
> Sep 02 14:17:14 pi5 kernel: 00000010: 7f 08 04 00 00 00 00 00 00 40 82
> 84 8b 96 24 30  .........@....$0
> Sep 02 14:17:14 pi5 kernel: 00000020: 48 6c 32 04 0c 12 18 60 21 02 03
> 14 24 02 01 0b  Hl2....`!...$...
> Sep 02 14:17:14 pi5 kernel: 00000030: 30 2a 01 00 00 0f ac 04 01 00 00
> 0f ac 04 01 00  0*..............
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 43 expected 43
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_iovar_data_get
> ifidx=3D0, name=3Dwme_ac_sta, len=3D16, err=3D0
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: 03 a4 00 00 27 a4 00 00 42 43 5e
> 00 62 32 2f 00  ....'...BC^.b2/.
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_update_bss_info Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_isr Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed on
> rxctl frame, got 2064 expected 2064
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_fil_cmd_data_get ifidx=3D0,
> cmd=3D136, len=3D2048, err=3D0
> Sep 02 14:17:14 pi5 kernel: brcmutil: data
> Sep 02 14:17:14 pi5 kernel: 00000000: cd 00 00 00 6d 00 00 00 cc 00 00
> 00 d8 3a dd 60  ....m........:.`
> Sep 02 14:17:14 pi5 kernel: 00000010: a3 0c 64 00 11 04 07 64 65 73 6b
> 53 41 45 00 00  ..d....deskSAE..
> Sep 02 14:17:14 pi5 kernel: 00000020: 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00  ................
> Sep 02 14:17:14 pi5 kernel: 00000030: 00 00 00 00 00 00 00 00 0c 00 00
> 00 82 84 8b 0c  ................
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_update_bss_info Exit
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_bss_connect_done Exit
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_net_setcarrier Enter,
> bsscfgidx=3D0 carrier=3D1
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_txflowblock_if enter:
> bsscfgidx=3D0 stop=3D0x4 reason=3D4 state=3D0
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txdata Enter:
> pkt: data 00000000e74f6ccc len 161
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_bus_txdata deferring pkt=
q len 0
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_sendfromq Enter
> Sep 02 14:17:14 pi5 kernel: brcmfmac: brcmf_sdio_txpkt Enter
> Sep 02 14:17:14 pi5 wpa_supplicant[43594]: wlan0: WPA: Key negotiation
> completed with d8:3a:dd:60:a3:0c [PTK=3DCCMP GTK=3DCCMP]
> Sep 02 14:17:14 pi5 wpa_supplicant[43594]: wlan0: CTRL-EVENT-CONNECTED
> - Connection to d8:3a:dd:60:a3:0c completed [id=3D0 id_str=3D]
> Sep 02 14:17:14 pi5 NetworkManager[57939]: <info>  [1725304634.2164]
> device (wlan0): supplicant interface state: associating -> completed
> Sep 02 14:17:14 pi5 NetworkManager[57939]: <info>  [1725304634.2165]
> device (wlan0): Activation: (wifi) Stage 2 of 5 (Device Configure)
> successful. Connected to wireless network "deskSAE"
> Sep 02 14:17:14 pi5 NetworkManager[57939]: <info>  [1725304634.2166]
> device (p2p-dev-wlan0): supplicant management interface state:
> associating -> completed
> Sep 02 14:17:14 pi5 NetworkManager[57939]: <info>  [1725304634.2167]
> device (wlan0): state change: config -> ip-config (reason 'none',
> sys-iface-state: 'managed')
> Sep 02 14:17:14 pi5 NetworkManager[57939]: <info>  [1725304634.2170]
> dhcp4 (wlan0): activation: beginning transaction (timeout in 45
> seconds)

Is more needed? I can collect whatever logs are needed.

Keith
