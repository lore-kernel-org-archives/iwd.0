Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AFD51817
	for <iwd@lists.linux.dev>; Thu,  1 Jun 2023 18:34:38 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-3f6c6020cfbso8796651cf.2
        for <iwd@lists.linux.dev>; Thu, 01 Jun 2023 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685644477; x=1688236477;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KChwdf1k5oHB0sh0a6td7ZQg3V5XofcMJWo4knJz8io=;
        b=SVVVCUymm3TKnLTHzkikv3HexNA3NvCH4u7QhFx8oDTBl+z1KBP+HThTxjDHQgcGmF
         C/2ihFm3GKcl3J+VFHKDgq+5yc7nJOnzH/gEDz3/S0egJSx6YTzNQWM3YzO0bQq9FXOD
         FTLZVTwtwlVy1b4MsT28+67L0156lSOGK+gM8zkW58dqcqP0w/PSd8oLynW/Ru8TA7t/
         JGVKfMcUJCcfAI+Q24EV/xCeoCesTBzl9YFCAoeH8ifZc0VYi3CNXj1Nyu0swXNHRXtF
         prypj03gZ7tmJsEOoXtK7NS+OmzDaxBdKds7mRVNrwXR8qsgrd2oXWRTMvJIps/col+x
         I6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685644477; x=1688236477;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KChwdf1k5oHB0sh0a6td7ZQg3V5XofcMJWo4knJz8io=;
        b=OXBI3zBeUFQSNs3lcYk35CBeLJGk+wNMshuhAd5hc+Z/sonUkAWGPIDWrbs7TaXDVI
         ZGAe72iBbeTvSGxh9QyLrtCQYzFlc7LYCHxdQ6mdWioQpKFVpbM8ZJ405AERgBfWxAHn
         qWO4FaOGdNb0Euz2AEeYI4YnMkAMQjPsdVkQknxMFFgGQf+5c8rbYRE3ItYf6wi4/44y
         3JhVO+BfG0J+1qRJaltzfaz/s1/zNErdXBxp7Q3sRRDI59h6olf+IcP7q+zsH8JKrbHn
         R3lfMgWFd1qIQB6p/Dkauavv/w+Yt2tiS+Rpp28UE+oJsC/lSpppAfA1SKFDxL0TFWRL
         Qdpg==
X-Gm-Message-State: AC+VfDwhi09LLcFniRK0CkNiLzmH5bg2zuP4nKX+hobVESFE/Fyn+hq1
	8uWUu1ukWM/uu5iT0x1WqaEguWgb2Lk=
X-Google-Smtp-Source: ACHHUZ5qtYhld6pP1XRI9/GyygXFXXmmO92fsMCSd0eM8WGmAGGmOTy/zgxZAc5gtwTXzk6V/Fjc1A==
X-Received: by 2002:ac8:5f4d:0:b0:3f3:8cf1:629c with SMTP id y13-20020ac85f4d000000b003f38cf1629cmr10511794qta.46.1685644477143;
        Thu, 01 Jun 2023 11:34:37 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id x30-20020ac84d5e000000b003f3c9754e1dsm7903297qtv.17.2023.06.01.11.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 11:34:36 -0700 (PDT)
Message-ID: <0909f3d3-3ce0-cbe7-48f2-9b37d5ca4bbb@gmail.com>
Date: Thu, 1 Jun 2023 11:34:34 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: issue using virtual interface with iwd
Content-Language: en-US
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <BY3PR08MB722000E74E402E1C188F35E9AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <0e37cdc7-5d9e-f3b3-eb98-d549d9a69d6f@gmail.com>
 <17dd827c-a2de-b7ec-75de-99d0b17cf6f3@gmail.com>
 <BY3PR08MB7220AB646467DBCE1A4B7433AE499@BY3PR08MB7220.namprd08.prod.outlook.com>
 <eba9839e-55ab-d532-c52f-c58cac465ea1@gmail.com>
 <CO1PR08MB7221B49078929FDBB79773B7AE499@CO1PR08MB7221.namprd08.prod.outlook.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CO1PR08MB7221B49078929FDBB79773B7AE499@CO1PR08MB7221.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

<snip>

>>
>>
> 
> Thanks James, that allowed iwd to preserve and see wlan1 and recognize it as
> an AP.
> 
> ~> iwctl device list
>                                      Devices
> --------------------------------------------------------------------------------
>    Name                  Address               Powered     Adapter     Mode
> --------------------------------------------------------------------------------
>    wlan1                 c0:ee:40:64:4a:1d     on          phy0        ap
>    wlan0                 c0:ee:40:64:4a:1c     on          phy0        station
> 
> ~> iwctl ap list
>                            Devices in Access Point Mode
> --------------------------------------------------------------------------------
>    Name                  Started
> --------------------------------------------------------------------------------
>    wlan1                 no
> 
> 
> My last hurdle appears to be just bringing up an AP.
> 
> ~> iwctl ap wlan1 start "testnet" test123456
> Argument type is wrong

I'd need to see the debug logs, but this could be what others have 
noticed where certain drivers don't like some of the recent AP mode 
changes adding HT capabilities.

Again, don't know for certain without logs, but you could try and work 
around this potentially by using an AP profile:

#file: /var/lib/iwd/ap/testnet.ap
[Security]
Passphrase=test123456

[General]
DisableHT=true

Then, you can start the AP:

$ iwctl ap wlan1 start-profile testnet

> 
> - Michael
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
