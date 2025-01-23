Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4DD1CA8D
	for <iwd@lists.linux.dev>; Thu, 23 Jan 2025 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642777; cv=none; b=k3/Dvl+snpiWxTKATnRS6Q2q0bFTUDFoFxBQdyAFNvB+5kk2z+uu75aVBKxhX45z/nhWZ00fbL2lIEAPFxJj59VRMUIgUI/q9pk9JFe7lyCVE4/dy4PECAQvidVJ+/4EW3FXmjTekInEE0my2ynmyBdtrbb8Vw8ZrRar+d+VAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642777; c=relaxed/simple;
	bh=hFmwab3vkMaK9pd/NbjpqzQ0EtNvNaQFbHeRr8dmPiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gk+VdB0bj85MaxwnA/b/sKA8YePd2vQQjuLzoTavhSHciiWbIrKMpG/cdjfw8ezb5cSDXfbNBjeCd5vClllkXVZIibMEMrtVLm5uufE/7Ws2TlRzlA6J2jEYG8LtDJoLbuoQwPuro+vz1EIXEg4uVry7MW9Dk2AiyJKWLfMkA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqxcpRvc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqxcpRvc"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7be8f28172dso51573685a.3
        for <iwd@lists.linux.dev>; Thu, 23 Jan 2025 06:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737642775; x=1738247575; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mQZfKhbXYTs3LQlNOJX38+e22ABx316k+XBtbV6i7s=;
        b=UqxcpRvcrv3lyuddcKFfToDrCnNVZ7ez+mZul5ueSbQmC6pA6d41nqZmZVIEblnk93
         88Hekw/BS+qIz1Bq+hXHBOzbPYwJhsM0UuUUe2Tb9LvY+hEM/2IspVRuZRsPfL614Qe+
         B3Ftmk43WszlpIOjrwFH8dZHBPDlI6vl1WbqmayHi83jNQmTnSTvGyvxVbine+Cxpxec
         T4VnBx2DBMGaKFxNnFN8o9frSRnhdYdkj7Lt6WQ9Rn5cRAlDBJFy4k1aUsoYGmY4jX/R
         tVgtHaYDjqpRPfjOI0YDx0c8n3MzfsL8oO637mndC15JgkQzl+NWolXXYeh53hpMtBtx
         Q0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737642775; x=1738247575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mQZfKhbXYTs3LQlNOJX38+e22ABx316k+XBtbV6i7s=;
        b=e3eM4T3YhrNs7QQIpQl1wIfSh4kJPzCoY72dieytWQ5L2nvZH6LEgfP4RGv7V3Z6Nl
         lfIGpam6qA1v55/7wvdS8RZrJCJkgtwQ2v7BKvKAEm49xMBjJ/b9r4IxoZ3vL59HfJSY
         o5W51UJrrACPksmWzijBSJYxMCFI1m7wlEydAH562j75QERhZH4dqG2PVCvwPnHKMZwX
         rzmT2GGX0NQ4qRx9Bid388k94te/Rf3CvH+UYwVhIxYDhjgj7B9x3qg1zDyHgXo/MVUX
         cgdAXigU2Dhg4jwdVFJNd4zetOUNg7gAgp5d1HOhr52jXQFLEk2lh9v56FPoNj+irraS
         NeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSwxlRY3op+g1wwUPNey71HRUzS1ksh7ptTR9TNjzXvpXvJ/a4vr24+Om0eAeGYUDACEQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWefHquPG3FnnyAnBD60HRhe28ekH3H3LMsIqLJk/9h1LE/Dwe
	y2O7TOrx4oRDl2BMKW6NtXyAwFkf+wLdP4b9W89mrgTWMQEkV/r16wikWw==
X-Gm-Gg: ASbGnct+DYqYzT+VhWoFXA6L7ntFAxfT1KF0bSThsJA94FN7cx8fALlda3nWQHZ3uUN
	+2N5KPFV8SMIOUdTek4NpmBWMw1v1ZDddAVUP4RBihSXA3F/cz0g4J82B10tXKI0YvRvX4UqgWk
	ieR82hw4IjeQkLTASuHg/pP6xMheCHygZQdMhDQnFsoFzHIFPDXrR6+IfDpPlT7aLZwTPpKjiXg
	U3lOUeM3noJ3cyjy+SU5lzCY58iMqARkFBsRlWgkEWnKwCNjwuLXD8Dl3xanr6Weuh/CzNzEG1G
	udbFwfwj
