Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFA12E5A
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhVLRnDI"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso3000696fac.3
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698677333; x=1699282133; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qk2upu++9OQBfK8ZRAOPSlzAjjjHKA8Tqg1mfb668Jw=;
        b=ZhVLRnDIKLOiKxeYb/Y5LGYldkl+DNMyL8zT5SABBmB40CaWDrvR6Q6Wxj5uiuK53l
         12WhkwsRswX1e2K9blT2u5/8gPJDX+idO29vGy57XfbK/6rwZ2Q4S2rFy44guigNLTtb
         hfxO2GuaaXBXwf4F98t0alJw02Q80XPWZCjQOaz8X3v/oe1gpEHj+j/ySMHmNFVhRoz2
         zAc6RpoESF7X/fVxUUoUTssUzftR6ijdT1947G41+no17WiWno3+I09ohuDEWObvYssn
         WnRmteZ6jXeGcmZ9fB1zhRXqNupeTW9fWvpEP4lob3Y/57kAA6y+BaMkksWFJdoXn7+w
         knVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698677333; x=1699282133;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk2upu++9OQBfK8ZRAOPSlzAjjjHKA8Tqg1mfb668Jw=;
        b=UT01+5oJSdszxcNEG7oSdNUYECgJ3qyAnEtUXSJCSR1/WxR3E/ChrFTgfqyHb7Eq4W
         PLHJF5m7o9QVFcYlMmL5JGvgNOwveSbjK1MhTd68UQogvCuY+PKZT0IAr4jMKrtZSLzR
         CUlH54CzPk2QTlBOMdZpnwhuIxycfx0OsmkY6PB2IzO0Pps4wNr+XIvy6h08AGhvfcx1
         F1KHzZlIX7SoToug90HABSumc5XK3K/OB0MWnjPJOzuZo0dw86N2np9H5WoemPYinzqN
         MR/iwL4tvdYiUvFr4y6jp9fWVlXGkC79Yg6LnXkutK/B8JYVj02VOeI8wf6l0ANQbeXM
         qQ6Q==
X-Gm-Message-State: AOJu0Yx5DPpCtvbw2li4G6Bo7Mj4BPHf8ksIWdz7wgTxI0hwLvct/XLH
	Za7PxsR33tUJtRu+USDz/ic=
X-Google-Smtp-Source: AGHT+IEjZBHm8NX1wDaVZhSNY2Todq55ju+KudX+6ITrpAw8Z+9ouH5J+IklXAW6wqnjsStf8UjHHw==
X-Received: by 2002:a05:6870:5cc6:b0:1e9:a248:b1b6 with SMTP id et6-20020a0568705cc600b001e9a248b1b6mr11803498oab.35.1698677332707;
        Mon, 30 Oct 2023 07:48:52 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056870854100b001e1076a668asm1604399oaj.36.2023.10.30.07.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:48:52 -0700 (PDT)
Message-ID: <4e5fd484-94f6-4b41-bee2-f0b01e760fa2@gmail.com>
Date: Mon, 30 Oct 2023 09:48:50 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] station: rate limit packet loss roam scans
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <20231030134837.452957-5-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231030134837.452957-5-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/30/23 08:48, James Prestwood wrote:
> The packet loss handler puts a higher priority on roaming compared
> to the low signal roam path. This is generally beneficial since this
> event usually indicates some problem with the BSS and generally is
> an indicator that a disconnect will follow sometime soon.
> 
> But by immediately issuing a scan we run the risk of causing many
> successive scans if more packet loss events arrive following
> the roam scans (and if no candidates are found). Logs provided
> further.
> 
> To help with this handle the first event with priority and
> immediately issue a roam scan. If another event comes in within a
> certain timeframe (2 seconds) don't immediately scan, but instead
> rearm the roam timer instead of issuing a scan. This also handles
> the case of a low signal roam scan followed by a packet loss
> event. Delaying the roam will at least provide some time for packets
> to get out in between roam scans.
> 
> Logs were snipped to be less verbose, but this cycled happened
> 5 times prior. In total 7 scans were issued in 5 seconds which may
> very well have been the reason for the local disconnect:
> 
> Oct 27 16:23:46 src/station.c:station_roam_failed() 9
> Oct 27 16:23:46 src/wiphy.c:wiphy_radio_work_done() Work item 29 done
> Oct 27 16:23:47 src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
> Oct 27 16:23:47 src/station.c:station_packets_lost() Packets lost event: 10
> Oct 27 16:23:47 src/station.c:station_roam_scan() ifindex: 9
> Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_insert() Inserting work item 30
> Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_next() Starting work item 30
> Oct 27 16:23:47 src/station.c:station_start_roam() Using cached neighbor report for roam
> Oct 27 16:23:47 src/scan.c:scan_notify() Scan notification Trigger Scan(33)
> Oct 27 16:23:47 src/scan.c:scan_request_triggered() Active scan triggered for wdev a
> Oct 27 16:23:47 src/scan.c:scan_notify() Scan notification New Scan Results(34)
> Oct 27 16:23:47 src/netdev.c:netdev_link_notify() event 16 on ifindex 9
> ... scan results ...
> Oct 27 16:23:47 src/station.c:station_roam_failed() 9
> Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_done() Work item 30 done
> Oct 27 16:23:47 src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
> Oct 27 16:23:47 src/station.c:station_packets_lost() Packets lost event: 10
> Oct 27 16:23:47 src/station.c:station_roam_scan() ifindex: 9
> Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_insert() Inserting work item 31
> Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_next() Starting work item 31
> Oct 27 16:23:47 src/station.c:station_start_roam() Using cached neighbor report for roam
> Oct 27 16:23:47 src/scan.c:scan_notify() Scan notification Trigger Scan(33)
> Oct 27 16:23:47 src/scan.c:scan_request_triggered() Active scan triggered for wdev a
> Oct 27 16:23:48 src/scan.c:scan_notify() Scan notification New Scan Results(34)
> Oct 27 16:23:48 src/netdev.c:netdev_link_notify() event 16 on ifindex 9
> ... scan results ...
> Oct 27 16:23:48 src/station.c:station_roam_failed() 9
> Oct 27 16:23:48 src/wiphy.c:wiphy_radio_work_done() Work item 31 done
> Oct 27 16:23:48 src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
> Oct 27 16:23:48 src/station.c:station_packets_lost() Packets lost event: 10
> Oct 27 16:23:48 src/station.c:station_roam_scan() ifindex: 9
> Oct 27 16:23:48 src/wiphy.c:wiphy_radio_work_insert() Inserting work item 32
> Oct 27 16:23:48 src/wiphy.c:wiphy_radio_work_next() Starting work item 32
> Oct 27 16:23:48 src/station.c:station_start_roam() Using cached neighbor report for roam
> Oct 27 16:23:48 src/scan.c:scan_notify() Scan notification Trigger Scan(33)
> Oct 27 16:23:48 src/scan.c:scan_request_triggered() Active scan triggered for wdev a
> Oct 27 16:23:49 src/netdev.c:netdev_link_notify() event 16 on ifindex 9
> Oct 27 16:23:49 src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> Oct 27 16:23:49 src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> Oct 27 16:23:49 src/netdev.c:netdev_deauthenticate_event()
> Oct 27 16:23:49 src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> Oct 27 16:23:49 src/netdev.c:netdev_disconnect_event()
> Oct 27 16:23:49 Received Deauthentication event, reason: 4, from_ap: false
> ---
>   src/station.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

