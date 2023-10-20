Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552E1BDC5
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwHhY7nr"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so722021b3a.1
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697809682; x=1698414482; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jwcvPXDkNloHAxOTIl1lHW0ybxgi2yXY7gzPjRE7O0=;
        b=OwHhY7nrMRpCY56ncqU68nGbmwOqBQYh9gLZytp2nOKCaKLlTARuL5vM/blLsYZFyY
         eEEvqq0TMFnWTXTg1J6AiJ9n+4Gh8MMQXbS/1cHws7kI4RSo1Ms04IXOYnP7FhDfPMZ/
         QDTbt88xf7xtCibnGWypW1uMtipE1NyrALrfxhFL+TrDKKM9XMw8TODtMVk3rYjSxzyE
         7LZ5AhjOQS6lbDcHHEQNq+Ufl7rWRK2tkBIGo4oYLeu8c+v9blcjxbaHn8wqIHWRDa7B
         wwUnZwvMh3eL4Gzjg13Lk7bMv60Et2pTWWFaU3z2pFWsAApkpaHFh9oS/rQiuA+4loln
         iYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809682; x=1698414482;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jwcvPXDkNloHAxOTIl1lHW0ybxgi2yXY7gzPjRE7O0=;
        b=vR9gSDAw/3Zv3IpyVddcq48C7/QJSPx+CWD5yJazlt48XB6gZqA3Gw1l5NyLXNwQZL
         HECOEDYv5t7TU8iLEKS6B5HJ39QyOHh6vMviNLCc7dZ1ddjL0mWsQFveufysMiUq9ybu
         u5NRJrLX0/KUqUkzKDEw+yDbIOhTGEM2tZ9BN0nc4tq55Mh5v3Olu2zGEvo7hcjjsrua
         nT3+LxBDtbekme1AZZimTnPHRucfEeZ1wg3LA2h4Y8cD4f8l4yjDlC9A+GmSEor6dV9d
         LRSs+kh3Ozel/Q9gwGG2Ga40saJyueBZfn4bXPayW39mKJPeNDzhWgMeXz2EY9kljtXR
         MPpw==
X-Gm-Message-State: AOJu0YwKiiMni4IG8v+1arxSlYKUzeoP58Fr+be5CbGSBae4GbeNrxe3
	w70c9TOdnjgJLaKPBagshNmHtkE8csQ=
X-Google-Smtp-Source: AGHT+IH9oIJ2vrucxuH29Rh/R/9QEDkAq1B2zzZAfOr35U/LcgJwiQs2xyE0zXIsjH4VFyckfMoZlw==
X-Received: by 2002:a05:6a20:2451:b0:161:3120:e888 with SMTP id t17-20020a056a20245100b001613120e888mr2046374pzc.46.1697809681946;
        Fri, 20 Oct 2023 06:48:01 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id g8-20020a63e608000000b0058d26647e45sm1462141pgh.54.2023.10.20.06.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 06:48:01 -0700 (PDT)