X-Google-Smtp-Source: AGHT+IGFb5kse/i3gi2pLRQS17sn7PBS2Nbhf09e9PuWh/8fVEb9LCVFI2/fHob7ayrhiAQwwDsTGA==
X-Received: by 2002:a05:620a:17a3:b0:7b6:f998:3368 with SMTP id af79cd13be357-7be63252c4cmr4559217185a.57.1737642774774;
        Thu, 23 Jan 2025 06:32:54 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102ebfbdsm75207781cf.15.2025.01.23.06.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 06:32:54 -0800 (PST)
Message-ID: <01da7c9d-3f00-47c8-ba8e-a42253ead4b3@gmail.com>
Date: Thu, 23 Jan 2025 06:32:52 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SIGSEGV on IWD 3.2
To: Bryce Johnson <bryce@redpinelabs.com>, iwd@lists.linux.dev
References: <CADXxVSLu-KLRmaM7d1Vc1C5ku6WzXzN_pWxmQuNFtWswXU3izQ@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSLu-KLRmaM7d1Vc1C5ku6WzXzN_pWxmQuNFtWswXU3izQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 1/22/25 3:59 PM, Bryce Johnson wrote:
> Hi All,
> Long shot here,
> I was debugging a logs of a device from an SQA person that had
> repeated IWD SIGSEGV and restarting probably after wifi driver went
> out to lunch.  Somewhat limited logs since I didn't get to it right
> away and stuff started to roll over.
>
> Also interesting, did not even have any wifi in use either in station
> or AP (Nothing had been provisioned).  This device had previously been
> used for some wifi a week or 2 before, but all networks were cleared
> out and device restarted.
>
> We use s6-rc as our service manager.  If a process (such as IWD) dies
> it will repeatedly try and restart it.
>
> Had what looked like wifi driver having issues - probably the start of
> the whole issue.
> [43459.804541] wfx-spi spi0.0: timeout while wake up chip
> [43459.816453] wfx-spi spi0.0: timeout while wake up chip
> [43459.830393] wfx-spi spi0.0: timeout while wake up chip
> [43459.842357] wfx-spi spi0.0: max wake-up retries reached
> [43460.803924] wfx-spi spi0.0: chip is abnormally long to answer
> [43463.873992] wfx-spi spi0.0: chip did not answer
> [43463.878627] wfx-spi spi0.0: hardware request
> WRITE_MIB/TEMPLATE_FRAME (0x06) on vif 0 returned error -110
>
>
> In some s6-rc logs, we have when it was restarted (continues on with
> this and lost some info to rollover)
> 2025-01-21 07:12:08.808001808 signal SIGSEGV
> 2025-01-21 07:12:09.770742290 signal SIGSEGV
> 2025-01-21 07:12:10.806240896 signal SIGSEGV
> 2025-01-21 07:12:11.786297623 signal SIGSEGV
> 2025-01-21 07:12:12.760070244 signal SIGSEGV
> 2025-01-21 07:12:13.758235878 signal SIGSEGV
> *** (Snip - repeated logs) ***
>
> For IWD logs I have repeated restarts like this snipped log, but I
> don't see an error. (I have the restarts from the same times as above
> as well)
> 2025-01-21 02:21:25.344554377      Ciphers: BIP-CMAC-256 BIP-GMAC-256
> BIP-GMAC-128 CCMP-256
> 2025-01-21 02:21:25.345014705           GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
> 2025-01-21 02:21:25.347048046           TKIP
> 2025-01-21 02:21:25.347306057      Supported iftypes: ad-hoc station ap
> 2025-01-21 02:21:25.347473009  Wiphy phy0 will only use the default interface
> 2025-01-21 02:21:25.349009450  event: state, old: disconnected, new:
> autoconnect_quick
> 2025-01-21 02:21:26.139899373  Wireless daemon version 3.2
> 2025-01-21 02:21:26.140155301  Loaded configuration from /etc/iwd/main.conf
> 2025-01-21 02:21:26.176308992  station: Network configuration is disabled.
> 2025-01-21 02:21:26.235244322  Wiphy: 0, Name: phy0
> 2025-01-21 02:21:26.239840939      Permanent Address: 70:54:64:3c:0e:be
> 2025-01-21 02:21:26.240499919      2.4GHz Band:
> 2025-01-21 02:21:26.241493513          Bitrates (non-HT):
> 2025-01-21 02:21:26.243046324               1.0 Mbps
> 2025-01-21 02:21:26.243289505               2.0 Mbps
> 2025-01-21 02:21:26.243446502               5.5 Mbps
> 2025-01-21 02:21:26.243590461              11.0 Mbps
> 2025-01-21 02:21:26.244386486               6.0 Mbps
> 2025-01-21 02:21:26.249855106               9.0 Mbps
> 2025-01-21 02:21:26.250142900              12.0 Mbps
> 2025-01-21 02:21:26.250309769              18.0 Mbps
> 2025-01-21 02:21:26.250451771              24.0 Mbps
> 2025-01-21 02:21:26.250588232              36.0 Mbps
> 2025-01-21 02:21:26.252128546              48.0 Mbps
> 2025-01-21 02:21:26.252323949              54.0 Mbps
> 2025-01-21 02:21:26.252475407          HT Capabilities:
> 2025-01-21 02:21:26.252615242              HT20
> 2025-01-21 02:21:26.252857840              Short GI for 20Mhz
> 2025-01-21 02:21:26.253010755          HT RX MCS indexes:
> 2025-01-21 02:21:26.253149883              0-7
> 2025-01-21 02:21:26.253285011      Ciphers: BIP-CMAC-256 BIP-GMAC-256
> BIP-GMAC-128 CCMP-256
> 2025-01-21 02:21:26.253422847           GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
> 2025-01-21 02:21:26.253550478           TKIP
> 2025-01-21 02:21:26.253761709      Supported iftypes: ad-hoc station ap
> 2025-01-21 02:21:26.253914166  Wiphy phy0 will only use the default interface
> 2025-01-21 02:21:26.288886191  event: state, old: disconnected, new:
> autoconnect_quick
> 2025-01-21 02:21:27.138566070  Wireless daemon version 3.2
> 2025-01-21 02:21:27.143008147  Loaded configuration from /etc/iwd/main.conf
> 2025-01-21 02:21:27.175021883  station: Network configuration is disabled.
> 2025-01-21 02:21:27.237573107  Wiphy: 0, Name: phy0
> 2025-01-21 02:21:27.239996339      Permanent Address: 70:54:64:3c:0e:be
> 2025-01-21 02:21:27.241062954      2.4GHz Band:
> 2025-01-21 02:21:27.241968489          Bitrates (non-HT):
> 2025-01-21 02:21:27.242196175               1.0 Mbps
> 2025-01-21 02:21:27.245799489               2.0 Mbps
> 2025-01-21 02:21:27.246074536               5.5 Mbps
> 2025-01-21 02:21:27.246238990              11.0 Mbps
> 2025-01-21 02:21:27.246376451               6.0 Mbps
> 2025-01-21 02:21:27.246506539               9.0 Mbps
> 2025-01-21 02:21:27.246799664              12.0 Mbps
> 2025-01-21 02:21:27.246981113              18.0 Mbps
> 2025-01-21 02:21:27.247124406              24.0 Mbps
> 2025-01-21 02:21:27.247261409              36.0 Mbps
> 2025-01-21 02:21:27.247395204              48.0 Mbps
> 2025-01-21 02:21:27.249497818              54.0 Mbps
> 2025-01-21 02:21:27.249890707          HT Capabilities:
> 2025-01-21 02:21:27.250062117              HT20
> 2025-01-21 02:21:27.250200203              Short GI for 20Mhz
> 2025-01-21 02:21:27.250339205          HT RX MCS indexes:
> 2025-01-21 02:21:27.250470251              0-7
> 2025-01-21 02:21:27.250606671      Ciphers: BIP-CMAC-256 BIP-GMAC-256
> BIP-GMAC-128 CCMP-256
> 2025-01-21 02:21:27.265473757           GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
> 2025-01-21 02:21:27.266883150           TKIP
> 2025-01-21 02:21:27.267148201      Supported iftypes: ad-hoc station ap
> 2025-01-21 02:21:27.267466069  Wiphy phy0 will only use the default interface
> 2025-01-21 02:21:27.293290723  event: state, old: disconnected, new:
> autoconnect_quick
> *** (Snip - repeated logs) ***
>
>
>
> Anything useful I could get out of this? I was thinking of enabling
> iwd debug logs to hopefully have some more information if we can repo
> this issue.  Most likely it is on the driver side - we had been
> fighting driver issues in the past...

Yes debug logs will help. I agree it does seem like a weird driver issue 
based on those wfx-spi logs, but regardless IWD shouldn't crash. If you 
can get debug logs or better yet a stack trace with debug symbols that 
would be great!

Thanks,

James

>
> Bryce
>
