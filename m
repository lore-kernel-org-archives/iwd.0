Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B77296D0A
	for <iwd@lists.linux.dev>; Mon, 12 May 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070906; cv=none; b=UC684+TJLJNgN+bhfKmw14+poeyuHODCCu4un6dmdLf8cwSlhtj0Inf6txOf7nRJOg7WQh6T7hXcxqPeIG+ijiyT7YtgircIwr70a3ZSVcX8mYnUTtNLh9sVDCbxWnzWGgLLfzjSLzU9BcrT83vzGoXKffgu57J4iXaTyQaIWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070906; c=relaxed/simple;
	bh=lXPG1IkmGX7Fy8zyFmgb32c7zLQ8CnG2j32yCnwU0FI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ndMIpIyi8643sK7gwTAd4poPrBRytF//7P8ukLwhD7/Ao3nx3WV+9THRQxFRE8hpuuvaQySZzpAR1sd2MgYumA58lGE5nNQig/C3EQr2xwps2gUbKKMpe7BIfrBmwcAYcS7e4NSxAjleAjfgggAETXflIkHOL4MijJFtYHex1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e78fc91f30dso3709585276.3
        for <iwd@lists.linux.dev>; Mon, 12 May 2025 10:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747070903; x=1747675703;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53MeA56RjqhYpx3DHm4I1369QL70IN++N4ZCIq7jAbI=;
        b=dpKrFSOTZiJq+T4yGljaWXi/dfatZxfcQxgkX5iVQ4Q6TOwaCDL8mzepQ+oyGQZfmw
         kowgAbsP2F3X87Qe9op6Y+DY4vWzqVgZvAjJe7GKh1YIVXbcn5Tjc7v7Y8eNuxrnENCw
         epa2Cc0wKUNOuechcBxgUw+qvmAMm+/qxKzlgVHZu9AcBCKqs5cCm4D7hF2ajH6oEfrx
         xWQ/FzITKTVl8hxJRGfNFkWmq3T8f6SY/RSdjoneZIndUefQt9I79FlvZV8XvKpj/Jv3
         WN4By9jKv8lHo3MGsH8OwnsyLzJbuIRXDLg/zus2x8Yuf/BYRzPwi6+LpbMLugJ2b0MX
         nmzw==
X-Gm-Message-State: AOJu0Yy5tkebhghfCaqXQApBFGUWzbr4lGYL9xFVuEZZd/3UShXQGhLF
	sQWC4ujePhiszorRbg9CNendf7suqlq+J0drd2wQfHxxEjchMoa66wJOVw==
X-Gm-Gg: ASbGnculMDZr7fh7lX047YZNG9dUSKaORHcvppHfMA4b6u4qT4BCw41Sr3KGuULuEHk
	9LFDBcmfxAWd+d6sGYJ2npHih4A5rLHKw2ofGHShnegVEz/HAdP4SX2RhUQwGkaQMxCMHREJxu0
	jxs4QIX4YMxq3n3k6Aet0zHo/Mrz4IU0659o/JcMOLGm/YbqLuTAQETY0A30+dyOsZMN/+z04y4
	IPLF5F0bvyLzA7KMQov3dhotNneeEE4GQtmbpaV6kXCe+0smkELtkReYbABJX4Dpd/KdK4pCi/u
	i1y2Ku17lqnqd7OzMh27Aak9wlxSYFfdxXurHPOM1ncPn0/EGEGyij7C3+RMNvJqgUNG9JSmy79
	fWMB81LEuAs87jWRj8ug=
X-Google-Smtp-Source: AGHT+IGDnam3YsnZbMrQA7FcFZW2xr1jVtN7puvtR3t4aTSGXSDDqSevFjflfPXaHn/j/kimZ1T2YA==
X-Received: by 2002:a05:6902:2301:b0:e7a:a7b1:de48 with SMTP id 3f1490d57ef6-e7aa7b1df47mr10132938276.20.1747070903380;
        Mon, 12 May 2025 10:28:23 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e79108ae6e1sm1555514276.19.2025.05.12.10.28.22
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 10:28:23 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso4269221276.2
        for <iwd@lists.linux.dev>; Mon, 12 May 2025 10:28:22 -0700 (PDT)
