Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271B189509
	for <iwd@lists.linux.dev>; Mon, 26 Aug 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687005; cv=none; b=qGzrsz5fyXTAVg2RvIyzzpNBE48cJs0TdrEQbYsANj9lgotJKPVnvJR7CLVRnmirBBnPj+DHLeRF3o8jBE7iEtUU4SLFYYPiCWqQb3lTnaituFXybmy+RTZ6H8zoWOYpnkTsS7IBXcEKkKRHurkHw9eZT8mfhBs5ep+xYI5pS/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687005; c=relaxed/simple;
	bh=qyccldYwQQnwSrNlXmUpGSRjPlc28r6ErZKJHxUxZsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2iII/lIGR+ny6j9l7TSVosGTzDGIicYVRnqjJ6+WNrbSGMiQu7U+sllB4DvDhdHr+Abumdk9MPFOea3ps7LnFBAV5S4z5O2rINAsuL5qY4SwX4rOqBPhXxKs8x9AF/9ms372jE99w/wx6njIJGse9ZqlDXi8/QXQ9xKc1t8Ri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBoF6zFT; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBoF6zFT"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70f44b88bf0so245713a34.1
        for <iwd@lists.linux.dev>; Mon, 26 Aug 2024 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724687003; x=1725291803; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0OFhiwfqxqo9fcipxA+VFN1iuMQTDRczd1d7rbCfRZ8=;
        b=RBoF6zFTPrqTXw2IwT3ykymzXO+aPj4x6xyiucHP0d1Q99l/fOuUmzGaZONUCnhEOR
         S+c3QVpOLIhs07TFwUnvflSt1AQk+AOo/qJP5OyUShj+/2//V7G5QN4QyZ9IMrZ9xN5o
         +9l9ec7/x3P2LH6yLBK+K7OvdRfmYfza635Hn8tZEZAzlpwii55XeyzUJL7grAbUdiRh
         xDoprCezLjD3IkwyROAEnxv45Tt+EKdQovzarFQMUo5QcGtyvhk4Mp7TZCjhUur+NRkz
         ZKQlMWjlewhroqMSrcmp0hegSHilXQqjnU85H1ImUa1V8By05jUgR6xxRCri/+edk7kW
         3AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724687003; x=1725291803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OFhiwfqxqo9fcipxA+VFN1iuMQTDRczd1d7rbCfRZ8=;
        b=wcor2CYCXOxi/yKbu6lFM56QCX6bvGULYOjCXFBZ4gbG7yS94GZzheMJT7BYkt7fOI
         6Yll2y/JGBRf+dIkZzHm0brkibTy2x87LoiwC+MNncFFiiqvK03wZqbBva6BfJ5d3RfV
         GG+wyqdbaB5y8J88Gr6G7E8Bwvs8G++SnvCf4gbCtm2hLSeu8plxtcbff4di+dMorfND
         em7VpLMw5lR6b2f5KX3g/z/LMDfcbysSeVF1jo4ZbalFlJwPh8cTYFe02pTZ9evxlyQ9
         j4LNhm1aFR2r5qMDwliqZw+AmG82YlkNsJ1z8TRSx/o0IQXFKlhnZpO7YqwO5vDoPMfl
         gbcQ==
X-Gm-Message-State: AOJu0Yw4lUdGST2BgojLN+Vp+bTnXY/2gw8kL5UbapN89+db0/Ibe/LF
	KmwL31udJIJVc7Ef3sJ1zcKyj9Xmcw/WwyoPAxsFElFlKt5F8Rx2
X-Google-Smtp-Source: AGHT+IHXLsAgSG9w/GUn/MPI8eVfTf9kMnXtW+OovitNx8r9KRxFHjY8CcPSVQin6u11GCpirMneeQ==
X-Received: by 2002:a05:6808:10cb:b0:3d5:6277:77b with SMTP id 5614622812f47-3def3bf1047mr17263b6e.12.1724687002961;
        Mon, 26 Aug 2024 08:43:22 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3de2258173fsm2046106b6e.33.2024.08.26.08.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 08:43:22 -0700 (PDT)
