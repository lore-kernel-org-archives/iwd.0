Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E1523C
	for <iwd@lists.linux.dev>; Wed, 10 Jan 2024 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDecSzRN"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5955a4a9b23so2090774eaf.1
        for <iwd@lists.linux.dev>; Tue, 09 Jan 2024 20:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704860081; x=1705464881; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGx1XKW+Um1U5McYf+GxuMDKirKb8oU9RQbx23QzXI4=;
        b=QDecSzRNIUyHvaYOdmzONuy869PB2XorFY5fKD0q2m/WkcF/rvJ9+Huxvjm2Kie8SH
         OkLY2zJPsbnXCoRO1taAKUTGnu/GVO70/Wi1b3g11RSRsNSMCQ7Z2g7bvsAjXwRo68Ww
         AR1k/Bp89T/wFszEj6Ux9eeUyy2hsOz5SBzWQiOJSqsRUyS6eTLyOHoSKYwaNAyZDJxB
         puvLeusUNgK1Pdbx7GBzqdJBOTpegY554qwLeVBG9di513kZF+kGOJ75WVKN2PEHLuAD
         VgEYdHni7AwP2Su2LV98OV9Q5OliK5x1AGIdksMiWTHAs4YjMV+zoshWKkJnB54WUhSO
         oqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704860081; x=1705464881;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGx1XKW+Um1U5McYf+GxuMDKirKb8oU9RQbx23QzXI4=;
        b=saGwhY4AXXI7aBKiFn+iUj4oFft6Pmy1PLN+GRZW1krU0eBkNdKwLao6JXRZJLYCSS
         BoopT0QLm/Y/+ONT6yGw7YwEq/DZuEeeoPP+KZ4mBdURmLudgoV7IUlNtYDqTFhfZA3S
         AKmaHiQmcer7EkmzC2HeRfoR/nLxd/gZYdSZXkgoBT+0NWrvpFZ2aIlelEHtEKj9YVMn
         xGPMi/5Sg/FV15tbJJHxJsRR8HNt4AsnXXwmytDZx5huF1hKBynvF00HfjQ5edy5TJo/
         K/KYBY8b9p4bEzBcGu02I57mKigRHmF1g+bE8V9YpASbDuspdlDb2Kc3wHQPL+t84IbG
         z6dQ==
X-Gm-Message-State: AOJu0Yx7K6DcoudqC/PUppZMpWq15zk1rwSzdmOtvGtJisl75qWL/AP5
	TQ3S2WVyKeFUfU2W6f2Lleo=
X-Google-Smtp-Source: AGHT+IEFwFfY4mGipmrR88NePklnraBC0mF3T0gtMTzosknjEpe03ljH8LxxtuUqYx+yMzP9sSnNxQ==
X-Received: by 2002:a05:6820:161f:b0:596:3126:306d with SMTP id bb31-20020a056820161f00b005963126306dmr477382oob.7.1704860081042;
        Tue, 09 Jan 2024 20:14:41 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g6-20020a4a5b06000000b005960376cc37sm682088oob.16.2024.01.09.20.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 20:14:40 -0800 (PST)
Message-ID: <f4d9e6cf-f7e4-49b9-adbf-92dbc006812a@gmail.com>
Date: Tue, 9 Jan 2024 22:14:39 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd 2.12 - Received error during CMD_TRIGGER_SCAN: Invalid
 argument (22)
Content-Language: en-US
To: Robert Nelson <robertcnelson@gmail.com>, iwd@lists.linux.dev
References: <CAOCHtYj9OjZGQ=G139i=KRRcxpFD-1=GSvUPmFYaqSvFz0NwJg@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAOCHtYj9OjZGQ=G139i=KRRcxpFD-1=GSvUPmFYaqSvFz0NwJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Robert,

