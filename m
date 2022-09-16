Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEE210D
	for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 14:40:35 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-127dca21a7dso52362466fac.12
        for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2WmvCCFxBCPHfnURB/5tRr88zc2tiwOKFJTibEBhkYk=;
        b=GSmuBqKDULV6CO3+PHWvZfTPYK/7UwJs1QaZq9qF+d3o6GG89EvoPVimTkoyB5LNRR
         aopjOALf4Emq/CFtPjKsy0qJyFI72RdYm1mSINkHSZwaHfCcLMl7oiQMmT6CveWntSRS
         rK03LQ+P1irgKmtEuzMO2Papw2NgsNkYNCy2SAlE0S7zjLScoptqivh8idr2n7A0IW6I
         3BuZCGjewnQjq5RX6mmPeEqCydZffc6/lPKXfuMcnZ2t0/e1f5KRgwnFRiQwCo5TLjV4
         FuN7EjHS5J98WDV/xSRltgHLubfYdbfql0C4Inr8CI3BikuffdzRW/nYDrfwHyci1nrd
         OoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2WmvCCFxBCPHfnURB/5tRr88zc2tiwOKFJTibEBhkYk=;
        b=mbAKM00rqlH0qf+D1iuRAmgVSp3WmQ+Rf8gX0k+kE9U8egeCXp6/GseiScaK3KI5cX
         y9AwmFf+OgQZGgQlVkQuRASFMbS4Y+ud3SKDmdE4ZsAfnWdkwnoy5BfsNj97+CACC5+K
         WbEJo+bs3tHaSy+MTL3y5A0tIH2O32sAIMfrdtUbqdF8fMyAi9R4+VEtW76CW9huNMmr
         UF/V9SudOQ54LUSIjLtOgGC6dDZGkRXKNaFl6Oc3v7YA7NN7m2RTB8ArfWJWq5UE/ziE
         gAUiv/IuPuJ9JWKoizxw8pjLDtmdLWWFttpI+SfYgdry8ocLUPkVAfW6U+teT96ud88m
         O4Ng==
X-Gm-Message-State: ACgBeo21I+1Zt2hkPn6v17oeht/ViZTJxn1k4p+zCK45vNs5WJmZtmrm
	trPgf4Zl6qZYUZiujgmuI/9zwKgVJxI=
X-Google-Smtp-Source: AA6agR7axQduVA+3epy3U9MC3Tbu6wqGkyShY96DvxE8UdZkIh08pQ8Kj5R06YHacJumTbFIndjSTg==
X-Received: by 2002:a05:6870:2499:b0:101:7531:c7ec with SMTP id s25-20020a056870249900b001017531c7ecmr8847424oaq.42.1663339234694;
        Fri, 16 Sep 2022 07:40:34 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v15-20020a056870424f00b001274d5999c2sm2894487oac.31.2022.09.16.07.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 07:40:34 -0700 (PDT)
Message-ID: <19fd781d-a60c-81f2-4814-da4b2097e4c3@gmail.com>
Date: Fri, 16 Sep 2022 09:28:11 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: 1.30 fails to connect to some APs
Content-Language: en-US
To: Sebastien Bacher <seb128@ubuntu.com>, iwd@lists.linux.dev
References: <6f1b3f13-a261-a917-1439-3f17908a7f81@ubuntu.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <6f1b3f13-a261-a917-1439-3f17908a7f81@ubuntu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastien,

On 9/16/22 06:32, Sebastien Bacher wrote:
> Using iwd 1.30 on Ubuntu Kinetic, I've some APs my laptop fails to connect to
> 
> I'm including a log from 'iwd -d' while trying to connect using
> 
> $ sudo iwctl station wlan0 connect <APNAME>
> 
> The log states
> 
> 'wiphy_select_akm() Network is WPA3-Personal...'
> 

So if we select WPA-Personal, the AP most likely is configured like this. 
Perhaps it is in WPA3 Transition mode where both WPA2 and WPA3 AKMs are enabled. 
  Hard to say without seeing the detailed iwmon (preferably) or iw scan result 
output.

> But iwlist states 'IE: IEEE 802.11i/WPA2 Version 1' and using wpasupplicant 

Note that iwlist isn't WPA3 aware [1].

> works fine and network-manager also flags it as WPA2, could it be that iwd 
> wrongly detect the authentification to use?

Dunno about NM/wpa_s.  But your AP is certainly acting like a WPA3 AP.  From 
your log:

src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
src/netdev.c:netdev_authenticate_event()
src/sae.c:sae_verify_packet() rx trans=1, state=committed

<--- We receive an SAE (WPA3) reply packet from the AP

src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
src/netdev.c:netdev_authenticate_event()
src/sae.c:sae_verify_packet() rx trans=1, state=committed

<---- And again here

src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
src/netdev.c:netdev_authenticate_event()
src/sae.c:sae_verify_packet() rx trans=2, state=confirmed

<---- And looks like we do not consider the confirm reply valid (?)

Can you tell us more about the AP? Do you have any way of obtaining logs from it 
by any chance?  Does 'iw dev <foo> scan' results for your AP list any Vendor 
IEs?  Note that iwd uses P384 curves for SAE by default (for higher security). 
Some older WPA3 implementations implement the spec poorly when curves other than 
P256 are used.

Also, it might be useful for us to look at the iwmon output.  See [2].  Start 
iwmon just prior to iwctl 'station <device> scan' and 'station <device> 
connect...'  Feel free to send the output to me directly if there are any 
privacy concerns.

[1] 
https://github.com/HewlettPackard/wireless-tools/blob/master/wireless_tools/iwlist.c#L301
[2] https://iwd.wiki.kernel.org/debugging#iwmon

Regards,
-Denis
