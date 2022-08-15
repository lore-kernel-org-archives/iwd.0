Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AC1C04
	for <iwd@lists.linux.dev>; Mon, 15 Aug 2022 14:17:56 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id n133so8740496oib.0
        for <iwd@lists.linux.dev>; Mon, 15 Aug 2022 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VOKaic084+f/Bp8A+XmRsNJ9jr7zmPihX2fudvqx4+g=;
        b=cRTi/ea6QMKECoV3IJrxeF+LLZ4sOn8ronlYpAE4z3n/XDMKtSqEXxm4+j0LqEVEKM
         MG/z7ZnqRPGp21gVMp9epFThjzJctN1tDWj4nG8SXQGRM5iY8N7mvDDJn5/P5QcNDuIu
         Olguw8EvtrbDlJ4QZE84qh4PZHUKbG+hQ14BrQ0jQByVHlFOFIGaUy+Pxlqh6Njeeujz
         zbIvnDNj8Yuqzb3jpyyVr/Mr+aGGhhfVEMSm3+lW0E3EC38pIuvUivjyteD+nKANTMjD
         jzYEl6X30FZYJ4Bl17GNxm+14ZPx3zmXM9rQ1p45gpWgG8Wqo8X5GDY4O/ZJyrp0WfF+
         ckRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VOKaic084+f/Bp8A+XmRsNJ9jr7zmPihX2fudvqx4+g=;
        b=HsWa3hX0UQVKY34YucxKpaPTrvfH2LOYn9l2ARjb7dDmMCqX5n2YiZ3Vge9JDDOiC3
         dXVifM5Fzrrkc0LWpd3tSpUGswJ2uxSbc6CBexyEXKUXA4FRtKJDQgayddVfGm49YuGw
         eynYHYcnu6wbTdQqFF0EEBd4+a264Cnk/Kcj03YhGVutDxJKqgbbOONZYHQ+GMubFc2I
         43ePrcl38ovfLN3F5oCu04pCU7hYpa/prc/CNzDeTrAZgNLV7Oef7o3lwdFFkCX3Tgvb
         rlDFcG9u4G6Fm2yrzeUBp5yM2r0oLjq0XYHhlA3TU/IoqZUJURaZ8fgQiFu45zSY1SSQ
         frEg==
X-Gm-Message-State: ACgBeo0dZ8S6hNtkN1Q6fV+mDV5imhhH5bfpSPIXTe7k1GzmumcGdIJA
	uyvWG1umZ2XrsS1HDTMeLZo12q6G529i28rHJGE=
X-Google-Smtp-Source: AA6agR6sl8oLvw/DdlbHka1/nKPNe8EEVps2ZmFtIyAmPaJKMGiN/H63rA0DONKPYmtPd0H09fe+exfkl4GiHCOLgR4=
X-Received: by 2002:a05:6808:1708:b0:335:1b16:fb09 with SMTP id
 bc8-20020a056808170800b003351b16fb09mr11012891oib.7.1660573075363; Mon, 15
 Aug 2022 07:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220809230428.215970-1-prestwoj@gmail.com>
In-Reply-To: <20220809230428.215970-1-prestwoj@gmail.com>
From: Michael Johnson <mjohnson459@gmail.com>
Date: Mon, 15 Aug 2022 15:17:44 +0100
Message-ID: <CACsRnHV_DwbST4Qyk2Qv=n_t_khKdfrRQm16FLmkCG3HGD5qTg@mail.gmail.com>
Subject: Re: [RFC 0/4] Roam based on packet loss event
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James,

I've been testing this today and it does seem to do what is intended.
When we get a packet loss event we start a scan.

```
Aug 15 12:07:17 p3-1337 iwd[447]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
Aug 15 12:07:17 p3-1337 iwd[447]: src/netdev.c:netdev_cqm_event()
Signal change event (above=1 signal=-60)
Aug 15 12:08:20 p3-1337 iwd[447]: src/netdev.c:netdev_mlme_notify()
MLME notification Notify CQM(64)
Aug 15 12:08:20 p3-1337 iwd[447]: src/station.c:station_packets_lost()
Packets lost event: 10
Aug 15 12:08:20 p3-1337 iwd[447]: src/station.c:station_roam_scan() ifindex: 5
Aug 15 12:08:20 p3-1337 iwd[447]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 61
Aug 15 12:08:20 p3-1337 iwd[447]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 61
Aug 15 12:08:20 p3-1337 iwd[447]: src/station.c:station_start_roam()
Using cached neighbor report for roam
Aug 15 12:08:20 p3-1337 iwd[447]: src/scan.c:scan_notify() Scan
notification Trigger Scan(33)
```

In most cases, this does result in a better BSSID being found and a
roam occuring. Occasionally a better BSSID isn't found and the roam
fails, presumably when the packet loss event is not directly caused by
a low RSSI. Either way the new behaviour does add more opportunities
for fixing itself so seems an improvement, thanks!

Regards,
Michael

On Wed, 10 Aug 2022 at 00:04, James Prestwood <prestwoj@gmail.com> wrote:
>
> A few weeks ago a user (CC'ed) reported that his driver was not roaming
> as expected, and would get disconnected before any CQM RSSI events got
> to userspace. He did see that the kernel was sending packet loss events
> which should also be a good reason to roam.
>
> These patches do just that, roam based on packet loss events.
>
> Sending as an RFC so Michael can (hopefully) give this a trial run. I
> can simulate packet loss events in a virtual environment, but testing
> on the driver in question would be best.
>
> James Prestwood (4):
>   station: react to (new) netdev packet loss event
>   netdev: handle packet loss notification
>   auto-t: add generic tx_packet function
>   auto-t: add packet loss test to testPSK-roam
>
>  autotests/testPSK-roam/connection_test.py | 46 ++++++++++++++++++++++-
>  autotests/util/testutil.py                |  7 ++++
>  src/netdev.c                              |  8 ++--
>  src/netdev.h                              |  1 +
>  src/station.c                             | 39 ++++++++++++++++---
>  5 files changed, 90 insertions(+), 11 deletions(-)
>
> --
> 2.34.3
>