Message-ID: <93c94dfc-2121-4b7d-b069-8b6ce22290fb@gmail.com>
Date: Mon, 26 Aug 2024 10:43:21 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
 <CAG17S_NjMwU4=qn_jJzUJwPEOTT1H-SPVb7Re0P4fyPNUg=WqA@mail.gmail.com>
 <f36d03e4-e85a-438e-adef-b6c2da0c8f72@gmail.com>
 <CAG17S_P615tCPt0Jy+-BLzFx0N9JiksVXdUj4-iRAA9JTWdotg@mail.gmail.com>
 <CAG17S_Oe0_DnVZW32GrArC9XCQUHh3QEYXxvXatWQiuwV5_QkA@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_Oe0_DnVZW32GrArC9XCQUHh3QEYXxvXatWQiuwV5_QkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

>>
>> iwctl looks like it is trying something:
>> [iwd]# station wlan0 connect deskSAE
>> Type the network passphrase for deskSAE psk.
>> Passphrase: *********
>> [iwd]#
>>
>> but it never connects. I do notice that connman thinks it is up and
>> assigns a 169.254.x.x address
>>
>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Network
>> is WPA3-Personal...
>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver:
>> brcmfmac using SAE.  Expect EXTERNAL_AUTH
>> Aug 24 11:18:06 pi5 iwd[28085]:
>> src/network.c:network_generate_sae_pt() Generating PT for Group 19
>> Aug 24 11:18:06 pi5 iwd[28085]:
>> src/network.c:network_generate_sae_pt() Generating PT for Group 20
>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_select_akm() Network
>> is WPA3-Personal...
>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, FullMAC driver:
>> brcmfmac using SAE.  Expect EXTERNAL_AUTH
>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_cqm_rssi_update()
>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_insert()
>> Inserting work item 4
>> Aug 24 11:18:06 pi5 iwd[28085]: src/wiphy.c:wiphy_radio_work_next()
>> Starting work item 4
>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, ssid: deskSAE,
>> bss: d8:3a:dd:60:a3:0c, signal: -63, load: 0/255
>> Aug 24 11:18:06 pi5 iwd[28085]: event: state, old: autoconnect_full,
>> new: connecting
>> Aug 24 11:18:06 pi5 iwd[28085]: src/scan.c:scan_periodic_stop()
>> Stopping periodic scan for wdev 1
>> Aug 24 11:18:06 pi5 iwd[28085]: CMD_SET_CQM failed: Operation not supported
>> Aug 24 11:18:06 pi5 connmand[635]: Interface wlan0 [ wifi ] state is
>> configuration
>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
>> Unicast notification External Auth(127)
>> Aug 24 11:18:06 pi5 iwd[28085]: event: connect-info, External Auth to
>> SSID: deskSAE, bssid: d8:3a:dd:60:a3:0c
>> Aug 24 11:18:06 pi5 iwd[28085]:
>> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() MLME
>> notification Frame TX Status(60)
>> Aug 24 11:18:06 pi5 iwd[28085]:
>> src/netdev.c:netdev_external_auth_sae_tx_authenticate()
>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
>> Unicast notification Frame(59)
>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_mlme_notify() MLME
>> notification Frame TX Status(60)
>> Aug 24 11:18:06 pi5 iwd[28085]:
>> src/netdev.c:netdev_external_auth_sae_tx_associate()
>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_unicast_notify()
>> Unicast notification Frame(59)
>> Aug 24 11:18:06 pi5 iwd[28085]: src/netdev.c:netdev_external_auth_cb()
>> Failed to send External Auth: Invalid exchange(52)

You're seeing the exact broken behavior I'm seeing.  To summarize:

- IWD issues CMD_CONNECT
- Firmware/Kernel sends CMD_EXTERNAL_AUTH to iwd
- IWD performs SAE handshake using CMD_FRAME successfully
- IWD sends CMD_EXTERNAL_AUTH with a success status_code to kernel/firmware
- Kernel/Firmware rplies with error 52, Invalid Exchange.

>> Aug 24 11:18:06 pi5 kernel: ieee80211 phy0:
>> brcmf_cfg80211_external_auth: auth_status iovar failed: ret=-52
>> Aug 24 11:18:46 pi5 connmand[635]: Interface wlan0 [ wifi ] state is ready
>> Aug 24 11:18:46 pi5 connmand[635]: wlan0 {add} address
>> 169.254.242.107/16 label wlan0 family 2
>>
>>
>> Need a log of some sort or is this adequate?

No.  We need someone who can tell us how this firmware is supposed to operate. 
Perhaps Arend can help?

Regards,
-Denis