X-Received: by 2002:a05:6902:1a41:b0:e78:f7f9:ef4 with SMTP id
 3f1490d57ef6-e78fdd033aemr17541334276.29.1747070902522; Mon, 12 May 2025
 10:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Mon, 12 May 2025 11:28:10 -0600
X-Gmail-Original-Message-ID: <CADXxVSKPz7o3TT18hCqzz=3MMWrE69NbaBDLSHFBfoRDq5VT7w@mail.gmail.com>
X-Gm-Features: AX0GCFvTUdeVIA8T22tjISQ9ikMco9JQkdhHLTvr0C0HY17B34dPOiqN9tbqM9c
Message-ID: <CADXxVSKPz7o3TT18hCqzz=3MMWrE69NbaBDLSHFBfoRDq5VT7w@mail.gmail.com>
Subject: linksys router incorrectly showing as WEP?
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,
We have some embedded linux devices with TI cc3301 chipset.  At one of
our labs, the router (linksys MR6350) according to IWD will show up as
wep security then go back to psk.

Odd thing is this router doesn't even support WEP - the only security
option it has listed in wpa2-personal or open.

We have like 20 devices in the lab and it appears to be happening to
some or all of them. I'm needing to remote desktop over to a computer
that has a serial connection... so slightly difficult to get logs.

I want to just blame the router and have them replace it, but I
figured I'd check if there is any other issue here as well.  I have
full IWD debug logs saved, but here is a snippet.

2025-05-12 16:15:53.428737870  Wireless daemon version 3.4
<SNIP>
2025-05-12 16:15:55.791609235  src/station.c:station_print_scan_bss()
Processing BSS 'd8:ec:5e:99:0e:6c' with SSID: Revelotest4, freq: 2427,
rank: 492, strength: -4600, data_rate: 72.2
2025-05-12 16:15:55.791622150  src/station.c:station_add_seen_bss()
Added new Network "Revelotest4" security wep
<SNIP>
2025-05-12 16:22:15.714231348  src/station.c:station_print_scan_bss()
Processing BSS 'd8:ec:5e:99:0e:6c' with SSID: Revelotest4, freq: 2427,
rank: 492, strength: -4700, data_rate: 72.2
2025-05-12 16:22:15.714244273  src/station.c:station_add_seen_bss()
Added new Network "Revelotest4" security psk
<SNIP>
2025-05-12 16:22:15.717638513  src/station.c:process_network() No
remaining BSSs for SSID: Revelotest4 -- Removing network

Then killing IWD and restarting

2025-05-12 16:23:24.015924492  src/station.c:station_print_scan_bss()
Processing BSS 'd8:ec:5e:99:0e:6c' with SSID: Revelotest4, freq: 2427,
rank: 492, strength: -4500, data_rate: 72.2
2025-05-12 16:23:24.015937250  src/station.c:station_add_seen_bss()
Added new Network "Revelotest4" security psk


On another 2 device: (2025-05-08 date is incorrect it was before it
got good time).  They in total had been up 30 minutes or so.

device 2:
2025-05-08 17:00:09.699817830  src/station.c:station_add_seen_bss()
Added new Network "Revelotest4" security wep
2025-05-12 16:33:47.901451708  src/station.c:station_add_seen_bss()
Added new Network "Revelotest4" security psk

device 3:
2025-05-08 17:00:06.777723005  src/station.c:station_add_seen_bss()
Added new Network "Revelotest4" security wep
2025-05-12 16:33:49.145627332  src/station.c:station_add_seen_bss()
Added new Network "Revelotest4" security psk

That 2 devices do it at the same time - makes it seem like the router
is doing some funky stuff.

Thank
Bryce
