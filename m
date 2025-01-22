Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949111CAA86
	for <iwd@lists.linux.dev>; Wed, 22 Jan 2025 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737590391; cv=none; b=T09B1cVAgWOG2DaZv7PpEmqPCgyTclOdRk9dRTU2dBfIMgi6Uk7bWg+QwPXy7bCEInv5vn2WH7BXLwFGBg0UMzEsPZvQc4BHonywCJWPEWU1GPjNZUgzboRWNI8K+SI2oAKjT8kA+GAOpI8qaThDxr2lnCbs5J1TaMlez3qiCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737590391; c=relaxed/simple;
	bh=mFHWdRXZHAuQ3mUzhUJ1QTeFc37+Da9NL+mFPvUWhTA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sbFQriHgVIdH3R9MttCE67HyMFNVXCEGw/kQ0JqXKyYyWjUKpBZjJStd2OQ/9OYFXKKeXNlKNN9dRPGGr9KqnqyO25iJsUc5N+EUVk7jLSr+OBVqaH+JVs5uAoYqGVe3y2LuinEaBhaASqxbxoOZ7BQWmX0RDb8zDWckHgcMfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so476862276.0
        for <iwd@lists.linux.dev>; Wed, 22 Jan 2025 15:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737590388; x=1738195188;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbJo8MC7tQeZFzqLQtvchE1xNPK9RpBJFkL1x9uBdYc=;
        b=VaRyx+wjBBf4mTBhhWHKCw3646FqkMNB2GhfE8MhMzoK+IelXde+ISpTYvQpFi35P1
         TA01aXGcKPGOJUDRQnc4XtJkvIbqKHiUE2STJg125/F152l1B+vD65OG5VusnNbNtUYs
         a3GpYwys3GNdSvo44bAi07JAj6hlaAlDCMCWm/uILPvOfEvCjdWvkIGbLS6rCdj4hsLe
         6Mb7Zbkt6qUqrrJW+ValDgnlAXFoq76uObq+W9LqI/IkNe6a2AejDZRConyfE/G3Yjcd
         KMcLX5h+4l6jSsSf2HoV4UZEWQY6VnEW7G7MP65Kg9cpYBNxFmcNrCCWlRbZWNDjsam5
         dy1Q==
X-Gm-Message-State: AOJu0YwDR02Kn4DXM01hh77G0YQPeKOkOKjutXVD5jeJTpVobHwMRIdG
	ewEuJnBZi/Y3vDgpDr3qMN4CAOBBB1xFfKWuxKTeYUkpi6RCUfQr43opVg==
X-Gm-Gg: ASbGncup/1q/JUzihOlR55RB3pLdAUWfUmbEvPcwmj8OmFjDQuZaEx5jXH9mSG1hCfs
	m3LpmwVEb+iaGtweW95Kfy4l48lj1pHJyZHtb7mjZpAbqNsnd554BQmW7gNOpnwvU/z8l5RdUDo
	axQQ1QN8+9cIykCkdmjdRR9SsV7YhOkkU/Yx699a9Eh2otV5VnJfIxpW+aK+gRBnhWG9VCMLrf1
	7yLITQDLBneWAEthWhpjP9ZxvO2l+W7OwENAy+G3Rwzdn/987f9XR37JOxyLUgV3ZeTDIYwJg3M
	pfmG6dcxBo97mDJa8Xyvv1JXzJBVxFjVM2Chpw==
X-Google-Smtp-Source: AGHT+IEMR2cem5Mexzsc8PVz6KA9K6BJSkPwQ7ei7SFRI4s9IZjm9bSptFEHdVin771dfXKuO6TOFg==
X-Received: by 2002:a05:6902:118b:b0:e58:118d:67e6 with SMTP id 3f1490d57ef6-e58118d68c1mr5031235276.48.1737590388196;
        Wed, 22 Jan 2025 15:59:48 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab2e6ed8sm2349609276.20.2025.01.22.15.59.47
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 15:59:47 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so476848276.0
        for <iwd@lists.linux.dev>; Wed, 22 Jan 2025 15:59:47 -0800 (PST)
