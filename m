Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376016131
	for <iwd@lists.linux.dev>; Tue, 30 Aug 2022 22:53:41 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso2458386pjv.0
        for <iwd@lists.linux.dev>; Tue, 30 Aug 2022 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc;
        bh=6iXAQWXyP5gvs/H2cSeva7qnXc31j96adKsaLaNB7x8=;
        b=DqZpWt16ELChkrXxSdvmpS4DaA6pXScl+tqlko516oE6vTKXzOOFjsuohVuJoOiy6H
         5ricnITxFjloKFjcewNjSDyUw4ZJlUHTh4DzYlynd1lYp2gtt+wWiQMqxkrgkFIThdWS
         gsyUbXXcgqoWZ2qP7/tVs6y3Tpjtd/Frfteep508e3nz8TQYP0+FrPLbFsv89m0hDX9p
         pZzcEMfw7KFLJ4Zct2a6Tllssis4cimaJPe8vuReyMSMt9rHoNVW11fgsyrAFey8H/ul
         kvcpWra3mq39mKenWg2+Hc8Ml+gArRdvXnsvhWREMFh0BNlcVEhMntuPCbAxL8XCiI9l
         6cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=6iXAQWXyP5gvs/H2cSeva7qnXc31j96adKsaLaNB7x8=;
        b=EgE75TtmQjNRJIZSxq6WvCsslXpOw1P0zwco4yreuBnpdVCeaJxTCxYfzKVeMX75cA
         BVkXmSZ+OKF/sd3R6Ud+272ibPYfrQtATZpaHjK9QS6VZkVk8CDdIOyusu89bBCADfe6
         HpJ4F5f78vXp44XrZMGD2Ka8zIkjiTTJHIpaG0AaMJl4yl7SpeKbN1nuQfgceOQD99BD
         oRbXBfaxonuK4yRDgdD2T4O1VpCk7wXPEkLbHb7UP/6C5YfMPk2JWN6SobVe3tFHlSBJ
         ULKmuFzeJ0Dlnip4qXF8sDcsNbAkw1xXovKZAssp6swAW8AuLZMKpWuQwOOBJwZYHrSV
         H4Sg==
X-Gm-Message-State: ACgBeo3NAFdz5oJ3d2+2iz1rWM1HaMCnEEzJtwMfHMOU/tPKE/3Hc/Oz
	KHo9X3MpKmRtV40OZl45hxfWhahdMas=
X-Google-Smtp-Source: AA6agR6MHx8XmeOrZ4atIn8i86jJArRFrcnskrIbdxKe+1d2CZl6xz2b7njSH58wMSxNgnU00hG2XQ==
X-Received: by 2002:a17:90a:588c:b0:1fd:a1bc:ff71 with SMTP id j12-20020a17090a588c00b001fda1bcff71mr278449pji.134.1661900020628;
        Tue, 30 Aug 2022 15:53:40 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id z5-20020a623305000000b005251f4596f0sm9856968pfz.107.2022.08.30.15.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:53:40 -0700 (PDT)
Message-ID: <f66462932dacecb2231bf356770165309c49beab.camel@gmail.com>
Subject: Re: Cannot turn on AP mode without any error message
From: James Prestwood <prestwoj@gmail.com>
To: Chang Liu <goduck777@gmail.com>, iwd@lists.linux.dev
Date: Tue, 30 Aug 2022 15:53:39 -0700
In-Reply-To: <2031ff9c-0fff-18f7-2ad7-860e2b51ee22@gmail.com>
References: <2031ff9c-0fff-18f7-2ad7-860e2b51ee22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 2022-08-31 at 07:40 +0900, Chang Liu wrote:
> 
> Hello,
> 
> I am having some trouble using the AP mode with iwd on my laptop. I 
> followed the instructions at https://iwd.wiki.kernel.org/ap_mode.
> After 
> I run "ap wlan0 start-profile test", there is no error message, and
> the 
> debug info shows that the device has been turned into AP mode. But I 
> cannot find this network using my other devices like cell phone.
> 
> I tried to switch to wpa_supplicant and the AP mode worked well. I
> tried 
> to use the same Channel in iwd and nothing changed. The laptop is
> Dell 
> XPS 13 and the wifi adapter is Qualcomm Atheros QCA6174 802.11ac 
> Wireless Network Adapter (rev 32).
> 
> I have tried "iwd -d" and iwmon and couldn't find any useful 
> information. If someone can point out where to check then I will be
> glad 
> to follow.

I would still post the debug logs here, and the AP profile (with the
password redacted if you wish). If you have the iwmon logs too, might
as well include those.

Thanks,
James

> 
> Thanks
> 
> Chang
> 