On 1/9/24 15:37, Robert Nelson wrote:
> Hi iwd Developers,
> 
> For BeagleBoard.org devices I've been looking to move us to iwd vs
> wpa_supplicant, and have been fighting an CMD_TRIGGER_SCAN error on
> bootup, so devices don't auto connect to WiFI once configured.
> 
> Our main stack is Debian 12.x (Bookworm) with backports of libell-dev
> and iwd on a 5.10.x based vendor kernel (well my 5.10.x)
> 
> https://packages.debian.org/sid/libell-dev
> https://packages.debian.org/source/sid/iwd
> 
> ```
> debian@42-am335x-bbbw:~$ dpkg --list | grep libell
> ii  libell0:armhf
> 0.61-1bbbio0~bookworm+20231207          armhf        Embedded Linux
> library
> debian@42-am335x-bbbw:~$ dpkg --list | grep iwd
> ii  iwd
> 2.12-1bbbio0~bookworm+20240103          armhf        wireless daemon
> for Linux
> ```
> 

That looks okay...

> Normally on bootup iwd will report:
> 
> ```
> Jan 09 15:10:41 41-am335x-bbbw iwd[360]: D-Bus disconnected, quitting...
> Jan 09 15:10:41 41-am335x-bbbw iwd[360]: Removing scan context for wdev 2
> Jan 09 15:10:41 41-am335x-bbbw iwd[360]: Terminate
> Jan 09 15:10:41 41-am335x-bbbw systemd[1]: Stopping iwd.service -
> Wireless service...
> Jan 09 15:10:42 41-am335x-bbbw iwd[360]: Removing scan context for wdev 3
> Jan 09 15:10:42 41-am335x-bbbw systemd[1]: iwd.service: Deactivated
> successfully.
> Jan 09 15:10:42 41-am335x-bbbw systemd[1]: Stopped iwd.service -
> Wireless service.
> Jan 09 15:10:44 41-am335x-bbbw systemd[1]: Starting iwd.service -
> Wireless service...
> Jan 09 15:10:47 41-am335x-bbbw iwd[363]: Wireless daemon version 2.12
> Jan 09 15:10:47 41-am335x-bbbw iwd[363]: Loaded configuration from
> /etc/iwd/main.conf
> Jan 09 15:10:47 41-am335x-bbbw systemd[1]: Started iwd.service -
> Wireless service.
> Jan 09 15:10:47 41-am335x-bbbw iwd[363]: station: Network
> configuration is disabled.
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]: Wiphy: 0, Name: phy0
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         Permanent Address:
> 5c:31:3e:e2:24:6a
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         2.4GHz Band:
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 Bitrates (non-HT):
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          1.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          2.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          5.5 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         11.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          6.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          9.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         12.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         18.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         24.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         36.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         48.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         54.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 HT Capabilities:
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         HT20
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         Short
> GI for 20Mhz
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 HT RX MCS indexes:
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         0-15
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         5GHz Band:
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 Bitrates (non-HT):
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          6.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                          9.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         12.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         18.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         24.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         36.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         48.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         54.0 Mbps
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 HT Capabilities:
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         HT40
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         Short
> GI for 20Mhz
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         Short
> GI for 40Mhz
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                 HT RX MCS indexes:
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:                         0-7
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         Ciphers: CCMP-128 TKIP
> Jan 09 15:11:14 41-am335x-bbbw iwd[363]:         Supported iftypes:
> station ap p2p-client p2p-go p2p-device
> Jan 09 15:11:16 41-am335x-bbbw iwd[363]: connect event timed out, reason=3
> Jan 09 15:11:16 41-am335x-bbbw iwd[363]: connect event timed out, reason=3
> Jan 09 15:11:17 41-am335x-bbbw iwd[363]: connect event timed out, reason=3
> Jan 09 15:11:18 41-am335x-bbbw iwd[363]: connect event timed out, reason=3
> Jan 09 15:11:18 41-am335x-bbbw iwd[363]: connect event timed out, reason=2

enum nl80211_timeout_reason {
         NL80211_TIMEOUT_UNSPECIFIED,
         NL80211_TIMEOUT_SCAN,
         NL80211_TIMEOUT_AUTH,
         NL80211_TIMEOUT_ASSOC,
};

So either AUTH or ASSOC.

> Jan 09 15:11:18 41-am335x-bbbw iwd[363]: Received error during
> CMD_TRIGGER_SCAN: Invalid argument (22)
> Jan 09 15:11:28 41-am335x-bbbw iwd[363]: Received error during
> CMD_TRIGGER_SCAN: Invalid argument (22)
> Jan 09 15:11:48 41-am335x-bbbw iwd[363]: Received error during
> CMD_TRIGGER_SCAN: Invalid argument (22)
> ```
> 