Message-ID: <31c28e84-f3a7-4fb4-8ff3-a543c62bf2c2@gmail.com>
Date: Fri, 20 Oct 2023 06:48:01 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwctl interactive mode error
Content-Language: en-US
To: daniel antoine <univac55@gmail.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <CA+iibzCp0HZwBsoGM7i4k8v86JJWoDC7UDrEMsnqOoezKLcnyg@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CA+iibzCp0HZwBsoGM7i4k8v86JJWoDC7UDrEMsnqOoezKLcnyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 10/20/23 6:37 AM, daniel antoine wrote:
> Hi gents
> 
> After compiling iwd at the last commit I have tried to see the status
> of the network with the iwctl command. When I launch the command i
> have thisantoine@grat-os1:~$ iwctl
> 
> Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
> [iwd]# NetworkConfigurationEnabled: disabled
> [iwd]# [iwd]# StateDirectory: /var/lib/iwd
> [iwd]# [iwd]# Version: 2.8
> [iwd]#
> 
> The prompt [iwd]# is repeated several times and when I try to enter a
> command I got this message
> Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
> [iwd]# NetworkConfigurationEnabled: disabled
> [iwd]# [iwd]# StateDirectory: /var/lib/iwd
> [iwd]# [iwd]# Version: 2.8
> [iwd]# station list
> bck:sta
> 
> if I force the command it's worse
> Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
> [iwd]# NetworkConfigurationEnabled: disabled
> [iwd]# [iwd]# StateDirectory: /var/lib/iwd
> [iwd]# [iwd]# Version: 2.8
> [iwd]# station list
> [iwd]# s[iwd]# s                            Devices in Station Mode
>                         *
> [iwd]# s[iwd]# s----------------------------------------------------------------------------------------------------
> [iwd]# s[iwd]# s  Name                  State            Scanning
>           ing
> [iwd]# s[iwd]# s------------------------------------------------------------------------------------------------
> [iwd]# s[iwd]# s  wlan0                 connected
> [iwd]# s[iwd]# s
> [iwd]# s[iwd]# s[iwd]# s[iwd]# s stati[iwd]# stati
> 
> It looks like the tab is active all the time and tries to send
> commands repeatedly . The screen is garbled and there is a click at
> each tab
> 
> The result of a help command
> [iwd]# helpd]# s[iwd]# s[iwd]# s stati[iwd]# stati
> [iwd]# [iwd]#
> [iwd]# [iwd]#                                iwctl version 2.8
> [iwd]# [iwd]# --------------------------------------------------------------------------------
> [iwd]# [iwd]#   Usage
> [iwd]# [iwd]# --------------------------------------------------------------------------------
> [iwd]# [iwd]#   iwctl [--options] [commands]
> [iwd]# [iwd]#
> [iwd]# [iwd]#                                Available options
> [iwd]# [iwd]# --------------------------------------------------------------------------------
> [iwd]# [iwd]#   Options                                             Description
> [iwd]# [iwd]# --------------------------------------------------------------------------------
> [iwd]# [iwd]#   --username
> Provide username
> [iwd]# [iwd]#   --password
> Provide password
> [iwd]# [iwd]#   --passphrase
> Provide passphrase
> [iwd]# [iwd]#   --dont-ask
> Don't ask for missing
>                                                credentials
> [iwd]# [iwd]#   --help                                              Display help
> [iwd]# [iwd]#
> [iwd]# [iwd]#                                Available commands
> [iwd]# [iwd]# --------------------------------------------------------------------------------
> [iwd]# [iwd]#   Commands                                            Description
> [iwd]# [iwd]# --------------------------------------------------------------------------------
> [iwd]# [iwd]#
> Adapters:
> [iwd]# [iwd]#   adapter list
> List adapters
> [iwd]# [iwd]#   adapter <phy> show
> Show adapter info
> [iwd]# [iwd]#   adapter <phy> set-property <name> <value>           Set property
> [iwd]# [iwd]#
> Ad-Hoc:
> [iwd]# [iwd]#   ad-hoc list
> List devices in Ad-hoc mode
> [iwd]# [iwd]#   ad-hoc <wlan> start <"network name"> <passphrase>
> Start or join an existing
> [iwd]# [iwd]#
> Ad-Hoc network called "network
> [iwd]# [iwd]#
> name" with a passphrase
> [iwd]# [iwd]#   ad-hoc <wlan> start_open <"network name">
> Start or join an existing open
> [iwd]# [iwd]#
> Ad-Hoc network called "network
> [iwd]# [iwd]#                                                       name"
> [iwd]# [iwd]#   ad-hoc <wlan> stop
> Leave an Ad-Hoc network
> [iwd]# [iwd]#
> Access Point:
> [iwd]# [iwd]#   ap list
> List devices in AP mode
> [iwd]# [iwd]#   ap <wlan> start <"network name"> <passphrase>
> Start an access point called
> [iwd]# [iwd]#
> "network name" with a
> [iwd]# [iwd]#                                                       passphrase
> [iwd]# [iwd]#   ap <wlan> start-profile <"network name">
> Start an access point based on
> [iwd]# [iwd]#                                                       a
> disk profile
> [iwd]# [iwd]#   ap <wlan> stop
> Stop a started access point
> [iwd]# [iwd]#   ap <wlan> show                                      Show AP info
> [iwd]# [iwd]#   ap <wlan> scan
> Start an AP scan
> [iwd]# [iwd]#   ap <wlan> get-networks
> Get network list after
> [iwd]# [iwd]#                                                       scanning
> [iwd]# [iwd]#
> Devices:.......
> 
> I am able to launch the command in non interactive mode without problem
> antoine@grat-os1:~$ iwctl ap list
>                            Devices in Access Point Mode
> --------------------------------------------------------------------------------
>    Name                  Started
> --------------------------------------------------------------------------------
> No devices in access point mode available.
> CY^E
> antoine@grat-os1:~$ iwctl dpp list
>                                DPP-capable Devices
> --------------------------------------------------------------------------------
>    Name
> --------------------------------------------------------------------------------
>    wlan0
> ^T^XA\^E
>   but there is strange characters at the end of the command display
> 
> There are no compilation errors. I send you my Pkgfile for iwd. I have
> tried to test with version 2.7 and it's the same.
> 
> Libedit has been upgraded to version 20230828-3.1 I don't know if it
> is related to.

Could you try with libreadline? I never tested with libedit when it was 
added, the packages were too old and didn't compile and I didn't bother 
building from source since others said it worked. I've never seen such a 
problem myself with libreadline.

> 
> Best regards
> 
> Daniel