X-Received: by 2002:a05:6902:2003:b0:e57:a317:6de8 with SMTP id
 3f1490d57ef6-e57b1098796mr16942050276.23.1737590387067; Wed, 22 Jan 2025
 15:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Wed, 22 Jan 2025 16:59:36 -0700
X-Gmail-Original-Message-ID: <CADXxVSLu-KLRmaM7d1Vc1C5ku6WzXzN_pWxmQuNFtWswXU3izQ@mail.gmail.com>
X-Gm-Features: AWEUYZmnYCPnezMvgtouj95D2W59oc-n52bgTo2GiHw1m6CrswdyjIrLNiG1oG0
Message-ID: <CADXxVSLu-KLRmaM7d1Vc1C5ku6WzXzN_pWxmQuNFtWswXU3izQ@mail.gmail.com>
Subject: SIGSEGV on IWD 3.2
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,
Long shot here,
I was debugging a logs of a device from an SQA person that had
repeated IWD SIGSEGV and restarting probably after wifi driver went
out to lunch.  Somewhat limited logs since I didn't get to it right
away and stuff started to roll over.

Also interesting, did not even have any wifi in use either in station
or AP (Nothing had been provisioned).  This device had previously been
used for some wifi a week or 2 before, but all networks were cleared
out and device restarted.

We use s6-rc as our service manager.  If a process (such as IWD) dies
it will repeatedly try and restart it.

Had what looked like wifi driver having issues - probably the start of
the whole issue.
[43459.804541] wfx-spi spi0.0: timeout while wake up chip
[43459.816453] wfx-spi spi0.0: timeout while wake up chip
[43459.830393] wfx-spi spi0.0: timeout while wake up chip
[43459.842357] wfx-spi spi0.0: max wake-up retries reached
[43460.803924] wfx-spi spi0.0: chip is abnormally long to answer
[43463.873992] wfx-spi spi0.0: chip did not answer
[43463.878627] wfx-spi spi0.0: hardware request
WRITE_MIB/TEMPLATE_FRAME (0x06) on vif 0 returned error -110


In some s6-rc logs, we have when it was restarted (continues on with
this and lost some info to rollover)
2025-01-21 07:12:08.808001808 signal SIGSEGV
2025-01-21 07:12:09.770742290 signal SIGSEGV
2025-01-21 07:12:10.806240896 signal SIGSEGV
2025-01-21 07:12:11.786297623 signal SIGSEGV
2025-01-21 07:12:12.760070244 signal SIGSEGV
2025-01-21 07:12:13.758235878 signal SIGSEGV
*** (Snip - repeated logs) ***

