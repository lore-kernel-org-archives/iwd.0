Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926CBE565
	for <iwd@lists.linux.dev>; Mon,  1 Jan 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuCB7p7A"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da202aa138so2505774b3a.2
        for <iwd@lists.linux.dev>; Mon, 01 Jan 2024 15:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704150241; x=1704755041; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Izfptyk98bsU7i3Pc9P3SqG3NYUoIKbtHieCCEDXuBo=;
        b=fuCB7p7Ahdx0RMG/iILy6BWgOks4wXDsm6jE/4ZdQkbKHVSZchto7tmaDu7x/sgwsl
         5n9/KMxNl9eb296PCclFmADx9dxwir6DpoKeQJA6Z7WujOp1L79T5o+UW8vkMOH3KaVH
         k4JUo5FY6migQCEWJUOYD4GUX+zLEAfDw5WJ62tno5uo8LQ9Yk3YInMXK4y2f5njNOmT
         hkQHLXjMUYQLwwH3Zeze+4a8O7s/KpuVOx75p2a66FayfZ9MWOenZR4E27lQWuJDNa1h
         G+zSsOMHOckTk/GZ3J3eA5ATPGV31Svhfl7uigXEc1lzypfjKilrwL7IMw17HPO5MIue
         cdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704150241; x=1704755041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Izfptyk98bsU7i3Pc9P3SqG3NYUoIKbtHieCCEDXuBo=;
        b=VOegI7hjgw5IlTyVu/n4BT8T1gs3uwAE1VdSi1qcApVWUN0R5T8LPnGp5OhM1i6R7W
         aYlmmkDzWHIyJNQY3Xn0BT9wKGqas2K0wT2Rylumxlu8t0odm/9gaLisHk/9CnHSbbk9
         llvOKi7r7w7xbc2hJ311L9GbG7jy+l1f7EKp9RU0GCGT8A0RJcu/k7TShsKIZmWoklSI
         k4Vno3aiebw3Av7UsYC3s/XJxvVa9wNWnHOn1Vd6WNHG1JdsceBOMQDbkEYBkBZXQCUb
         vFRshnNsyyU4zdJYjQb796hiAC0sfSatCBSO8KbGTgJ2nABsQl76zZ8dhPqMoGu9+Ers
         pJWA==
X-Gm-Message-State: AOJu0YzJh7m4Mmnd7xtNLUDcRweEFF+Q7KZG4cS7viW+I/pCba1cHHNY
	qzL1eBJvFGVlAP4gE/gHFxnxOHesQjE=
X-Google-Smtp-Source: AGHT+IGmMG4grcjNb8fIDQS90jZpc0/eN0oPeZi77feH7QyUFs8XcHdmtj2qVwsK3j8EjVGu+MubaQ==
X-Received: by 2002:a05:6a00:1892:b0:6d9:b960:3bf1 with SMTP id x18-20020a056a00189200b006d9b9603bf1mr19995226pfh.29.1704150240677;
        Mon, 01 Jan 2024 15:04:00 -0800 (PST)
Received: from [192.168.254.38] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id c12-20020a62e80c000000b006d5929810a6sm14769672pfi.83.2024.01.01.15.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 15:04:00 -0800 (PST)
Message-ID: <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
Date: Mon, 1 Jan 2024 15:03:59 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setup help request
To: Mauro Condarelli <mc5686@mclink.it>, iwd@lists.linux.dev
References: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mauro,

On 1/1/24 11:26 AM, Mauro Condarelli wrote:
> Hi,
> I just installed `IWD version 2.3` on a small MiniPC (Beelink, if it 
> matters) sporting a
> `Intel Corporation Wireless 3165 (rev 81)` PCI Wireless adapter.
> O.S. is a fairly up-to-date "Debian GNU/Linux 12 (bookworm)"
> Installation was done via standard Debian package (`apt install iwd`)
> I am trying to use it as Access Point (infrastructure).
> I have in my config:
> ---------------------------------
> root@lxd:~# cat /etc/iwd/main.conf
> [General]
> EnableNetworkConfiguration=true
> #AddressRandomization=network
> #RoamThreshold=-70
> #RoamThreshold5G=-76
> [Network]
> #NameResolvingService=resolvconf
> #
> #EnableIPv6=true
> ---------------------------------
> root@lxd:~# cat /var/lib/iwd/ap/beelink.ap
> [Security]
> Passphrase=****************
>
> [IPv4]
> Address=192.168.250.1
> Gateway=192.168.250.1
> Netmask=255.255.255.0
> DNSList=8.8.8.8
> LeaseTime=3600
> IPRange=192.168.250.200,192.168.250.209
> root@lxd:~#
> ---------------------------------
>
> I am testing manually so I did:
>
> ---------------------------------
> root@lxd:/etc/systemd/network# /usr/libexec/iwd -d >/tmp/iwd.log 2>&1 &
> [1] 112842
> root@lxd:/etc/systemd/network# iwctl
> NetworkConfigurationEnabled: enabled
> StateDirectory: /var/lib/iwd
> Version: 2.3
> [iwd]# device list
> Devices                                   *
> -------------------------------------------------------------------------------- 
>
>   Name                  Address               Powered Adapter Mode
> -------------------------------------------------------------------------------- 
>
>   wlan0                 84:c5:a6:4c:ff:31     on phy0        ap
>
> [iwd]# device wlan0 set-property Mode ap
> [iwd]# ap wlan0 start-profile beelink
> [iwd]# ap wlan0 show
>                              Access Point Interface
> -------------------------------------------------------------------------------- 
>
>   Settable  Property              Value
> -------------------------------------------------------------------------------- 
>
>             Started               yes
>             Name                  beelink
>             Scanning              no
>             Frequency             2437
>             PairwiseCiphers
>             GroupCipher           CCMP-128
> [iwd]#
>
> [iwd]#
>
> root@lxd:/etc/systemd/network#
> ---------------------------------
>
> Sometimes I can see a "beelink" SSID with Fritz sniffer app
> or even from my desktop, but I was never able to connect.

In the logs you see "Frame didn't validate as MMPDU". This means there 
was a malformed packet, or at least IWD thinks it was malformed. Could 
you get an iwmon capture while IWD is running and you attempt to connect 
with a client device? Also, have you tried connecting with several 
client devices (laptop, phone, etc)? That would tell us if its a 
specific client sending a bad frame, or a bug processing the frame. More 
info on how to do that here:

https://iwd.wiki.kernel.org/debugging

Note the capture will contain your devices MAC/SSID/PSK so if your 
worried about privacy you can send it just to me, or use a dummy 
passphrase just for the test, up to you.

>
> I attach logs I am unable to interpret.
>
> Any hint about what to check/change would be very welcome as
> I'm completely out of my depth here.
>
> Target would be to have (if at all possible, of course) a dual band 
> (2.4G/5G)
> bridged Access Point.

Just a side note here, for a dual band access point you will actually 
need two separate adapters.

>
> Many Thanks in Advance.
> Mauro
