Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3652BAE5
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027676; cv=none; b=YRsFASP347OpbJH7bca8timTyi7rWyui5KfIQdTiSTv0XNu9sRD/2Wf49ILDVpaNct/4S4cbNIWSnQnGuSjUX2lVwHzvR2Rji0fdD7+gK1uztPcJec2jZd33cm9YbFF4zrhk174N4n+GNOJ2i6RuizoKWlNClA7nwljN9z7EJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027676; c=relaxed/simple;
	bh=DF0D3ZabeGBB2XiK8I8g17U/1PeDUrfXzsW/TPitkMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bg9cIa8gP2pXvSbUST8e8hc8yg8XlxRPIo12hBgLv1A2UiDMNNU5bDFYLKyzwB5dPjla1+zcnflqAYkFsrhx0NozRaCcqjNZcOwB7SnmxCKqSlyaFhxoevaO6RdPF6EceuVSB8NT97s/B24bP57irGCeZtCJx94rzT/X3nj504s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCEHqUW1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCEHqUW1"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43d18a7c1deso18432801cf.0
        for <iwd@lists.linux.dev>; Mon, 06 May 2024 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715027673; x=1715632473; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQfUg2QSO7VHgp3lDjn/ORhfDIukBi+3JO6sLykD3ig=;
        b=YCEHqUW1fa8NCUwwjzCyCPOFNE7grd51xx3eLHPOPHsepYMCVmH0pUXwD5pTmqWVWR
         3x9FJwRoe5R0jmdwrupsDfYIfilH/A5nZJdBXlzbhfukzON/zKRlyzciy23TBcZQFI27
         X8a5PpfQ+J0jq6Evrz7jrFVMENLGn0N7tmM7a03I5PFjZWGLudYGb/moNLF4d0eD79d9
         f+OJfZTA3Gq9pwnSVzEQDQSGM+ut1vyKxB6fJRk/L0W19pguoD+6Ys7DiVncVeMVKoA4
         U9PF+VHp3vDkGFUiOYqKLKI0nudnwpPl7eR+orifMtphb/DhjLJPPRA2klt47SBYN7kG
         EmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027673; x=1715632473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQfUg2QSO7VHgp3lDjn/ORhfDIukBi+3JO6sLykD3ig=;
        b=NLtcAhj6VPXSkdRShcRp0SdT040lo9jyeHANC+6vUFXrdWwYfk+LFCiIpP05cAEp9A
         bF7GRdpvw1Bos4aLCvUvMI6nEcazqu6Jvv6JVtqJMNJdXPysUa9gySwpwKcY1xViXixt
         iirn0AOJ8KumB+VS3wc4NPJJLiGDEVfkB2T5Y/aUbnnsXwPlOSJtFUScUOLSLtLO4Fd4
         h9CX8o5/AXhB9XjKZOznQ7p1JB6ZJVeM93AxG0oIBMQakE4UozgS2hUjf4v7w0q3PCBt
         fUBgFx5ZAG2UrNLfdcUxzYw9PsOwJpGcUHg4BSwlICCi0/7AADthwUq0z4tH6RDOvfJZ
         f9/Q==
X-Gm-Message-State: AOJu0Yxb9i8acIO8aorPD9baZ2pSg/Sg/FhkeeC4vPzFEEZnvyuMdvuY
	3JVbzBSdmnoCZJNhdbCVoxl8CLov1CwIaYlc37Wova5juO7B7NaGfK6z2RDB+Me8eW2FGhrpE4R
	it/F9FY733YHuhRS1M5Id/PJXuYw=
X-Google-Smtp-Source: AGHT+IGmVMnoNvoyHIat3h/tw3C5/b4azZfsZKpfXTAy7gbS3lVVN9qgocvDInMrNW7hh1DssT9m8oPlMNQw2IHivtk=
X-Received: by 2002:a05:622a:138a:b0:43b:14a:f9ac with SMTP id
 o10-20020a05622a138a00b0043b014af9acmr1311006qtk.14.1715027673456; Mon, 06
 May 2024 13:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
 <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com>
