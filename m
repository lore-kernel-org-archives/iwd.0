Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879215497
	for <iwd@lists.linux.dev>; Fri, 26 May 2023 12:57:01 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ae851f2a7dso16270305ad.0
        for <iwd@lists.linux.dev>; Fri, 26 May 2023 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685105821; x=1687697821;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TrDpgmy5tkEwvFxWWrB8ibabOTI6EyFMxw5Iw+ZSJ4g=;
        b=YC2Y8Zxwy8+mS/zojuaRAtgk/s3GY/3LzsMZ1oBYPX4rbzyxH4qT9x/j7xncfMf/ZR
         vix1g7K4cA2AstUilR1HtAwMS8KnhS/YbOOhY4/QaIJYL+sxqBUjdRf7gtET5iJOaGWJ
         tykuhPAoi+7KL1xaZMMHk8mwKzrMTBoNq9/YmWTpVlPFmDbZNQPFr7NT7qb2hFvl+NH1
         QmqLwea4a+JWiDT+oM/oIwXN+RMxJ0FARNDVNnOPHhfuHv/qBt73FEwNdLXt7KN1D6uT
         YBCWoqR9KcQprNZA2YP/TiCPlK+aGiHI6cGqLOIqPjFBYiNI6H9NouRn/t4TJDnBXiHc
         h7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685105821; x=1687697821;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrDpgmy5tkEwvFxWWrB8ibabOTI6EyFMxw5Iw+ZSJ4g=;
        b=OKPcQ0EPM3EkKcyLP4VPelw/LM7gIR8B5H1nLxNQ5rkCBfdVMp4Bd+nqvwXU2LAV75
         29asX+pGm3CUwgHPfMNEevAh+LGt2v+6S0n+/JOXGiJeqH8eAhcxc32ayuWUciyeB3fx
         v3GdLyjhEfWKxnRg38erhJ1Db894sp3XBXll01sT826XopF8KhOAtCqMsQSCR56CVccP
         dQ7XwckGWRRIB28TRypHgqnSoNMiGPttuGAPaaUPsRh1wzEpg2xN3h2VELUobn9pch+/
         /4FN0t/4HAHw3sqUyTmpRDxFIK1oRRb9dCTYjn8WK0KtHdvLmdPW9Qw6LAC2/L+OdfrR
         qBuw==
X-Gm-Message-State: AC+VfDxVZ57o242TN6eU1m3rrUwpXSiUW2wK+zx7ZUTphfXXKe+ztEjM
	8/mYi76T0u1VFuSXyCRu1x2QsgA8s5J+JzdcabBfEqRtTMAxvA==
X-Google-Smtp-Source: ACHHUZ5Jeq35rjmi89J+FyZ4/3nCurM1TvmjOxBVTAe5l4ILhmXYE+MCRGLDxHApJsZ9chnWEHzuG+adqtHTK6JXRAg=
X-Received: by 2002:a17:902:e806:b0:1af:e10f:ba96 with SMTP id
 u6-20020a170902e80600b001afe10fba96mr2462541plg.1.1685105820992; Fri, 26 May
 2023 05:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 26 May 2023 07:56:50 -0500
Message-ID: <CAG17S_Nrg_PCVFR1UZLROME+TuKy5_3N=JgfBkLF2cpZaiaTVw@mail.gmail.com>
Subject: wifi disconnects periodically
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I recently changed from Arch Linux on my Pis to now using RaspiOS
bullseye. I have noticed that, periodically, I get a disconnect from
my AP. I am not completely certain that this is it, but the journal
shows this at the time I think it lost connection:

May 26 07:23:47 kitchenrune dbus-daemon[308]: [system] Activating via
systemd: service name='org.freedesktop.timedate1'
unit='dbus-org.freedesktop.timedate1.service' requested by ':1.49134'>
May 26 07:23:47 kitchenrune systemd[1]: Starting Time & Date Service...
May 26 07:23:48 kitchenrune dbus-daemon[308]: [system] Successfully
activated service 'org.freedesktop.timedate1'
May 26 07:23:48 kitchenrune systemd[1]: Started Time & Date Service.
May 26 07:23:48 kitchenrune systemd-resolved[13100]: Failed to emit
notification about changed property CurrentDNSServer: Transport
endpoint is not connected
May 26 07:23:48 kitchenrune systemd[1]: Stopping Network Name Resolution...
May 26 07:23:48 kitchenrune systemd[1]: systemd-resolved.service: Succeeded.
May 26 07:23:48 kitchenrune systemd[1]: Stopped Network Name Resolution.
May 26 07:23:48 kitchenrune systemd[1]: Starting Network Name Resolution...
May 26 07:23:48 kitchenrune systemd-resolved[17192]: Positive Trust Anchors:
May 26 07:23:48 kitchenrune systemd-resolved[17192]: . IN DS 20326 8 2
e06d44b80b8f1d39a95c0b0d7c65d08458e880409bbc683457104237c7f8ec8d
May 26 07:23:48 kitchenrune systemd-resolved[17192]: Negative trust
anchors: 10.in-addr.arpa 16.172.in-addr.arpa 17.172.in-addr.arpa
18.172.in-addr.arpa 19.172.in-addr.arpa 20.172.in-addr.a>
May 26 07:23:48 kitchenrune systemd-resolved[17192]: Using system
hostname 'kitchenrune'.
May 26 07:23:48 kitchenrune systemd[1]: Started Network Name Resolution.
May 26 07:24:18 kitchenrune systemd[1]: systemd-timedated.service: Succeeded.
May 26 07:25:44 kitchenrune iwd[313]: wiphy_estimate_data_rate() failed
May 26 07:25:44 kitchenrune iwd[313]: wiphy_estimate_data_rate() failed
May 26 07:25:44 kitchenrune iwd[313]: wiphy_estimate_data_rate() failed
May 26 07:28:01 kitchenrune kernel: nfs: server 192.168.2.253 not
responding, timed out
(and I cannot connect to my NFS share)

I am running a custom built iwd version 2.4 and ell 0.56 with custom
built connman 1.41

What was going on when it lost connection:
I was listening to an internet stream and it stopped playing. When it
did, I was no longer able to ping nor ssh into the pi. I was able to
get it to reconnect to my local LAN by restarting the AP radio on the
router.

I am not aware of this happening like this before. Any ideas on what I
can check?

Keith
