Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C93238
	for <iwd@lists.linux.dev>; Mon, 15 Aug 2022 16:25:18 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id q19so7007748pfg.8
        for <iwd@lists.linux.dev>; Mon, 15 Aug 2022 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=ua7Go/ZrZqIziX+dBk8LJ8NHHjtIsBk3g0HV/VJo3FI=;
        b=QU5xpnfn3si6oUwYp2T2UWBnWzHdbbvzVTRG12eCQPNCHbx/bNq3vL3LFyVHl2WUrj
         X/h/LbSSKJFTwTw78IhpRo3GX6jRkbQSlNPOPSGFgN41GKMXIYch/GuDoAPNhuDPVprx
         f/Toxr+V5TqPCpDBncyU6dMlbCflwFYbL0oIBpQaZv5CQ7+TL5peLTn5CP0NGGFj4W5P
         HANJYR52DXae0ybjvk0PX9In5FtK6xe8vlb/iB6DZUWgwS1+EOP1DzPY0G1Em87JWVE+
         my6410zha6qNfXDB0Q/UQKHr8Is6BVqOVnZMnItTWV50Txqyox72P00lEQWNzBaQABux
         7W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=ua7Go/ZrZqIziX+dBk8LJ8NHHjtIsBk3g0HV/VJo3FI=;
        b=Cg8OOh8t7AjmMJ5ZHQwbDk8MANFyBRYnrbaAlm/4Wy8bXvUIOZqX98R7QwUoHWvxGx
         d9fTW0q0ugYneIrkIoHPa6C7lirQ/RvKZi+Z3dGPGnkB6EEsm+PqzVmAvU93GYUkptl2
         t5NNVTToAWAxlQzITFe6bmVrtJmSJnhXCXO/0AT1jlSu+nBNd4w8xXooGNO3wKQD9xvD
         KzK3bfYnFLY5mL877/fGdJxpm5rrr2AOcEvRl3AqHA7tGHMY7xHbAnLudZxKDRnqTQRJ
         eU6VqWstoi2g+b5fJpiC93ktkZeB+/xs8Aebw348mJLmHjbWgzfSyVLVuAsWeoxqHt0z
         mvlQ==
X-Gm-Message-State: ACgBeo3z2NPNr/9/Y1uGH9YBII3qcLyOONE3RcCSwkoY7C5QL4OxE/f0
	p7GfSFpH3h9GIqeLQlMREoVPx07+xVI=
X-Google-Smtp-Source: AA6agR4BA872FaCaLuYYz5WLAw/gndiw3pLZuqrvJcjEf9bn9+JpoMAGC374KPmXD0Z2lfT6jPK3Ow==
X-Received: by 2002:a05:6a00:22d0:b0:52e:49f3:3f52 with SMTP id f16-20020a056a0022d000b0052e49f33f52mr17127190pfj.54.1660580718327;
        Mon, 15 Aug 2022 09:25:18 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id z18-20020a63c052000000b003fbb455040dsm6031039pgi.84.2022.08.15.09.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:25:18 -0700 (PDT)
Message-ID: <30ab8858e2d764fa27d303dbb12512c915971251.camel@gmail.com>
Subject: Re: [RFC 0/4] Roam based on packet loss event
From: James Prestwood <prestwoj@gmail.com>
To: Michael Johnson <mjohnson459@gmail.com>
Cc: iwd@lists.linux.dev
Date: Mon, 15 Aug 2022 09:25:17 -0700
In-Reply-To: <CACsRnHV_DwbST4Qyk2Qv=n_t_khKdfrRQm16FLmkCG3HGD5qTg@mail.gmail.com>
References: <20220809230428.215970-1-prestwoj@gmail.com>
	 <CACsRnHV_DwbST4Qyk2Qv=n_t_khKdfrRQm16FLmkCG3HGD5qTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2022-08-15 at 15:17 +0100, Michael Johnson wrote:
> Hi James,
> 
> I've been testing this today and it does seem to do what is intended.
> When we get a packet loss event we start a scan.
> 
> ```
> Aug 15 12:07:17 p3-1337 iwd[447]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> Aug 15 12:07:17 p3-1337 iwd[447]: src/netdev.c:netdev_cqm_event()
> Signal change event (above=1 signal=-60)
> Aug 15 12:08:20 p3-1337 iwd[447]: src/netdev.c:netdev_mlme_notify()
> MLME notification Notify CQM(64)
> Aug 15 12:08:20 p3-1337 iwd[447]:
> src/station.c:station_packets_lost()
> Packets lost event: 10
> Aug 15 12:08:20 p3-1337 iwd[447]: src/station.c:station_roam_scan()
> ifindex: 5
> Aug 15 12:08:20 p3-1337 iwd[447]:
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 61
> Aug 15 12:08:20 p3-1337 iwd[447]: src/wiphy.c:wiphy_radio_work_next()
> Starting work item 61
> Aug 15 12:08:20 p3-1337 iwd[447]: src/station.c:station_start_roam()
> Using cached neighbor report for roam
> Aug 15 12:08:20 p3-1337 iwd[447]: src/scan.c:scan_notify() Scan
> notification Trigger Scan(33)
> ```
> 
> In most cases, this does result in a better BSSID being found and a
> roam occuring. Occasionally a better BSSID isn't found and the roam
> fails, presumably when the packet loss event is not directly caused
> by
> a low RSSI. Either way the new behaviour does add more opportunities
> for fixing itself so seems an improvement, thanks!

Great, thanks for testing!

As far as not finding a better BSS things become a bit harder to handle
since we don't want to affect the existing roam behavior which has
worked well for the majority of users. We are still talking about ideas
to handle this one.

Anyways, at least its an improvement.

Thanks,
James

 

> 
> Regards,
> Michael
> 
> On Wed, 10 Aug 2022 at 00:04, James Prestwood <prestwoj@gmail.com>
> wrote:
> > 
> > A few weeks ago a user (CC'ed) reported that his driver was not
> > roaming
> > as expected, and would get disconnected before any CQM RSSI events
> > got
> > to userspace. He did see that the kernel was sending packet loss
> > events
> > which should also be a good reason to roam.
> > 
> > These patches do just that, roam based on packet loss events.
> > 
> > Sending as an RFC so Michael can (hopefully) give this a trial run.
> > I
> > can simulate packet loss events in a virtual environment, but
> > testing
> > on the driver in question would be best.
> > 
> > James Prestwood (4):
> >   station: react to (new) netdev packet loss event
> >   netdev: handle packet loss notification
> >   auto-t: add generic tx_packet function
> >   auto-t: add packet loss test to testPSK-roam
> > 
> >  autotests/testPSK-roam/connection_test.py | 46
> > ++++++++++++++++++++++-
> >  autotests/util/testutil.py                |  7 ++++
> >  src/netdev.c                              |  8 ++--
> >  src/netdev.h                              |  1 +
> >  src/station.c                             | 39 ++++++++++++++++---
> >  5 files changed, 90 insertions(+), 11 deletions(-)
> > 
> > --
> > 2.34.3
> > 