In-Reply-To: <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 6 May 2024 14:34:22 -0600
Message-ID: <CADvTj4pHyYewHzSUF+546JPO6Y0Co+QfFcBbJEctNWQBNJmb=A@mail.gmail.com>
Subject: Re: NetworkManager connection gets stuck in pending state when
 bringing up AP mode connection with IWD backend
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:15=E2=80=AFPM James Prestwood <prestwoj@gmail.com>=
 wrote:
>
> Hi James,
>
> On 5/6/24 12:11 PM, James Hilliard wrote:
> > It's a bit unclear if this is a NetworkManager bug or an IWD bug but
> > I'm unable to successfully bring up AP mode connection in
> > NetworkManager when using the IWD backend.
> >
> > It appears that NetworkManager fails to recognize that IWD has brought
> > up the AP successfully for some reason even though the AP is
> > active(i.e. devices can connect to the AP). This results in
> > NetworkManager failing to appropriately configure the routes needed
> > for the AP.
> >
> > Logs from NetworkManager:
> > <debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
> > Activation: (wifi) Called Start('APSSID').
> > <debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
> > Activation: (wifi) IWD Device.Mode set successfully
> > <debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
> > remove_pending_action (1): 'recheck-available'
> > <trace> [1709938743.2594] platform: (wlan0) emit signal
> > ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft forever
> > pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
> > permanent src kernel
> > <debug> [1709938743.2595] platform: (wlan0) signal: address 4   added:
> > 192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
> > 1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
> > <trace> [1709938743.2598] platform: (wlan0) emit signal
> > ip4-route-changed added: type local table 255 192.168.45.129/32 dev 5
> > metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.129
> > <debug> [1709938743.2599] platform: (wlan0) signal: route   4   added:
> > type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-src
> > rt-kernel scope host pref-src 192.168.45.129
> > <trace> [1709938743.2602] platform: (wlan0) emit signal
> > ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 metric 0
> > mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
> > 192.168.45.129
> > <debug> [1709938743.2602] platform: (wlan0) signal: route   4   added:
> > type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-kernel
> > rtm_flags linkdown scope link pref-src 192.168.45.129
> > <trace> [1709938743.2609] platform: (wlan0) emit signal link-changed
> > changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
> > mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
> > permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
> > tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size
> > 65536 rx:443,42144 tx:563,224232
> > <debug> [1709938743.2610] platform: (wlan0) signal: link changed: 5:
> > wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500
> > arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
> > BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue-len
> > 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
> > rx:443,42144 tx:563,224232
> > <debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queued
> > link change for ifindex 5
> > <info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stage 2
> > of 5 (Device Configure) successful.  Started 'APSSID'.
> > <debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
> > activation-stage: schedule activate_stage3_ip_config
> > <debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
> > activation-stage: invoke activate_stage3_ip_config
> > <debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
> > activation-stage: synchronously invoke activate_stage3_ip_config
> > <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
> > required-timeout: disabled
> > <debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
> > required-timeout: disabled
> > <debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: set
> > state-flags layer2-ready (was none)
> > <info>  [1709938743.2664] device (wlan0): state change: config ->
> > ip-config (reason 'none', sys-iface-state: 'managed')
> > <debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
> > add_pending_action (2): 'in-state-change'
> > <debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
> > remove_pending_action (1): 'in-state-change'
> > <info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is now Sta=
rted
> > <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
> > check-state: state pending =3D> pending, is_failed=3D0, is_pending=3D0,
> > is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> > <trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
> > check-state: (combined) state pending =3D> pending
> > <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
> > check-state: state pending =3D> pending, is_failed=3D0, is_pending=3D0,
> > is_started=3D0 temp_na=3D0, may-fail-4=3D1, may-fail-6=3D1;;;
> > <trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
> > check-state: (combined) state pending =3D> pending
> >
> > NetworkManager bug report with some more details:
> > https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1=
498
>
> This does seem like an NM bug if your able to connect to the AP. That
> means IWD is doing its part. Fwiw I just tried using NM 1.36.6 and IWD
> 2.16 and was able to connect with my phone, saw it had an IP etc.

Yeah, it does get an IP for me as well, but routes are not configured so
no internet for the connecting device. What's unclear is how NM is supposed
to detect this state change, does it do that over dbus or something?

Does NM also report a pending state for you?

>
> Thanks,
>
> James
>