For IWD logs I have repeated restarts like this snipped log, but I
don't see an error. (I have the restarts from the same times as above
as well)
2025-01-21 02:21:25.344554377      Ciphers: BIP-CMAC-256 BIP-GMAC-256
BIP-GMAC-128 CCMP-256
2025-01-21 02:21:25.345014705           GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
2025-01-21 02:21:25.347048046           TKIP
2025-01-21 02:21:25.347306057      Supported iftypes: ad-hoc station ap
2025-01-21 02:21:25.347473009  Wiphy phy0 will only use the default interface
2025-01-21 02:21:25.349009450  event: state, old: disconnected, new:
autoconnect_quick
2025-01-21 02:21:26.139899373  Wireless daemon version 3.2
2025-01-21 02:21:26.140155301  Loaded configuration from /etc/iwd/main.conf
2025-01-21 02:21:26.176308992  station: Network configuration is disabled.
2025-01-21 02:21:26.235244322  Wiphy: 0, Name: phy0
2025-01-21 02:21:26.239840939      Permanent Address: 70:54:64:3c:0e:be
2025-01-21 02:21:26.240499919      2.4GHz Band:
2025-01-21 02:21:26.241493513          Bitrates (non-HT):
2025-01-21 02:21:26.243046324               1.0 Mbps
2025-01-21 02:21:26.243289505               2.0 Mbps
2025-01-21 02:21:26.243446502               5.5 Mbps
2025-01-21 02:21:26.243590461              11.0 Mbps
2025-01-21 02:21:26.244386486               6.0 Mbps
2025-01-21 02:21:26.249855106               9.0 Mbps
2025-01-21 02:21:26.250142900              12.0 Mbps
2025-01-21 02:21:26.250309769              18.0 Mbps
2025-01-21 02:21:26.250451771              24.0 Mbps
2025-01-21 02:21:26.250588232              36.0 Mbps
2025-01-21 02:21:26.252128546              48.0 Mbps
2025-01-21 02:21:26.252323949              54.0 Mbps
2025-01-21 02:21:26.252475407          HT Capabilities:
2025-01-21 02:21:26.252615242              HT20
2025-01-21 02:21:26.252857840              Short GI for 20Mhz
2025-01-21 02:21:26.253010755          HT RX MCS indexes:
2025-01-21 02:21:26.253149883              0-7
2025-01-21 02:21:26.253285011      Ciphers: BIP-CMAC-256 BIP-GMAC-256
BIP-GMAC-128 CCMP-256
2025-01-21 02:21:26.253422847           GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
2025-01-21 02:21:26.253550478           TKIP
2025-01-21 02:21:26.253761709      Supported iftypes: ad-hoc station ap
2025-01-21 02:21:26.253914166  Wiphy phy0 will only use the default interface
2025-01-21 02:21:26.288886191  event: state, old: disconnected, new:
autoconnect_quick
2025-01-21 02:21:27.138566070  Wireless daemon version 3.2
2025-01-21 02:21:27.143008147  Loaded configuration from /etc/iwd/main.conf
2025-01-21 02:21:27.175021883  station: Network configuration is disabled.
2025-01-21 02:21:27.237573107  Wiphy: 0, Name: phy0
2025-01-21 02:21:27.239996339      Permanent Address: 70:54:64:3c:0e:be
2025-01-21 02:21:27.241062954      2.4GHz Band:
2025-01-21 02:21:27.241968489          Bitrates (non-HT):
2025-01-21 02:21:27.242196175               1.0 Mbps
2025-01-21 02:21:27.245799489               2.0 Mbps
2025-01-21 02:21:27.246074536               5.5 Mbps
2025-01-21 02:21:27.246238990              11.0 Mbps
2025-01-21 02:21:27.246376451               6.0 Mbps
2025-01-21 02:21:27.246506539               9.0 Mbps
2025-01-21 02:21:27.246799664              12.0 Mbps
2025-01-21 02:21:27.246981113              18.0 Mbps
2025-01-21 02:21:27.247124406              24.0 Mbps
2025-01-21 02:21:27.247261409              36.0 Mbps
2025-01-21 02:21:27.247395204              48.0 Mbps
2025-01-21 02:21:27.249497818              54.0 Mbps
2025-01-21 02:21:27.249890707          HT Capabilities:
2025-01-21 02:21:27.250062117              HT20
2025-01-21 02:21:27.250200203              Short GI for 20Mhz
2025-01-21 02:21:27.250339205          HT RX MCS indexes:
2025-01-21 02:21:27.250470251              0-7
2025-01-21 02:21:27.250606671      Ciphers: BIP-CMAC-256 BIP-GMAC-256
BIP-GMAC-128 CCMP-256
2025-01-21 02:21:27.265473757           GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
2025-01-21 02:21:27.266883150           TKIP
2025-01-21 02:21:27.267148201      Supported iftypes: ad-hoc station ap
2025-01-21 02:21:27.267466069  Wiphy phy0 will only use the default interface
2025-01-21 02:21:27.293290723  event: state, old: disconnected, new:
autoconnect_quick
*** (Snip - repeated logs) ***



Anything useful I could get out of this? I was thinking of enabling
iwd debug logs to hopefully have some more information if we can repo
this issue.  Most likely it is on the driver side - we had been
fighting driver issues in the past...

Bryce
