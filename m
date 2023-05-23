Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F041C750
	for <iwd@lists.linux.dev>; Tue, 23 May 2023 13:17:06 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2555076e505so2521306a91.0
        for <iwd@lists.linux.dev>; Tue, 23 May 2023 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684847826; x=1687439826;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWKcdG7xBquxS/VJlCZKc9TAMo1PeFGZHaSN0ZXrE8Q=;
        b=djrOHNyYQRl6rXBkQKdyVu1cO2J8bzgxNn9/hVzMaU1MDBoGiH7Z8dFU6BT8JCDPKc
         +1eVLFSfcxHwISN4yrdgYlE6PBQjtxl1LyrMf7i1i+wrbMPE4mTpfP9gY++iWKj3/wGT
         blfzrsA1ipQVKvqtOcc7Hy8r0gHNDISQOPfXwtYRQzoZ3b+qlCPsgW0Ej3wMKRo5dX0T
         uA6ux/rSvaJva5upmYXZJxiJo3iMWQyhNNBUEEeJUyrm5/Sd6LXVXyw5zKHDNvCMF/gJ
         zGqn3SY2pxuMfX71ICmrUY7MGgVssb+SPQkcDZ/NIEA3jdDBxEzCPmpgQM9Lvyg1oyuP
         t5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684847826; x=1687439826;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWKcdG7xBquxS/VJlCZKc9TAMo1PeFGZHaSN0ZXrE8Q=;
        b=jDuRs8PO8fDa5R62n0TOYfnVX9+dxI2PB7lNFhqAR1EyAsDLEXqlUveT2NYWAc8ASC
         YnJN8aRtjosMLI0yEiWFg9y462paMXDPaZZi7MfOr+urZdWJ9+qU6PX2Uoe81C4jhNss
         mSnoBLYM2lYkella4Ct0VdU2SLbEw96wMY24dORodULTbY+CtzI+TywI3QVRW3mmI+l/
         NVTDP6hPdZGQSjTD1pnROk0W6jniWw8YAWtKifMVQNE9njZeSlETolIQe4UyY+z4SznG
         JxoT68gbSUtBAaum+gElTO8IyAEJo+4vdmON1n47drIAVMzqCS6o/t6B0mmjo71gxEwR
         Xnbg==
X-Gm-Message-State: AC+VfDw+TLdYlYkq9UA2b/RdZX5CQpkbX+hsgQpfMFqyGXk3g2LU/35m
	lmWbv7E6K1oTGRHH0cM8M7QZ5Wwoj/Wzyw==
X-Google-Smtp-Source: ACHHUZ7dJhAteD7CYmrh3Vv6jucMa/FXSynkcmiH7qXF9pbCycpJWkS7YtGW4bt+mFY8ve0FxZZipQ==
X-Received: by 2002:a17:90a:e016:b0:255:614a:7fae with SMTP id u22-20020a17090ae01600b00255614a7faemr6109933pjy.20.1684847826284;
        Tue, 23 May 2023 06:17:06 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id ft17-20020a17090b0f9100b00246f9725ffcsm5719189pjb.33.2023.05.23.06.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 06:17:06 -0700 (PDT)
Message-ID: <36865aa6-6eb4-2ba3-7a7d-fa028accdd8f@gmail.com>
Date: Tue, 23 May 2023 06:17:05 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Unable to connect to a EAP-PEAP network
Content-Language: en-US
To: Florian Coste <florian.coste@nairwolf.net>, iwd@lists.linux.dev
References: <43a3d110-4e6d-f50c-be66-3bf1d0499983@nairwolf.net>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <43a3d110-4e6d-f50c-be66-3bf1d0499983@nairwolf.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Florian,

On 5/23/23 5:50 AM, Florian Coste wrote:
> Hello,
> 
> I'm trying to setup a wireless connection to a EAP-PEAP network. My 
> company gave me this picture as the only documentation available, so I'm 
> trying to replicate this NetworkManager GUI setting that you can find 
> here: https://i.imgur.com/KB38bDr.png
> 
> Basically, it should be:
> * Authentication EAP-PEAP
> * No certificate
> * Inner authentication: MSCAPV2
> 
> The SSID of the network I'm trying to connect is called "Company 
> France", so I have a file located at "/var/lib/iwd/Company 
> France.8021x". There is a space in the SSID but I belive it should not 
> cause any issue as soon as the file name and the SSID is matching.
> 
> Here's the .8021x config file I'm using: 
> https://iwd.wiki.kernel.org/networkconfigurationsettings#eap-peap_with_tunneled_eap-mschapv2
> 
> In case I made a mistake by copying/pasting the config, I've pushing 
> what I'm using here: http://ix.io/4ww1
> 
> I'm launching iwd in debug mode and I see two issues I'm unable to 
> understand.
> 
> First, when I'm writing the file, I have the following error: "Error 
> loading /var/lib/iwd//Company France.8021x". Is there a typo somewhere, 
> the log doesn't explain why the file couldn't be loaded. Here's the full 
> log: http://ix.io/4wvU

If you're able to start a connection below the file must be ok now?

> 
> Second issue I have is when I'm trying to connect to this SSID. In the 
> config file, I don't have username and password set, so iwd ask me them 
> when I'm trying to connect.
> 
> Then I have this error: EAP negotiation stopped after the Identity 
> exchange, this can happen when the EAP-Identity value is not what the 
> authenticator expects

Did you try uncommenting/setting the EAP-Identity? In the past other 
users have noticed that some RADIUS servers require this to be set.

Thanks,
James

> 
> You can find complete logs here: http://ix.io/4wvX
> 
> Could you help me to understand what's going on ? My first intution is I 
> have a dubious typo in the 8021x file but I'm unable to find it.
> 
> Thanks for your help in advance.
> 
> 