And that's a pretty strange error as well.  Any chance you can trace the kernel 
to see what exactly it doesn't like?

> What's weird, if i login over serial and restart, sometimes it just works..
> 
> ```
> Jan 09 14:58:11 42-am335x-bbbw iwd[362]: Received error during
> CMD_TRIGGER_SCAN: Invalid argument (22)
> Jan 09 15:03:11 42-am335x-bbbw iwd[362]: Received error during
> CMD_TRIGGER_SCAN: Invalid argument (22)
> Jan 09 15:07:58 42-am335x-bbbw sudo[676]:   debian : TTY=ttyS0 ;
> PWD=/home/debian ; USER=root ; COMMAND=/usr/bin/systemctl restart
> iwd.service
> Jan 09 15:08:19 42-am335x-bbbw sudo[720]:   debian : TTY=ttyS0 ;
> PWD=/home/debian ; USER=root ; COMMAND=/usr/bin/systemctl restart
> iwd.service
> Jan 09 15:24:44 42-am335x-bbbw sudo[1246]:   debian : TTY=ttyS0 ;
> PWD=/home/debian/lab ; USER=root ; COMMAND=/usr/bin/nano
> /etc/iwd/main.conf
> Jan 09 15:25:01 42-am335x-bbbw systemd[1]: Starting iwd.service -
> Wireless service...
> Jan 09 15:25:04 42-am335x-bbbw iwd[363]: Wireless daemon version 2.12
> Jan 09 15:25:04 42-am335x-bbbw iwd[363]: Loaded configuration from
> /etc/iwd/main.conf
> Jan 09 15:25:04 42-am335x-bbbw systemd[1]: Started iwd.service -
> Wireless service.
> Jan 09 15:25:04 42-am335x-bbbw iwd[363]: station: Network
> configuration is disabled.
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]: Wiphy: 0, Name: phy0
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         Permanent Address:
> 5c:31:3e:e3:bb:e4
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         2.4GHz Band:
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 Bitrates (non-HT):
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          1.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          2.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          5.5 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         11.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          6.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          9.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         12.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         18.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         24.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         36.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         48.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         54.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 HT Capabilities:
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         HT20
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         Short
> GI for 20Mhz
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 HT RX MCS indexes:
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         0-15
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         5GHz Band:
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 Bitrates (non-HT):
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          6.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                          9.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         12.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         18.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         24.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         36.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         48.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         54.0 Mbps
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 HT Capabilities:
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         HT40
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         Short
> GI for 20Mhz
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         Short
> GI for 40Mhz
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                 HT RX MCS indexes:
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:                         0-7
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         Ciphers: CCMP-128 TKIP
> Jan 09 15:25:30 42-am335x-bbbw iwd[363]:         Supported iftypes:
> station ap p2p-client p2p-go p2p-device
> Jan 09 15:25:32 42-am335x-bbbw iwd[363]: hardware_rekey not supported
> ```

What iwd does on startup is deletes and re-creates the wifi netdev.  Some 
drivers might not really like that and a race condition is a good theory if iwd 
works fine on subsequent runs.  You can try adding [DriverQuirks] to 
/etc/iwd/main.conf and add your driver to the DefaultInterface list.  That 
should prevent iwd from trying to re-create the netdev.  See man 5 iwd.config 
for more details.  Maybe this helps?

Regards,
-Denis
